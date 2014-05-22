Return-Path: <jolsa@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACF8D1A0593
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 20:00:59 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3DBF314008A
 for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2014 20:00:59 +1000 (EST)
Date: Thu, 22 May 2014 12:00:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug
Message-ID: <20140522100045.GA4789@krava.brq.redhat.com>
References: <20140521012644.GA2890@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140521012644.GA2890@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 michael@ellerman.id.au, Ulrich.Weigand@de.ibm.com,
 Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 06:26:44PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> + *
> + * The value in LR is only needed when it holds a return address. If the
> + * return address is on the stack, we should ignore the LR value.
> + *
> + * Further, when the return address is in the LR, if a new frame was just
> + * allocated but the LR was not saved into it, then the LR contains the
> + * caller, slot 4: contains the caller's caller and the contents of slot 3:
> + * (chain->ips[3]) is undefined and must be ignored.
> + *
> + * Use DWARF debug information to determine if any entries need to be skipped.
> + *
> + * Return:
> + *	index:	of callchain entry that needs to be ignored (if any)
> + *	-1	if no entry needs to be ignored or in case of errors
> + *
> + * TODO:
> + *	Rather than returning an index into the callchain and have the
> + *	caller skip that entry, we could modify the callchain in-place
> + *	by putting a PERF_CONTEXT_IGNORE marker in the affected entry.
> + *
> + *	But @chain points to read-only mmap, so the caller needs to
> + *	duplicate the callchain to modify in-place - something like:
> + *
> + *		new_callchain = arch_duplicate_callchain();
> + *		arch_adjust_callchain(new_callchain);
> + *		...
> + *		arch_free_callchain(new_callchain);
> + *
> + *	Since we only expect to adjust <= 1 entry for now, just return
> + *	the index.

yep, that sounds more clear to me.. something like below?

calling callchain_dup from within arch_adjust_callchain in case
you want to change it and returning != 0 in this case, so
we could free the new callchain

but it might be to much overhead in case you have the support to skip
just one entry now right? is there a plan for more cleaning? ;)

thanks,
jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7409ac8..ec18310 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1279,6 +1279,11 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 	return bi;
 }
 
+struct ip_callchain *callchain_dup(struct ip_callchain *chain)
+{
+	return memdup(chain, sizeof(*chain) + chain->nr * sizeof(u64));
+}
+
 static int machine__resolve_callchain_sample(struct machine *machine,
 					     struct thread *thread,
 					     struct ip_callchain *chain,
@@ -1298,6 +1303,8 @@ static int machine__resolve_callchain_sample(struct machine *machine,
 		return 0;
 	}
 
+	adjusted = arch_adjust_callchain(machine, thread, &chain);
+
 	for (i = 0; i < chain_nr; i++) {
 		u64 ip;
 		struct addr_location al;
@@ -1326,7 +1333,7 @@ static int machine__resolve_callchain_sample(struct machine *machine,
 				 * Discard all.
 				 */
 				callchain_cursor_reset(&callchain_cursor);
-				return 0;
+				goto out;
 			}
 			continue;
 		}
@@ -1350,10 +1357,14 @@ static int machine__resolve_callchain_sample(struct machine *machine,
 		err = callchain_cursor_append(&callchain_cursor,
 					      ip, al.map, al.sym);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return 0;
+ out:
+	if (adjusted)
+		free(chain);
+
+	return err;
 }
 
 static int unwind_entry(struct unwind_entry *entry, void *arg)

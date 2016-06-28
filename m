Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfKvl6ZmgzDqvh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:18:43 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SMDqaX081571
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:18:41 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwnkgv63-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:18:41 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 19:18:38 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 45C133520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:18:18 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5SMIZZM5099748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:18:35 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5SMIZSi001553
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:18:35 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Tue, 28 Jun 2016 19:18:25 -0300
In-Reply-To: <20160628192055.GA3165@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160627202125.GA9230@dhcp-128-65.nay.redhat.com>
 <20160628192055.GA3165@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1495163.EskJqap5EJ@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 28 Juni 2016, 15:20:55 schrieb Dave Young:
> On 06/27/16 at 04:21pm, Dave Young wrote:
> > Please ignore previous reply, I mistakenly send a broken mail without
> > subject, sorry about it. Resend the reply here.
> > 
> > On 06/27/16 at 01:37pm, Thiago Jung Bauermann wrote:
> > > Am Dienstag, 28 Juni 2016, 00:19:48 schrieb Dave Young:
> > > > On 06/23/16 at 12:37pm, Thiago Jung Bauermann wrote:
> > > > > Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> > > > > What is bad about the description of top_down?
> > > > 
> > > > It is not clear enough to me, I personally think the original one in
> > > > source code is better:
> > > > /* allocate from top of memory hole */
> > > 
> > > Actually I realized there's some discrepancy in how the x86 code uses
> > > top_down and how I need it to work in powerpc. This may be what is
> > > confusing about my comment and the existing comment.
> > > 
> > > x86 always walks memory from bottom to top but if top_down is true, in
> > > each memory region it will allocate the memory hole in the highest
> > > address within that region. I don't know why it is done that way,
> > > though.
> > 
> > I think we did not meaning to do this, considering kdump we have only
> > one crashkernel region for searching (crashk_res) so it is fine.
> > For kexec maybe changing the walking function to accept top_down is
> > reasonable.
> > 
> > Ccing Vivek see if he can remember something..
> > 
> > > On powerpc, the memory walk itself should be from top to bottom, as
> > > well as the memory hole allocation within each memory region.
> 
> What is the particular reason in powerpc for a mandatory top to bottom
> walking?

I'm walking unreserved memory ranges, so reservations made low in memory 
(such as the reservation for the initrd) may create a memory hole that is a 
lot lower than the true memory limit where I want to allocate from (768 MB). 
In this situation, allocating at the highest address in the lowest free 
memory range will allocate the buffer very low in memory, and in that case 
top_down doesn't mean much.

Walking memory from lowest to highest address but then allocating memory at 
the highest address inside the memory range is peculiar and surprising. Is 
there a particular reason for it?

If it's an accident and doesn't affect x86, I'd suggest that top_down should
have its expected behavior, which (at least for me) is: allocate from the
highest available memory address within the desired range.

In any case, my patch series allows each architecture to define what
top_down should mean. It doesn't change the behavior in x86, since
the default implementation of arch_kexec_walk_mem ignores
kexec_buf.top_down, and allows powerpc to take top_down into account
when walking memory.

> > > Should I add a separate top_down argument to kexec_locate_mem_hole to
> > > control if the memory walk should be from top to bottom, and then the
> > > bottom_up member of struct kexec_buf controls where inside each memory
> > > region the memory hole will be allocated?
> 
> Using one argument for both sounds more reasonable than using a separate
> argument for memory walk..

I agree. This patch doesn't use a separate top_down argument, it's the same
patch I sent earlier except that the comments to struct kexec_buf are in
patch 2/9. What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


Subject: [PATCH 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.

kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
implementation to find free memory for the purgatory stack.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/kexec.h |  1 +
 kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e16d845d587f..2b34e69db679 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -169,6 +169,7 @@ struct kexec_buf {
 
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
+int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b1f1f6402518..445d66add8ca 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -449,6 +449,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
 
+/**
+ * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
+ * @kbuf:	Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	int ret;
+
+	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -493,11 +510,9 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	kbuf->top_down = top_down;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
-	if (ret != 1) {
-		/* A suitable memory range could not be found for buffer */
-		return -EADDRNOTAVAIL;
-	}
+	ret = kexec_locate_mem_hole(kbuf);
+	if (ret)
+		return ret;
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
-- 
1.9.1

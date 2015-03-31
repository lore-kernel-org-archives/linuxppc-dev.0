Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com
 [216.40.44.121])
 by lists.ozlabs.org (Postfix) with ESMTP id 90B291A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 14:08:09 +1100 (AEDT)
Message-ID: <1427771281.14276.48.camel@perches.com>
Subject: Re: [PATCH v2 08/10] perf/hv24x7: Whitespace cleanup
From: Joe Perches <joe@perches.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 20:08:01 -0700
In-Reply-To: <1427766828-771-9-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1427766828-771-9-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 18:53 -0700, Sukadev Bhattiprolu wrote:
> Fix minor whitespace damages.

If you are going to do whitespace cleaning,
please verify the patches with scripts/checkpatch.pl --strict.

> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
[]
> @@ -1077,7 +1079,6 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
>  	}
>  
>  	resb = &result_buffer->results[0];
> -
>  	*count = be64_to_cpu(resb->elements[0].element_data[0]);
>  out:
>  	return ret;

Does this deletion make the code easier to read?

It might be better just to use:

	be64 val;
	...
	val = result_buffer->results[0].elements[0].element_data[0];
	*count = be64_to_cpu(val);

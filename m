Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63024C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8194320811
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8194320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vj9l6xVkzDqKl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:22:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vj7v1XQ3zDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 11:20:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Vj7t3437z9sSl; Fri, 29 Mar 2019 11:20:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Vj7s5qQvz9sSV;
 Fri, 29 Mar 2019 11:20:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC PATCH 1/3] powernv/mce: reduce mce console logs to lesser
 lines.
In-Reply-To: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
Date: Fri, 29 Mar 2019 11:20:55 +1100
Message-ID: <87bm1uo7iw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mahesh,

Thanks for doing this series.

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Also add cpu number while displaying mce log. This will help cleaner logs
> when mce hits on multiple cpus simultaneously.

Can you include some examples of the output before and after, so it's
easier to compare what the changes are.

I think you have an example in patch 3, but it would be good to have it here.

> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index b5fec1f9751a..44614462cb34 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -384,101 +387,100 @@ void machine_check_print_event_info(struct machine_check_event *evt,
>  		break;
>  	}
>  
> -	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,

I think I'd still like the first line at least to include "machine
check" somewhere, I'm not sure everyone will understand what "MCE" means.

...
> +
> +	if (ea && evt->srr0 != ea)
> +		sprintf(dar_str, "DAR: %016llx ", ea);
> +	else
> +		memset(dar_str, 0, sizeof(dar_str));

Just dar_str[0] = '\0' would work wouldn't it?

> +	if (in_guest || user_mode) {
> +		printk("%sMCE: CPU%d: (%s) %s %s %s at %016llx %s[%s]\n",
> +			level, evt->cpu, sevstr,
> +			in_guest ? "Guest" : "Host",
> +			err_type, subtype, evt->srr0, dar_str,
> +			evt->disposition == MCE_DISPOSITION_RECOVERED ?
> +			"Recovered" : "Not recovered");
> +		printk("%sMCE: CPU%d: PID: %d Comm: %s\n",
> +			level, evt->cpu, current->pid, current->comm);
> +	} else {
> +		printk("%sMCE: CPU%d: (%s) Host %s %s at %016llx %s[%s]\n",
> +			level, evt->cpu, sevstr, err_type, subtype, evt->srr0,
> +			dar_str,
> +			evt->disposition == MCE_DISPOSITION_RECOVERED ?
> +			"Recovered" : "Not recovered");
> +		printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
> +			level, evt->cpu, evt->srr0, (void *)evt->srr0);
> +	}

The first printf in the two cases is quite similar, seems like they
could be consolidated.

I also think it'd be clearer to print the NIP on the 2nd line in all
cases, rather than the first.

What about (untested) ?

  printk("%sMCE: CPU%d: (%s) %s %s %s %s[%s]\n",
	 level, evt->cpu, sevstr,
	 in_guest ? "Guest" : "Host",
	 err_type, subtype, dar_str,
	 evt->disposition == MCE_DISPOSITION_RECOVERED ?
	 "Recovered" : "Not recovered");
  
  if (in_guest || user_mode) {
	printk("%sMCE: CPU%d: PID: %d Comm: %s %sNIP: [%016llx]\n",
	       level, evt->cpu, current->pid, current->comm,
	       in_guest ? "Guest " : "", evt->srr0);
  } else {
	printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
		level, evt->cpu, evt->srr0, (void *)evt->srr0);
  }


cheers

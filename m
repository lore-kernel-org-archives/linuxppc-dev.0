Return-Path: <srs0=oe5u=3h=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtlPn6trrzDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 11:10:05 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vtlPn5xw5z8vJP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 11:10:05 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vtlPn2HV9z9s77
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 11:10:05 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 79so5642067pgf.0
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 17:10:05 -0700 (PDT)
Date: Thu, 30 Mar 2017 10:09:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/book3s: Display task info for MCE error in
 user mode.
Message-ID: <20170330100947.74c7a76d@roar.ozlabs.ibm.com>
In-Reply-To: <149070872807.18309.16273606222489045198.stgit@jupiter.in.ibm.com>
References: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
 <149070872807.18309.16273606222489045198.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Mar 2017 19:15:28 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> For MCE that hit while in use mode MSR(HV=1,PR=1), print the task info on the
> console MCE error log. This will help to identify application that stumbled
> upon MCE error.

I think you may still want these details for a task currently in
kernel. How about something like if (!in_interrupt()) {


> @@ -311,8 +312,13 @@ void machine_check_print_event_info(struct machine_check_event *evt)
>  	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
>  	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
>  	       "Recovered" : "Not recovered");
> -	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
> +	if (user_mode) {
> +		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
> +				evt->srr0, current->pid, current->comm);
> +	} else {
> +		printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
>  							(void *)evt->srr0);
> +	}
>  	printk("%s  Initiator: %s\n", level,
>  	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
>  	switch (evt->error_type) {

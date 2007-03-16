Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id BD753DDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 06:20:39 +1100 (EST)
Message-ID: <45FAEDFB.70103@ru.mvista.com>
Date: Fri, 16 Mar 2007 22:20:27 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [patch 1/6 -rt] powerpc 2.6.20-rt8: add preemption checks for
	NEED_RESCHED_DELAYED.
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi7itt25t5.wl@toshiba.co.jp>
In-Reply-To: <yyi7itt25t5.wl@toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Tsutomu OWA wrote:
>   To add preemption checks for the NEED_RESCHED_DELAYED flag.

> diff -rup linux-rt8/arch/powerpc/kernel/idle.c rt/arch/powerpc/kernel/idle.c
> --- linux-rt8/arch/powerpc/kernel/idle.c	2007-02-20 14:30:38.000000000 +0900
> +++ rt/arch/powerpc/kernel/idle.c	2007-02-20 15:43:04.000000000 +0900
> @@ -56,7 +56,8 @@ void cpu_idle(void)
>  
>  	set_thread_flag(TIF_POLLING_NRFLAG);
>  	while (1) {
> -		while (!need_resched() && !cpu_should_die()) {
> +		while (!need_resched() && !need_resched_delayed() &&
> +				!cpu_should_die()) {
>  			ppc64_runlatch_off();
>  
>  			if (ppc_md.power_save) {

    Argh, I've missed this one! :-(
    But shouldn't we also add !need_resched_delayed() to another place below?

if (ppc_md.power_save)  {
[...]
	if (!need_resched() && !cpu_should_die())

WBR, Sergei

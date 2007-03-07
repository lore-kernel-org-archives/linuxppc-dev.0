Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E73A8DDE41
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 01:27:02 +1100 (EST)
Message-ID: <45EECBAA.2020608@ru.mvista.com>
Date: Wed, 07 Mar 2007 17:26:50 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [patch 0/6 -rt] powerpc 2.6.20-rt8: fix boot/runtime
	errors/warnings for PowerPC(ppc64)
References: <yyi8xe925vg.wl@toshiba.co.jp>
In-Reply-To: <yyi8xe925vg.wl@toshiba.co.jp>
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

Tsutomu OWA wrote:
> Hi Ingo,

>   Please consider for inclusion in your rt tree.

>   This series of patches fixes boot and runntime errors/warnings for
> powerpc (esp. 64 bit).  This applies to linux-2.6.20, patch-2.6.20-rt8
> and previous my patch set;
>   http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032640.html
>   http://lkml.org/lkml/2007/3/6/503

>   Compile and boot tested on celleb (Cell Reference set) for both
> PREEMPT_RT=y and PREEMPT_NONE=y.

>   CONFIG_MCOUNT, CONFIG_LATENCY_TRACE and other tracing options nor
> CONFIG_GENERIC_TIME,

    There is PowerPC genTOD patch and it's incorporated into -rt (don't know 
it works for Cell) but it breaks TOD vsyscalls. Several months ago I've posted 
patches removing them for the time being:

http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027686.html

and I've heard that this issue is being worked on now by John Stultz.
    Here's also a patch implemeting read_persitent_clock():

http://www.tglx.de/projects/hrtimers/2.6.18/broken-out/gtod-persistent-clock-support-ppc.patch

> clockevents etc are not yet ported.

    Note that there *is* PowerPC clockevents driver already (don't know if it 
works for Cell) -- it just never got merged to -rt:

http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027794.html
http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027852.html

>   Comments and suggestions are welcome.

>   Thanks in advance.
> -- owa
> TOSHIBA, Software Engineering Center.

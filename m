Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2E696877E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 01:25:00 +1100 (EST)
Date: Fri, 18 Nov 2005 07:05:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051118090546.GA12765@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117140715.GC9753@logos.cnet>
	<437DE127.50507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437DE127.50507@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2005 at 05:11:51PM +0300, Vitaly Bordug wrote:
> Marcelo Tosatti wrote:
> >On Wed, Nov 16, 2005 at 03:04:33PM +0300, Vitaly Bordug wrote:
> >>This adds board-specific files needed to utilize fs_enet Ethernet driver
> >>for MPC885ADS and MPC866ADS.
> >>
> >>Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> >>
> >
> >Vitaly,
> >
> >It also sounds to me that mpc885_nonplatform_device_init()
> >initialization suits board_init() time, instead of post-start_kernel()
> >do_initcalls(). No?
> >
> >
> >
> Well, maybe, but it actually works and since this approach prevents messing 
> up the m8xx_setup.c with #ifdef hell, I prefer the additional 
> initialization to be there.
> 
> If this is odd, I'll proceed with the right way of course.

No need to mess with m8xx_setup.c, just define your own board_init()
function:

+void __init
+board_init(void)
+{
+       ppc_md.time_init = cyc_rtc_init;
+       ppc_md.set_rtc_time = cyc_set_rtc_time;
+       ppc_md.get_rtc_time = cyc_get_rtc_time;
+       ppc_md.restart = cyc_8xx_restart;
+}

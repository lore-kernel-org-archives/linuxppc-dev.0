Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 725BCDDE25
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 02:03:44 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so279075anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 09:03:42 -0700 (PDT)
Message-ID: <fa686aa40804190903w60e214b9s2c05262d606c626b@mail.gmail.com>
Date: Sat, 19 Apr 2008 10:03:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Czanik" <pczanik@fang.fa.gau.hu>
Subject: Re: RFC: MPC5200 PSC AC97 driver
In-Reply-To: <4808C1BE.1050607@fang.fa.gau.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47FDEF9B.5000506@semihalf.com>
	<200804151003.17865.jbe@pengutronix.de>
	<200804161324.15887.jbe@pengutronix.de>
	<200804171619.56615.jbe@pengutronix.de>
	<4808C1BE.1050607@fang.fa.gau.hu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 9:43 AM, Peter Czanik <pczanik@fang.fa.gau.hu> wrote:
> Hello,
>
>  factory:/usr/src/linux-2.6.25 # diff -u
> arch/powerpc/kernel/prom_init.c.orig arch/powerpc/kernel/prom_init.c
>  --- arch/powerpc/kernel/prom_init.c.orig        2008-04-18
> 13:55:07.000000000 +0200
>  +++ arch/powerpc/kernel/prom_init.c     2008-04-18 16:26:51.000000000 +0200
>  @@ -2212,6 +2212,7 @@
>
>  static void __init fixup_device_tree_efika(void)
>  {
>  +       int sound_ci = 1;
>        int sound_irq[3] = { 2, 2, 0 };
>        int bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
>                                3,4,0, 3,5,0, 3,6,0, 3,7,0,
>  @@ -2257,6 +2258,8 @@
>                rv = prom_getprop(node, "interrupts", prop, sizeof(prop));
>                if (rv == PROM_ERROR) {
>                        prom_printf("Adding sound interrupts property\n");
>  +                        prom_setprop(node, "/builtin/sound", "cell-index",
>  +                                     &sound_ci, sizeof(int));
>                        prom_setprop(node, "/builtin/sound", "interrupts",
>                                     sound_irq, sizeof(sound_irq));
>                }

This probably isn't the ideal solution; but I've got no objection to
bringing it in as a work around until someone can make the driver
cleaner.

However, this change needs to be more robust.  It must first check if
the cell-index property already exists before trying to create it
(just like how adding the interrupts property works).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

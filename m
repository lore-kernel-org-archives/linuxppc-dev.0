To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Mac/m68k patches?
References: <Pine.GSO.4.10.10012121010320.1109-100000@escobaria.sonytel.be>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Dec 2000 19:11:47 +0100
In-Reply-To: Geert Uytterhoeven's message of "Tue, 12 Dec 2000 10:12:18 +0100 (MET)"
Message-ID: <d3bsuhldb0.fsf@lxplus015.cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Geert" == Geert Uytterhoeven <geert@linux-m68k.org> writes:

Geert> 	Hi, I have these Mac/m68k patches in my patchqueue which
Geert> affect PowerMac as well.  Anyone who has a problem with them,
Geert> or can I send them to Linus?

>diff -urN linux-2.4.0-test12/drivers/macintosh/adbhid.c linux-m68k-2.4.0-test12/drivers/macintosh/adbhid.c
>--- linux-2.4.0-test12/drivers/macintosh/adbhid.c	Sun Sep 17 18:48:05 2000
>+++ linux-m68k-2.4.0-test12/drivers/macintosh/adbhid.c	Tue Dec 12 09:02:45 2000
>@@ -855,8 +855,10 @@
>
> static int __init adbhid_init(void)
> {
>+#ifndef CONFIG_MAC
> 	if ( (_machine != _MACH_chrp) && (_machine != _MACH_Pmac) )
> 	    return 0;
>+#endif
>
> 	led_request.complete = 1;
>

Would be nice to turn that into a macro define in inclue/asm so we can
get rid of that ugly #ifdef. Doing something like
_machine_type(<type>) that return 0 on a match and -1 for no match or
similar.

Jes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-ch1gw-8.online-age.net (ext-ch1gw-8.online-age.net
	[64.37.194.16]) by ozlabs.org (Postfix) with ESMTP id 8A69267A2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 09:02:08 +1100 (EST)
Received: from int-ch1gw-2.online-age.net (int-ch1gw-2 [3.159.232.66])
	by ext-ch1gw-8.online-age.net (8.12.11/8.12.11/20050527-JWF) with ESMTP
	id j1HLmtBT006235
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Feb 2005 16:48:55 -0500
Received: from cinmlef08.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-ch1gw-2.online-age.net (8.12.9/8.12.3/990426-RLH) with ESMTP id
	j1HLmstW018878 for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 16:48:55 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 17 Feb 2005 15:50:27 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F205E1A4F0@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GX interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a question regarding interrupt and irq locking.
I derived  (or copied from somehwere)a library (linux 2.4.26) for the =
440GX from ppc4xx_pic.c to take care of the last interrupt register =
(UIC2).
This a newbie question regarding get_irq/spin_lock
here is get_irq:
...
     bits =3D mfdcr(DCRN_UIC_MSR(UICBASE));
     if ((bits & 0x40000000) =3D=3D 0x40000000)
     {
        bits =3D mfdcr(DCRN_UIC_MSR(UIC0));
        irq =3D ( ffs(bits));
        irq =3D 32-irq;
	}
	...

my question is what guarantee that the code is executed atomically?

The reason I asked is that we have a driver that did the following in =
the ioctl call:

	disable_irq(26);
	/* do something */
	enable_irq(26);

as you noticed there is not any spin_lock.
Sometimes, this leads  get_irq to see UICBASE indicating an irq in UIC0 =
and
UIC0_MSR to return 0. hence you get irq 32 (MAL_SERR) and an infinite =
loop.

My current fix is to use irqsave/irqrestore in the driver which I think =
is the correct way to do (but I may be wrong please help).


However, I have a colleague (here is the human problem of my questions: =
him or me is the problem) that insists that I should do something in =
get_irq to have atomic execution.

can you share your view about get_irq and spin_lock?

If it is not the correct place to ask this question, let me know where =
to send it.

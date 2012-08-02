Return-Path: <christian.melki@ericsson.com>
Received: from mailgw2.ericsson.se (mailgw2.ericsson.se [193.180.251.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailgw2.ericsson.se",
 Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 960512C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 21:01:36 +1000 (EST)
From: Christian Melki <christian.melki@ericsson.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 2 Aug 2012 12:46:24 +0200
Subject: Serial interrupt overrun and hard deadlock on 3.3.2 & 3.5,
 freescale 8347.
Message-ID: <1346E68D3A5B2043907CF4BF466383411CC1554409@ESESSCMS0353.eemea.ericsson.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

I've spent a couple of hours lifting our freescale 8347 platform from 2.6.3=
2 to 3.3.2 and just now to 3.5. The 3.x kernels are giving me some problems=
.
I get serial input overruns especially when cpu is loded, but I can reprodu=
ce overruns even at 0 other load. I can't even remember when I saw overruns=
 like this the last time, must have been in 2.2.x or early 2.4.x.
Also I can reliably trigger a hard kernel lock when using a USB-camera and =
acessing sequential blocks from the mtd device (read to verify flash). I'm =
thinking that this maybe has something to do with the reworks of IRQ handli=
ng in the powerpc arch lately.

I've tried most things I can think of to see if I can get a symptom change =
somewhere (incl, preemption, smp-kernel etc etc) but I get nothing.
Hard lock detection seems to be NMI bound on x86 only (?), so I can't use t=
hat.
A jtag-debugger does not give me much either, since I can't record the inst=
ruction stream in realtime anyway.

I'm kind of starved for ideas, so any help or tip as to what might be wrong=
 would be appreciated.

Regards,
Christian=

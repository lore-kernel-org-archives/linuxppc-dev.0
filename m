Return-Path: <stefan.nickl@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.e2brain.de
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 04A3A68182
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 03:18:59 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <20050823023824.9DCB4343AB@x-save.xtro.de>
References: <20050823023824.9DCB4343AB@x-save.xtro.de>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:48:21 +0200
Message-Id: <1124783301.14274.49.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How NEC uPD720101 USB chip work well on linux2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2005-07-23 at 10:37 +0800, JohnsonCheng wrote:
> Correct it. 
> I only turn on OHCI in kernel configuration, not UHCI.

I guess what you have is like this:

 ---------
| MPC8241 |
 ---------
     |
     | PCI bus
     |
 --------------------------
| OHCI host controller(s?) |
 --------------------------
     |
     | USB
     |
 -----------
| uPD720101 |
 -----------
     |
  USB mouse

So the IRQ is all up to your PCI setup and board wiring.

Please send the output of ksymoops as described in
linux/Documentation/oops-tracing.txt.
Note that you need to run it something like this:
ksymoops -v <vmlinux-of-target> -m <System.map-of-target> -t elf32-big
-a ppc -K -L

PS: Please check your PC's clock, your emails date back to July...

-- 
Stefan Nickl
Kontron Modular Computers

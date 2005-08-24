Return-Path: <stefan.nickl@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id E6FBF680A5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 16:38:23 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <20050823094950.44A4534392@x-save.xtro.de>
References: <20050823094950.44A4534392@x-save.xtro.de>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 08:38:20 +0200
Message-Id: <1124865500.14304.16.camel@lucy.pep-kaufbeuren.de>
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

On Tue, 2005-08-23 at 17:42 +0800, JohnsonCheng wrote:
> Right. My USB architecture is the same as you describe. I have also support
> EHCI, but I disable it now.
> The attach files are my kernel configuration and kernel oops while plug-in
> USB mouse.

Umh, I just recognized the 720101 isn't from NEC's hub series, but it's
the host controller itself (720110 would have been a hub also...)! My
bad.
So I'm afraid our problems are unrelated.

>From the logs you sent I'd say your problem starts right here: 
ohci_hcd 0000:00:0e.0: request interrupt 17 failed

You should check your PCI interrupt routing, trace INTA from the device,
it's IDSEL, etc. Look at /usr/src/linux/arch/ppc/platforms/sandpoint.c
and lspci -vvv.
But I'm not familiar with the sandpoint, so that's it for me...

-- 
Stefan Nickl
Kontron Modular Computers

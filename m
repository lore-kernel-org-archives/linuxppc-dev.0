Return-Path: <sp@primagraphics.co.uk>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 581822BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Dec 2004 01:52:27 +1100 (EST)
From: "Steve Priest" <sp@primagraphics.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 9 Dec 2004 14:45:43 -0000
Message-ID: <JMEMLCFCECLFAEMEBOLFKEIBCGAA.sp@primagraphics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PowerPC 7410 hangs at early_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a Radstone IMP1A with a 7410 processor and 64MB of RAM. This
basically a two chip card with a Marvel Discovery GT64260 handling
everything else. The monitor is PPCBoot version 2.2.0. I am trying to boot
ELDK Linux 2.4.25 as a uImage.

The kernel is successfully loaded and started by PPCBoot. Using some debug
code to control a user LED on the board I have been able to determine that
the kernel gets as far as 'bl early_init' in head.S, at which point it
appears to freeze. It does not execute any code in early_init, nor does it
return. It looks as though the branch is failing.

System.map shows that early_init is located at offset 0xB538. PPCBoot is
loading the kernel at 0x02000000 (32MB). I have tried loading at different
address in case something was getting overwritten without success.

Does anyone have any idea what the problem might be or seen anything
similar? Any suggestions gratefully received.

Thanks,
Steve.

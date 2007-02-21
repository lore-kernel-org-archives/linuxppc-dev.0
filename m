Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99FA6DDDCF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 01:54:30 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJsrR-00030I-Hg
	for linuxppc-embedded@ozlabs.org; Wed, 21 Feb 2007 15:54:25 +0100
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 15:54:25 +0100
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 15:54:25 +0100
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: understanding an IO question
Date: Wed, 21 Feb 2007 15:54:08 +0100
Message-ID: <erhmen$p6t$1@sea.gmane.org>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A165@MERCURY.inside.istor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A165@MERCURY.inside.istor.com>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Charles Krinke schrieb:
> I apologize for not making myself clearer. This is a kernel driver
> issue, not a user space issue. The issue is addressing the registers in
> a PCI device in its driver.
> 
> We have a functioning code base that works with Linux 2.6.17.11 on our
> 8241 platform. We have built a new board using the 8541. Although the
> registers are addressable from uboot and can be read/written, once Linux
> boots, the registers cannot be addressed.
> 
> I suspect this to be in either TLB1 setup or Outbound Address
> Translation windows.
> 
> So,... my questions really are 
> 2. "Are Outbound Address Translation windows reset by the arch/ppc/...
> Linux initialization and if so, where. If they are reset, where is the
> best place to put them back to the state I had set them up in uboot.

Well may be Kumar is the one to answer that at best.
However I am working on a solution, which uses MPC8540/MPC8541 and I 
know for sure that POWBARs and friends aren't reset during Linux boot 
*when PCI is completely disabled* in kernel config.

You may check if the appropriate set of POTAR, POWBAR and POWAR 
registers are still configured after boot.
POTAR reflects your external device address, POWBAR your local one (e.g. 
0x84000000, but only the 20 most-significant bits).
POWAR must be set to something like 0x80044013 (for a 1MB window).
Also a set of LAWBAR/LAWAR must appropriately match these settings.

See "Reference Manual" for details.

Good luck,

   Florian

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93A3DDE678
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 07:29:46 +1000 (EST)
Message-ID: <48582CC6.60004@freescale.com>
Date: Tue, 17 Jun 2008 16:29:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Winter <mike.winter@vecimanetworks.com>
Subject: Re: PCI DMA Problems With 82xx?
References: <4858113F.4050203@vecimanetworks.com>
In-Reply-To: <4858113F.4050203@vecimanetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Winter wrote:
> We are developing with an 8248-based platform, and we have a vendor 
> telling us that the PCI hardware is unreliable on this CPU family, in 
> particular the DMA functionality.  A quick search of this list doesn't 
> turn up any horror stories, although the processor does have some PCI 
> errata listed.  Does anybody have any practical experience using PCI on 
> the 8248 or similar that they can share with me?   Thanks.

Make sure that you park the bus on PCI, and elevate PCI's arbitration 
priority.  See fixup_pci() in arch/powerpc/boot/cuboot-pq2.c.

I haven't had a problem with PCI DMA when that is done, though I haven't 
done significant stress testing.

-Scott

Return-Path: <sr@denx.de>
Received: from SOHOSTED05.server5.sohosted.com (www.sohosted5.com
	[62.212.93.51]) by ozlabs.org (Postfix) with ESMTP id 7AA846891D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Jan 2006 23:21:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440EP/Yosemite PCI misbehavior
Date: Sun, 15 Jan 2006 10:21:13 +0100
References: <43C7292B.2060003@ovro.caltech.edu>
	<43C88013.40800@ovro.caltech.edu>
In-Reply-To: <43C88013.40800@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601151021.13798.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Saturday 14 January 2006 05:37, David Hawkins wrote:
> I'll go and play with the 440EP DMA controller and see if I can get
> that to burst to the PCI bus.
>
> > access to PCI I/O space causes a machine check exception.
>
> I still get this in 2.6.15, but Wolfgang Denx indicated that
> they'd tested PCI I/O pretty thoroughly, so I'm inclined to
> believe that its my driver that is at fault. I'll do a little
> more digging on that one.

I have to admit, that PCI I/O can't have worked until now on 
Yosemite/Yellowstone. I just found a bug in 
arch/ppc/platforms/4xx/yosemite.h:

-#define YOSEMITE_PCI_IO_BASE		0x00000000e0000000ULL
+#define YOSEMITE_PCI_IO_BASE		0x00000000e8000000ULL

Please give it a try and let me know if the problem is fixed.

Best regards,
Stefan

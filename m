Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5917ADE059
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 10:17:53 +1000 (EST)
Date: Mon, 25 May 2009 10:06:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: U-boot and linux command line parameters
Message-ID: <20090525000618.GD8059@yookeroo.seuss>
References: <23698384.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23698384.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 02:38:52PM -0700, Mirek23 wrote:
> 
> Dear All,
> 
> I use linux kernel 2.6.23 and u-boot 1.2.0 (on ppc405 virtex-4 ) for
> some time. All works fine when the kernel together with initramfs is
> smaller than 8MB. If it is bigger than the kernel does not boot
> properly.
> 
> First of all I would like to know how the address for the linux
> command line parameters is "transferred" from u-boot to linux for
> ppc405 (virtex4 chip)?  (via some registers or is it a fixed address
> in the memory ie. 8MB?)  Does somebody know what should be changed,
> in the kernel, in order to move this limitation from 8MB to let say
> 12MB? I would be grateful for any hint.

IIRC, U-boot 1.2.0 is a version of u-boot before it became device tree
aware.  Which means if I'm reading the cuboot.c code correctly, the
command line address is passed to the kernel at entry in r6, with the
length in r7.  With later, device-tree aware u-boot versions, the
command line is instead passed as a device tree property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

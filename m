Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 07E61DE184
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 00:23:13 +1000 (EST)
Message-ID: <4A14124D.4090200@mlbassoc.com>
Date: Wed, 20 May 2009 08:23:09 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
References: <14558983.1242828785546.JavaMail.ngmail@webmail10.arcor-online.net>
In-Reply-To: <14558983.1242828785546.JavaMail.ngmail@webmail10.arcor-online.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albrecht Dreß wrote:
> Hi all,
> 
> I ran into a weird problem when I tried to access a static (NV) ram attached to the localbus of a '5200 using Wolfram's mtd-ram OF driver (on a stock 2.6.29.1 kernel).  The 512k ram chip is connected in 16-bit mode to cs1.  the of entry reads
> 
> nvram@1,0 {
> 	compatible = "mtd-ram";
> 	reg = <1 0x0 0x00080000>;      // 512 kB
> 	bank-width = <2>;
> 	device-width = <2>;
> 	#size-cells = <1>;
> 	#address-cells = <1>;
> 	};
> 
> For the test I created a "pattern file" which is filled with the unsigned long 0x0055aaff.  Using the Abatron BDI3000, I can write the pattern file to the ram and re-read it without problems.  The same applies to u-boot (write ram via tftp, dump contents).
> 
> In Linux, when I write the file to /dev/mtdx, the last dword of each block is broken, e.g. when running "dd if=pattern of=/dev/mtd5 bs=512" the dword's at offset 0x1fc, 0x3fc, ... are 0x0000aaaa (instead of 0x0055aaff), if I use bs=1024 the dwords at 0x3fc, 0x7fc, ... show this value, if I use bs=4096 the dword at 0xffc shows this value, etc.  I looked at the CS/WR lines with a scope, and I couldn't see anything special.  The timing should be fine, as u-boot uses the same as Linux.
> 
> Any idea what goes wrong here?  I guessed I missed something in the LPB setup...

Check your cache setup - the BDI is most certainly not accessing
this via the Data cache whereas Linux probably will be.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

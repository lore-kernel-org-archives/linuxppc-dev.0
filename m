Return-Path: <SRS0=8N4g=SU=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D40FEDE272
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 08:01:27 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ndfc ecc byte order
Date: Wed, 30 Jan 2008 22:01:04 +0100
References: <47A0D57C.1000104@pikatech.com>
In-Reply-To: <47A0D57C.1000104@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801302201.04552.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 January 2008, Sean MacLennan wrote:
> There seems to be a byte order conflict between the u-boot and Linux
> ndfc drivers.
>
> u-boot has the following:
>
>     /* The NDFC uses Smart Media (SMC) bytes order*/
>     ecc_code[0] = p[2];
>     ecc_code[1] = p[1];
>     ecc_code[2] = p[3];
>
> the kernel has:
>
>     ecc_code[0] = p[1];
>     ecc_code[1] = p[2];
>     ecc_code[2] = p[3];
>
> I think u-boot has it right since u-boot and kernel software calculated
> ECCs agree. Anybody know a reason *not* to switch to the SMC byte order?

Please take a look at Kconfig

config MTD_NAND_NDFC
	tristate "NDFC NanD Flash Controller"
	depends on 4xx && !PPC_MERGE
	select MTD_NAND_ECC_SMC

So the SMC byte ordering is selected and it should match the version used in 
U-Boot. In Linux the swapping is done in nand_ecc.c.

So it should work correctly in the current configuration. At least I didn't 
notice any problems on all the 4xx platforms I used till now.

Best regards,
Stefan

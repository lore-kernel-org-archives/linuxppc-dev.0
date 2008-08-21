Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id C79CBDDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:16:56 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: Strange behavior with I2C on Sequoia board
Date: Thu, 21 Aug 2008 16:16:44 +0200
References: <48AC84D9.8050809@harris.com> <200808211151.40499.sr@denx.de>
	<48AD5FD1.1090809@ru.mvista.com>
In-Reply-To: <48AD5FD1.1090809@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211616.44937.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Valentine Barshak wrote:
> > It seems that your bootwrapper is somehow not copying the correct MAC
> > address to the device-tree. Not sure what's going wrong here. We usually
> > don't use the bootwrapper but boot the uImage directly from U-Boot on all
> > 4xx systems.
> >
> > You might want to debug the bootwrapper code, if possible drop the
> > bootwrapper and use the uImage with a newer, device-tree enabled U-Boot
> > version.
>
> U-boot thinks that all memory above the first 8MB is out of reach for
> the kernel and puts kernel bootargs and boardinfo structure below 8MB as
> close as possible to this limit. Including the i2c driver into the
> kernel increases the kernel image size. So when u-boot unpacks the
> kernel to 0x400000 (Load Address: 00400000) it overwrites the kernel
> parameters. So when the kernel actually starts, it reads zeros instead
> of boardinfo (and mac addresses)
>
> The 8MB limit is set for all AMCC boards in include/configs/amcc-common.h:
> #define CFG_BOOTMAPSZ		(8 << 20) /* Initial Memory map for Linux */
>
> I think this limit is obsolete and can be moved to at least 64MB.
> But you'll need to rebuild u-boot.
>
> Stefan, what do you think? Can we increase the default initial memory
> map for AMCC boards in the next u-boot release, since u-boot has all
> memory identity-mapped on ppc 44x?

Yes, it was our intention to increase the default map to a higher value a few 
weeks ago. I just forgot to really do it. I'll do this shortly.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 32DB7DE306
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 04:45:59 +1000 (EST)
To: Valentine Barshak <vbarshak@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Strange behavior with I2C on Sequoia board
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <48AD5FD1.1090809@ru.mvista.com>
References: <48AC84D9.8050809@harris.com>
	<1219279463.26429.35.camel@jdub.homelinux.org>
	<20080820231828.3c22da08@lappy.seanm.ca>
	<200808211151.40499.sr@denx.de> <48AD5FD1.1090809@ru.mvista.com>
Date: Thu, 21 Aug 2008 20:45:56 +0200
Sender: wd@denx.de
Message-Id: <20080821184556.C1D01248FF@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Valentine Barshak,

In message <48AD5FD1.1090809@ru.mvista.com> you wrote:
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

See also the initrd_high environment variable to adjust the limits
without need for recompiling U-Boot.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The complexity of software is an essential property, not an  acciden-
tal  one. Hence, descriptions of a software entity that abstract away
its complexity often abstract away its essence.    - Fred Brooks, Jr.

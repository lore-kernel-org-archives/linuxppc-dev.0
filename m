Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7024FDDFA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 05:56:00 +1000 (EST)
Message-ID: <48B6F506.9040103@freescale.com>
Date: Thu, 28 Aug 2008 13:57:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: How to access Freesale UPM NAND device
References: <765252.68184.qm@web46305.mail.sp1.yahoo.com>
In-Reply-To: <765252.68184.qm@web46305.mail.sp1.yahoo.com>
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

Laxmikant Rashinkar wrote:
> I have a custom board running MPC8347 on Linux 2.6.27 with Uboot 1.1.4.
> I also have a NAND device (Micron MT29F2G08AACWP) connected to the LBC
> and controlled via UPM.
> 
> fsl_elbc_nand.ko, fsl_upm.ko are loaded.

fsl_elbc_nand is for FCM; you only need the latter.

> I'm wondering how to access the NAND device. Do I need mDOC? TrueFFS?

JFFS2 is typically used.

> I have grep'd for the functions declared in fsl_upm.c and fsl_lbc.c and 
> find that no other
> code path calls these functions. So it looks like the drivers are loaded 
> but no one calls into
> them.

The init function of the module registers a driver, providing function 
pointers that are called.  You access the device through /dev/mtd*.

-Scott

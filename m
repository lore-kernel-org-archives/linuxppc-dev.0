Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D4B2DDF12
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 01:48:50 +1000 (EST)
Message-ID: <461BB1DB.9050503@freescale.com>
Date: Tue, 10 Apr 2007 10:48:43 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: Re: MPC 8349e-mITX and MTD/Flash
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benedict, Michael wrote:

> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0x0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> # CONFIG_MTD_PHYSMAP_OF is not set
> CONFIG_MTD_PLATRAM=y

This what the latest defconfig for the 8349ITX has:

CONFIG_MTD=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xfe000000
CONFIG_MTD_PHYSMAP_LEN=0x1000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2

Your settings for CONFIG_MTD_PHYSMAP_START and CONFIG_MTD_PHYSMAP_LEN are wrong.  And 
frankly, I can't understand where you got those values from, unless you created your 
.config from scratch.  The defconfig that's in the kernel is specifically intended for the 
Freescale MPC8349E-mITX.  I should know, because I wrote the code and the defconfig.

Having said that, it seems that the kernel now supports defining the physmap via the OF 
tree.  Is that true?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

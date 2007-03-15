Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E66DADDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 03:51:47 +1100 (EST)
Message-ID: <45F9799D.7080206@freescale.com>
Date: Thu, 15 Mar 2007 11:51:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
	<45F94472.6010803@freescale.com>
	<Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
	<20070315164728.GA20524@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070315164728.GA20524@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> +config QUICC_ENGINE_83xx
>> +	bool "QUICC Engine Support"
>> +	select QUICC_ENGINE
>> +	depends on PPC_MPC836x || PPC_MPC832x
>> +	default y
>> +	---help---
>> +	  The QUICC Engine (QE) is a new generation of communications
>> +	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
>> +	  Selecting this option means that you wish to build a kernel
>> +	  for a machine with a QE coprocessor.
>> +
> 
> Instead of doing it like this, what about having each QE-enabled SOC
> select HAS_QUICC_ENGINE, and then have the user-configurable
> QUICC_ENGINE option depend on HAS_QUICC_ENGINE?

The purpose of doing it this way is that the "QE Support" option appears 
BELOW each SOC option.  So if you pick an 836x, you'll see a menu that 
says "QE support".  You want to have the menu option to disable QE 
support even if the QE is present on the SOC.

We will need to do the same thing with the 8568, when the QE support 
works with it.  At that point, there will be a "QUICC_ENGINE_85xx", 
which will appear on *that* menu.

You cannot have the same config option in more than one Kconfig file.

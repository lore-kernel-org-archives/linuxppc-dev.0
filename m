Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id EC4EC67C57
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 19:25:23 +1100 (EST)
Date: Tue, 31 Oct 2006 09:25:20 +0100 (MET)
Message-ID: <4547086D.2050808@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>	
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>	
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
In-Reply-To: <1162280335.25682.302.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------040507020400030608030504"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040507020400030608030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
>> Well, on a personal point of view, the only usable mailer I know does 
>> not run on my 'work' OS. I'll copy/paste from an editor ;-)
> 
> And both are ? (mailer and 'work' OS ? :)
> 

Mailer: SimpleMail. Almost usable a bit buggy.
'work' OS: Linux PowerPC ;-)

>>> +/* MBAR position */
>>> +#define MPC52xx_MBAR        0xf0000000    /* Phys address */
>>> +#define MPC52xx_MBAR_VIRT    0xf0000000    /* Virt address */
>>> +#define MPC52xx_MBAR_SIZE    0x00010000
>>> +
>>> +#define MPC52xx_PA(x)        ((phys_addr_t)(MPC52xx_MBAR + (x)))
>>> +#define MPC52xx_VA(x)        ((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
>>>
>>> This should be handled dynamically (pulled from the device tree), I 
>>> doubt MBAR will be at the same location for all boards.
>> Well, 0xf000000 seems some kind of 'standart' value. we could have a 
>> global variable 'mpc52xx_mbar' which would be default 0xf0000000 and 
>> modified by each platform.
> 
> No. No magic globals. If we need some common code for dealing with some
> 52xx specific bits, them have a file somewhere, possibly in sysdev,
> containing those and exposing functions.
> 

Ok. By the way, the mbar is include as property in our OpenFrimware. 
Moreover, the G2CORE CPU has a new SPR 'MBAR' which is the MBAR ;-). It 
would maybe make sense to create a new file 
(arch/powerpc/sysdev/mpc52xx.c) which would contain chip specific code.

Like mpc52xx_get_mbar(), mpc52xx_get_ipbfreq(), etc...

I updated a bit the patches. I applied Dale requests.
My kernel still compiles and boots. ;-)

Should I post the new patches?

About the headers thingy. Should I split them directly in the patch, or 
this should be done by others later on?

About the serials and USB part. Have anyone already do some work (moving 
to of_platform, etc...)?

As far as I see, the Efika platform patch did not get any comment, 
should I assume it is good enough for inclusion in the main stream kernel?

Regards.

--------------040507020400030608030504
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------040507020400030608030504--

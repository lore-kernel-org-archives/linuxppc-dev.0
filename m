Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0126.outbound.protection.outlook.com [207.46.100.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D52461A0065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 02:47:42 +1000 (AEST)
Subject: Re: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
To: Scott Wood <scottwood@freescale.com>, Roy Pledge <roy.pledge@freescale.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436517510.20619.123.camel@tiscali.nl>
 <1436549503.2658.157.camel@freescale.com>
 <BN3PR0301MB1267E9EFD8CBC294275028B68C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <1436554227.2658.161.camel@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, Victoria Milhoan
 <Vicki.Milhoan@freescale.com>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@freescale.com>
Message-ID: <55AFC198.1070501@freescale.com>
Date: Wed, 22 Jul 2015 19:15:20 +0300
MIME-Version: 1.0
In-Reply-To: <1436554227.2658.161.camel@freescale.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/10/2015 9:50 PM, scottwood at freescale.com (Scott Wood) wrote:
> On Fri, 2015-07-10 at 13:29 -0500, Pledge Roy-R01356 wrote:
>>>   return in_be32((void *)bm + offset);
>>>>          ^
>>>> [...]/drivers/soc/fsl/qbman/bman.c: In function ‘__bm_out’:
>>>> [...]/drivers/soc/fsl/qbman/bman.c:172:2: error: implicit declaration
>>>> of function ‘out_be32’ [-Werror=implicit-function-declaration]
>>>>   out_be32((void *)bm + offset, val);
>>>
>>> These PPCisms will need to be fixed.  LS1043A is an ARM chip with DPAA 
>>> 1.0.
>>
>> LS1043 (ARM, Little Endian) support is still work in progress.  The patches 
>> for that are being tested now but are based on the SDK version of the 
>> driver and will need to be massaged in order to get them applied here.  Our 
>> plan of record is to add upstream support for this at a later time.
> 
> If you're already reworking this for upstream acceptance, why not fix the 
> more obvious PPCisms now?

Other drivers are facing similar problems wrt. I/O accessors.
How should the problem be solved?

For caam driver (drivers/crypto/caam) we have the following combinations:
ARCH	CORE	CAAM		SoC, options
PPC	BIG	BIG		P4080 etc.
PPC	BIG	LITTLE		N/A
PPC	LITTLE	BIG		P4080 + CONFIG_CPU_LITTLE_ENDIAN
PPC	LITTLE	LITTLE		N/A
ARM	LITTLE	LITTLE		LS1021A, LS2085A etc.
ARM	LITTLE	BIG		LS1043A
ARM	BIG 	LITTLE		LS1021A + CONFIG_CPU_BIG_ENDIAN
ARM	BIG	BIG		LS1043A + CONFIG_CPU_BIG_ENDIAN

Not all need to be supported, but for e.g. we are being requested to run
on ARM in BE mode.

Existing MMIO accessors have one of the following drawbacks:
-readl/writel: on ARM do swapping (cpu <--> le), while on PPC are
bus-specific (for PCI)
-have weak semantics (no barriers / sequence points etc.), like __raw_*

Thus, it looks like drivers have to define their own MMIO accessors,
taking into account:
-core endianness (which is independent of arch)
-device endianness
-already-defined MMIO accessors availability, depending on arch
-semantics will have to match

Unfortunately, the code will look terrible. In each driver.

Thanks,
Horia

P.S. Sorry if the To/Cc list is screwed up, I've taken the message from
the archive.

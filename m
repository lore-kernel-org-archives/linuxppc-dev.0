Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77A3D2C0101
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:01:23 +1000 (EST)
Subject: Re: [PATCH V2 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1378406276.12204.101.camel@snotra.buserror.net>
Date: Fri, 6 Sep 2013 10:01:15 -0500
Message-Id: <D0460C0F-D497-4E6A-A0F3-03145FE4444D@kernel.crashing.org>
References: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
 <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
 <C12D1FFD-4D98-48C1-8681-54489600F722@kernel.crashing.org>
 <1378406276.12204.101.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <hongtao.jia@freescale.com>,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 5, 2013, at 1:37 PM, Scott Wood wrote:

> On Thu, 2013-09-05 at 13:34 -0500, Kumar Gala wrote:
>> On Apr 2, 2013, at 9:03 PM, Jia Hongtao wrote:
>>> +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
>>> +	}
>>> +
>>> 	/*
>>> 	 * Remember the phandle, so that we can match with any PCI nodes
>>> 	 * that have an "fsl,msi" property.
>>> diff --git a/arch/powerpc/sysdev/fsl_msi.h =
b/arch/powerpc/sysdev/fsl_msi.h
>>> index 8225f86..7389e8e 100644
>>> --- a/arch/powerpc/sysdev/fsl_msi.h
>>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>>> @@ -25,6 +25,8 @@
>>> #define FSL_PIC_IP_IPIC   0x00000002
>>> #define FSL_PIC_IP_VMPIC  0x00000003
>>>=20
>>> +#define MSI_HW_ERRATA_ENDIAN 0x00000010
>>> +
>>=20
>> Why does this need to be in the header, why not just have it in the =
.c only
>=20
> Didn't you ask this last time around? :-)
>=20
> This flag is part of the same numberspace as FSL_PIC_IP_xxx and thus
> should be defined in the same place.

I probably did, if its part of the FSL_PIC_IP_xxx namespace, than lets =
remove blank line between things to make that a bit more clear

- k

Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07471A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 01:57:51 +1000 (EST)
Date: Wed, 20 Aug 2014 10:54:38 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>,
 Scott Wood <scottwood@freescale.com>
Message-ID: <868471357.33583.1408550078450.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <53F4179F.1010803@freescale.com>
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
 <1408493285.4058.55.camel@snotra.buserror.net>
 <53F4179F.1010803@freescale.com>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> -#define FSL_IFC_BANK_COUNT 4
> >> +#define FSL_IFC_BANK_COUNT 8
> > First please modify fsl_ifc_nand.c to limit itself to the number of
> > banks it dynamically determines are present based on the IFC version.
> >
> >
> 
> Number of available bank/chip select are defined by SoC and it is
> independent of SoC.

You mean that there is no way to tell from an IFC-specific register how
many chip selects are valid for a given SoC, correct?

> It should be fix in following way
> 
> Option 1:
> u-boot:  fix device tree with number of available chip select. It may
> require IFC binding change
> Linux: Read device tree and determine the Chip Selects
> 
> or
> 
> Option 2:
> Make it static because any way IFC NAND driver polls to
> FSL_IFC_BANK_COUNT to know NAND flash chip select. This patch is doing same.

My patch is based on the assumption that it is safe to access the addresses of
the four nonexistent (unconnected?) chip selects in devices with fewer than
eight chip selects.

Also, the full FSL_IFC_BANK_COUNT range of chip selects should only be probed
when no match is not found for a chip select's DTS-defined address base within
any IFC bank. The typical case would be for the device tree to properly define
the address space prepared by the bootloader, which would result in only banks
present in the SoC being probed.

I have tested this patch on P1010 and T1042 processors, which feature four and
eight chip selects respectively with no apparent ill effects.

Our P1010 product has NAND attached to chip selects 0 and 1:

    ranges = <0x0 0x0 0x0 0xef800000 0x0010000
              0x1 0x0 0x0 0xef840000 0x0010000>;

I mangled chip-select 0 so that the DTS-defined base would not match the
address programmed by firmware, so that all eight chip selects would be
scanned on this four chip-select part:

    ranges = <0x0 0x0 0x0 0xefc00000 0x0010000
              0x1 0x0 0x0 0xef840000 0x0010000>;

This resulted in the following kernel message:

fsl,ifc-nand efc00000.nand0: fsl_ifc_nand_probe: address did not match any chip selects

The NAND device at chip select 1 was properly detected.

> Regards,
> Prabhakar

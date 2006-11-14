Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6075667D2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 22:47:46 +1100 (EST)
Date: Tue, 14 Nov 2006 01:01:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
Message-ID: <20061114090102.GA16520@gate.ebshome.net>
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adaac2v2d2g.fsf@cisco.com>
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

On Mon, Nov 13, 2006 at 02:31:51PM -0800, Roland Dreier wrote:
> This is mostly updating the PCI Express code to work with the new core
> in the Rev. B chip, which unfortunately has different undocumented
> restrictions on the PLB addresses that can be used from the Rev. A core.
> 
> Also, when adding the cputable entry for 440SPe Rev. B, we need to
> adjust the entry for 440SP Rev. A so that it looks at more bits of the
> PVR.  The 440SPe Rev. B has PVR 53421891, which would have matched the
> old 440SP pattern of 53xxx891.
> 
> This is a cleaned up version of the original work done by Rafal
> Jaworowski <raj@semihalf.com>, who actually suffered through figuring
> out how to avoid the Rev. B chip locking up when using PCIe.
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

[snip]

> +static void ppc440spe_setup_utl(int port)
> +{
> +	void __iomem *utl_base;
> +
> +	/*
> +	 * Map UTL registers at 0xc_1000_0n00
> +	 */
> +	switch (port) {
> +	case 0:
> +		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
> +		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
> +		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
> +		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
> +		break;
> +
> +	case 1:
> +		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
> +		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
> +		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
> +		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
> +		break;
> +
> +	case 2:
> +		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
> +		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
> +		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
> +		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
> +	}

Can this be collapsed into 4 writes instead of 12? DCR accessors 
have supported run-time specified parameters for quite some time.

[snip]

> +	case 0: val = SDR_READ(PESDR0_LOOP); break;
> +	case 1: val = SDR_READ(PESDR1_LOOP); break;
> +	case 2: val = SDR_READ(PESDR2_LOOP); break;

I'm curious, why do we need a switch here? 
SDR_READ() also supports run-time parameters.


[snip]

>  	switch (port) {
>  	case 0:
> -		mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
> -		mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
> +		if (core_rev == REV_A) {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
> +		} else {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000d);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x00000000);
> +		}
>  		mtdcr(DCRN_PEGPL_CFGMSK(PCIE0), 0xe0000001); /* 512MB region, valid */
>  		break;
>  
>  	case 1:
> -		mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
> -		mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
> +		if (core_rev == REV_A) {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
> +		} else {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000d);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x20000000);
> +		}
>  		mtdcr(DCRN_PEGPL_CFGMSK(PCIE1), 0xe0000001); /* 512MB region, valid */
>  		break;
>  
>  	case 2:
> -		mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
> -		mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
> +		if (core_rev == REV_A) {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
> +		} else {
> +			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000d);
> +			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0x40000000);
> +		}
>  		mtdcr(DCRN_PEGPL_CFGMSK(PCIE2), 0xe0000001); /* 512MB region, valid */
>  		break;
>  	}


Can we get rid of this switch as well?

There are other places like this in the patch but I think you got my 
idea :).

-- 
Eugene

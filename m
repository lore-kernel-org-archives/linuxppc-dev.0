Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15F792C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:38:08 +1000 (EST)
Message-ID: <1378406276.12204.101.camel@snotra.buserror.net>
Subject: Re: [PATCH V2 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 5 Sep 2013 13:37:56 -0500
In-Reply-To: <C12D1FFD-4D98-48C1-8681-54489600F722@kernel.crashing.org>
References: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
 <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
 <C12D1FFD-4D98-48C1-8681-54489600F722@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Thu, 2013-09-05 at 13:34 -0500, Kumar Gala wrote:
> On Apr 2, 2013, at 9:03 PM, Jia Hongtao wrote:
> > +			msi->feature |= MSI_HW_ERRATA_ENDIAN;
> > +	}
> > +
> > 	/*
> > 	 * Remember the phandle, so that we can match with any PCI nodes
> > 	 * that have an "fsl,msi" property.
> > diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
> > index 8225f86..7389e8e 100644
> > --- a/arch/powerpc/sysdev/fsl_msi.h
> > +++ b/arch/powerpc/sysdev/fsl_msi.h
> > @@ -25,6 +25,8 @@
> > #define FSL_PIC_IP_IPIC   0x00000002
> > #define FSL_PIC_IP_VMPIC  0x00000003
> > 
> > +#define MSI_HW_ERRATA_ENDIAN 0x00000010
> > +
> 
> Why does this need to be in the header, why not just have it in the .c only

Didn't you ask this last time around? :-)

This flag is part of the same numberspace as FSL_PIC_IP_xxx and thus
should be defined in the same place.

-Scott

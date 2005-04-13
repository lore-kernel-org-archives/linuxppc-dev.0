Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 1FABD67B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 07:09:35 +1000 (EST)
Received: from [192.168.1.101] (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 83BA7A4012
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 22:50:30 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 13 Apr 2005 22:50:11 +0200
References: <0007F077BB3476449151699150E8FEA21A7B92@exchange.tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA21A7B92@exchange.tsi-telsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504132250.11884.roger.larsson@norran.net>
Subject: Re: Error enabling CONFIG_PPC4XX_DMA in lk2.4.27-pre3?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 08 April 2005 22.19, Sanjay Bajaj wrote:
> Hi! Gurus,
>
> I tried to enable DMA in lk2.4.27-pre3 and it fails with the error attached
> to the end of the mail. On further debugging, I found that though
> CONFIG_PPC4XX_DMA is included in the .config but the asm/ppc4xx_dma.h
> includes CONFIG_PPC4XX_EDMA, which includes all the constants reported
> undeclared in the error message. Out of curiosity, changed .._EDMA to
> .._DMA in asm/ppc4xx_dma.h and still had errors. Any help is appreciated.
>

Hmm...

What processor are you using?

If I remember correctly 405GPr did not enable CONFIG_PPC4XX_EDMA
but 405GP did... yepp, this check in 'arch/ppc/config.in' checks for 405GP
but not 405GPr

  bool 'PPC4xx DMA controller support' CONFIG_PPC4xx_DMA
  if [ "$CONFIG_PPC4xx_DMA" = "y" ]; then
    if [ "$CONFIG_405GP" = "y" -o "$CONFIG_NP405L" = "y"        \
          -o "$CONFIG_NP405H" = "y" -o "$CONFIG_NP405GS" = "y"  \
          -o "$CONFIG_440" = "y" -o "$CONFIG_405LP" = "y" \
          -o "$CONFIG_405EP" = "y" ]; then
      define_bool CONFIG_PPC4xx_EDMA y
    fi
    if [ "$CONFIG_STB03xxx" = "y" ]; then
      define_bool CONFIG_STBXXX_DMA y
    fi
  fi

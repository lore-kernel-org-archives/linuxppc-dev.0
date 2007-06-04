Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 96E69DDEA3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 03:10:09 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Mon, 4 Jun 2007 19:09:54 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
In-Reply-To: <90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706041909.55062.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 04 June 2007, Michael Ellerman wrote:
> This patch adds support for the setup and decoding of MSIs
> on Axon-based Cell systems.

Looks pretty good, just two details I noticed:

> +/* Flags */
> +#define MSIC_ENABLE		0x0001	/* Bit 31 */
> +#define MSIC_FIFO_FULL_ENABLE	0x0002	/* Bit 30 */
> +#define MSIC_IRQ_ENABLE		0x0008	/* Bit 28 */
> +#define MSIC_FULL_STOP_ENABLE	0x0010	/* Bit 27 */

The comments behind each definition look rather bogus, as much as
we all love to have documentation normally.

If you have the specification for the hardware, the bit numbers
are in there, for everyone else, the IBM numbering scheme can
only confuse the reader...

> +#define MSIC_DCR_BASE		MSIC_CTRL_REG_ADDR
> +#define MSIC_DCR_SIZE		(MSIC_WRITE_OFFSET_REG - MSIC_CTRL_REG_ADDR)

shouldn't that come from the device tree?

	Arnd <><

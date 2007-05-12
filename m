Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D0CD5DDEC9
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 09:30:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/9] powerpc: BestcComm ATA task support
Date: Sun, 13 May 2007 01:30:56 +0200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019234031-git-send-email-tnt@246tNt.com>
	<11790019233958-git-send-email-tnt@246tNt.com>
In-Reply-To: <11790019233958-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130130.56854.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 May 2007, Sylvain Munaut wrote:
> +
> +EXPORT_SYMBOL(bcom_ata_init);
> +EXPORT_SYMBOL(bcom_ata_rx_prepare);
> +EXPORT_SYMBOL(bcom_ata_tx_prepare);
> +EXPORT_SYMBOL(bcom_ata_reset);
> +EXPORT_SYMBOL(bcom_ata_release);

See my comment in 4/9: why not EXPORT_SYMBOL_GPL?

> +u32 bcom_ata_task[] = {
> +	/* header */
> +	0x4243544b,
> +	0x0e060709,
> +	0x00000000,
> +	0x00000000,
> +
> +	/* Task descriptors */
> +	0x8198009b, /* LCD: idx0 = var3; idx0 <= var2; idx0 += inc3 */
> +	0x13e00c08, /*   DRD1A: var3 = var1; FN=0 MORE init=31 WS=0 RS=0 */
> +	0xb8000264, /*   LCD: idx1 = *idx0, idx2 = var0; idx1 < var9; idx1 += inc4, idx2 += inc4 */
> +	0x10000f00, /*     DRD1A: var3 = idx0; FN=0 MORE init=0 WS=0 RS=0 */
> +	0x60140002, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=2 EXT init=0 WS=2 RS=2 */
> +	0x0c8cfc8a, /*     DRD2B1: *idx2 = EU3(); EU3(*idx2,var10)  */
> +	0xd8988240, /*   LCDEXT: idx1 = idx1; idx1 > var9; idx1 += inc0 */
> +	0xf845e011, /*   LCDEXT: idx2 = *(idx0 + var00000015); ; idx2 += inc2 */
> +	0xb845e00a, /*   LCD: idx3 = *(idx0 + var00000019); ; idx3 += inc1 */
> +	0x0bfecf90, /*     DRD1A: *idx3 = *idx2; FN=0 TFD init=31 WS=3 RS=3 */
> +	0x9898802d, /*   LCD: idx1 = idx1; idx1 once var0; idx1 += inc5 */
> +	0x64000005, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=5 INT EXT init=0 WS=0 RS=0 */
> +	0x0c0cf849, /*     DRD2B1: *idx0 = EU3(); EU3(idx1,var9)  */
> +	0x000001f8, /* NOP */
> +
> +	/* VAR[9]-VAR[14] */
> +	0x40000000,
> +	0x7fff7fff,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +
> +	/* INC[0]-INC[6] */
> +	0x40000000,
> +	0xe0000000,
> +	0xe0000000,
> +	0xa000000c,
> +	0x20000000,
> +	0x00000000,
> +	0x00000000,
> +};
> +

Does it make any sense to define these symbolically? It's entirely nonobvious
what all these magic numbers do. Maybe at least give the URL of the document
that this comes from.

	Arnd <><

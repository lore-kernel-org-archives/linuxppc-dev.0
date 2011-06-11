Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AD87B7051
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Jun 2011 08:46:09 +1000 (EST)
Subject: Re: [PATCH 1/1] Big endian swap for Marvell 6440 SAS driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Cano <ccano@interfaceconcept.com>
In-Reply-To: <4DF2228E.7060806@ic.fr>
References: <4DF2228E.7060806@ic.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 12 Jun 2011 08:45:56 +1000
Message-ID: <1307832356.2874.312.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-10 at 15:56 +0200, Cédric Cano wrote:
> Hi,
> 
> Marvell SAS driver doesn't work on powerpc architecture due to big 
> endian swap. I've tested it with the MV6440 chip.
> Here you can find the patch for Linux 2.6.39.1.
> 
> Cedric Cano
> 
> Signed-off-by: Cedric Cano <ccano@interfaceconcept.com>
> ---
> --- drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:04.000000000 +0200
> +++ drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:12.000000000 +0200
> @@ -1143,6 +1143,14 @@
>       MVS_CHIP_DISP->write_port_cfg_addr(mvi, i, PHYR_SATA_SIG0);
>       s[0] = MVS_CHIP_DISP->read_port_cfg_data(mvi, i);
> 
> +    /* swap for big endian devices because of use of these data in bytes */
> +#ifdef __BIG_ENDIAN
> +    s[0] = swab32(s[0]);
> +    s[1] = swab32(s[1]);
> +    s[2] = swab32(s[2]);
> +    s[3] = swab32(s[3]);
> +#endif /* __BIG_ENDIAN */

Hi Cedric !

Thanks for this. CC'ing linux-scsi.

Note that it would probably have been better to use le32_to_cpu, which
avoids the ifdef completely.

Cheers,
Ben.

>       /* Workaround: take some ATAPI devices for ATA */
>       if (((s[1] & 0x00FFFFFF) == 0x00EB1401) && (*(u8 *)&s[3] == 0x01))
>           s[1] = 0x00EB1401 | (*((u8 *)&s[1] + 3) & 0x10);
> 
> ---
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

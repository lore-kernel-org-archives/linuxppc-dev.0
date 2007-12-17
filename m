Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 762C8DDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 08:04:13 +1100 (EST)
Message-ID: <4766E43E.4050101@pobox.com>
Date: Mon, 17 Dec 2007 16:03:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [NET][POWERPC] ucc_geth: really fix section mismatch
References: <20071217115435.GA29857@localhost.localdomain>
In-Reply-To: <20071217115435.GA29857@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Commit ed7e63a51d46e835422d89c687b8a3e419a4212a has tried to fix
> section mismatch:
> 
> WARNING: vmlinux.o(.init.text+0x17278): Section mismatch: reference to
> .exit.text:uec_mdio_exit (between 'ucc_geth_init' and 'uec_mdio_init')
> 
> But that mismatch still happens.
> 
> This patch actually fixing section mismatch by removing __exit from
> the header file.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/net/ucc_geth_mii.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ucc_geth_mii.h b/drivers/net/ucc_geth_mii.h
> index d834370..1e45b20 100644
> --- a/drivers/net/ucc_geth_mii.h
> +++ b/drivers/net/ucc_geth_mii.h
> @@ -96,5 +96,5 @@ enum enet_tbi_mii_reg {
>  int uec_mdio_read(struct mii_bus *bus, int mii_id, int regnum);
>  int uec_mdio_write(struct mii_bus *bus, int mii_id, int regnum, u16 value);
>  int __init uec_mdio_init(void);
> -void __exit uec_mdio_exit(void);

applied #upstream-fixes

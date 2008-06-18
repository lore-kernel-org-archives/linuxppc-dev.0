Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21A65DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 13:25:55 +1000 (EST)
Message-ID: <4858803B.7020008@pobox.com>
Date: Tue, 17 Jun 2008 23:25:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibm_newemac: select CRC32 in Kconfig
References: <20080617192755.575dcad4@zod.rchland.ibm.com>
In-Reply-To: <20080617192755.575dcad4@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> The ibm_newemac driver requires ether_crc to be defined.  Apparently it is
> possible to generate a .config without CONFIG_CRC32 set which causes the
> following link errors if IBM_NEW_EMAC is selected:
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `emac_hash_mc':
> core.c:(.text+0x2f524): undefined reference to `crc32_le'
> core.c:(.text+0x2f528): undefined reference to `bitrev32'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This patch has IBM_NEW_EMAC select CRC32 so we don't hit this error.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  drivers/net/ibm_newemac/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

applied

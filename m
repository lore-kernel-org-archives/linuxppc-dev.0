Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3F1E92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:09:12 +1000 (EST)
Message-ID: <1375477741.15999.23.camel@pasglop>
Subject: Re: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Date: Sat, 03 Aug 2013 07:09:01 +1000
In-Reply-To: <1375477090.32477.10.camel@what-is-leg>
References: <1375477090.32477.10.camel@what-is-leg>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 15:58 -0500, Fionnuala Gunter wrote:
> The chaining value from co-processor was not being saved. This value is
> needed because it is used as the IV, for example by cts i.e.
> cts(cbc(aes)).
> 
> Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>

So now you guys are sending the patch to linuxppc-dev and not the crypto
list ..

I need to understand things better here. Any reason why those drivers
aren't handled by the crypto maintainer ?

Ben.

> ---
>  drivers/crypto/nx/nx-aes-cbc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/nx/nx-aes-cbc.c
> b/drivers/crypto/nx/nx-aes-cbc.c
> index 35d483f..a2f99a9 100644
> --- a/drivers/crypto/nx/nx-aes-cbc.c
> +++ b/drivers/crypto/nx/nx-aes-cbc.c
> @@ -95,6 +95,7 @@ static int cbc_aes_nx_crypt(struct blkcipher_desc
> *desc,
>         if (rc)
>                 goto out;
> 
> +       memcpy(desc->info, csbcpb->cpb.aes_cbc.cv, AES_BLOCK_SIZE);
>         atomic_inc(&(nx_ctx->stats->aes_ops));
>         atomic64_add(csbcpb->csb.processed_byte_count,
>                      &(nx_ctx->stats->aes_bytes));

Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BBCA1A0F57
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 09:42:02 +1100 (AEDT)
Message-ID: <1420756921.1211.14.camel@neuling.org>
Subject: Re: [PATCH] cxl: remove redundant increment of hwirq
From: Michael Neuling <mikey@neuling.org>
To: Colin King <colin.king@canonical.com>
Date: Fri, 09 Jan 2015 09:42:01 +1100
In-Reply-To: <1420756607-23459-1-git-send-email-colin.king@canonical.com>
References: <1420756607-23459-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-08 at 22:36 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> hwirq has not been initialized, however it is being incremented
> and also not being referenced in a loop.  This error was detected with
> cppcheck:
>=20
> [drivers/misc/cxl/irq.c:439]: (error) Uninitialized variable: hwirq
>=20
> Commit 80fa93fce37d ("cxl: Name interrupts in /proc/interrupt")=20
> introduced this error.
>=20
> This is a simple fix that removes the redundant increment.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks.  Looks good.

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index c294925..68ab608 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -436,7 +436,7 @@ int afu_register_irqs(struct cxl_context *ctx, u32 co=
unt)
>  	 */
>  	INIT_LIST_HEAD(&ctx->irq_names);
>  	for (r =3D 1; r < CXL_IRQ_RANGES; r++) {
> -		for (i =3D 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> +		for (i =3D 0; i < ctx->irqs.range[r]; i++) {
>  			irq_name =3D kmalloc(sizeof(struct cxl_irq_name),
>  					   GFP_KERNEL);
>  			if (!irq_name)

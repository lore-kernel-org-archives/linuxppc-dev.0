Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1D211A09A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 14:53:12 +1100 (AEDT)
Message-ID: <1414468386.364.212.camel@pasglop>
Subject: Re: [PATCH] Revert "powerpc/powernv: Fix endian bug in LPC bus
 debugfs accessors"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 28 Oct 2014 14:53:06 +1100
In-Reply-To: <1414458920-7166-1-git-send-email-mpe@ellerman.id.au>
References: <1414458920-7166-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 12:15 +1100, Michael Ellerman wrote:
> This reverts commit bf7588a0859580a45c63cb082825d77c13eca357.
> 
> Ben says, "The original code was fine, I think the bug was actually in
> the userspace tool I was using (don't worry, nothing on the field uses
> that interface yet and I can still fix the tool)."
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

The original code wasn't fine actually :-) But the fix was completely
wrong and does more damages than it fixes things. So Ack the revert and
I'll sort things out properly later.

Cheers,
Ben.

> ---
>  arch/powerpc/platforms/powernv/opal-lpc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
> index dd2c285ad170..ad4b31df779a 100644
> --- a/arch/powerpc/platforms/powernv/opal-lpc.c
> +++ b/arch/powerpc/platforms/powernv/opal-lpc.c
> @@ -191,7 +191,6 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
>  {
>  	struct lpc_debugfs_entry *lpc = filp->private_data;
>  	u32 data, pos, len, todo;
> -	__be32 bedata;
>  	int rc;
>  
>  	if (!access_ok(VERIFY_WRITE, ubuf, count))
> @@ -214,10 +213,9 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
>  				len = 2;
>  		}
>  		rc = opal_lpc_read(opal_lpc_chip_id, lpc->lpc_type, pos,
> -				   &bedata, len);
> +				   &data, len);
>  		if (rc)
>  			return -ENXIO;
> -		data = be32_to_cpu(bedata);
>  		switch(len) {
>  		case 4:
>  			rc = __put_user((u32)data, (u32 __user *)ubuf);

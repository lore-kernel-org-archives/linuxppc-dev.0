Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Wed, 4 Mar 2009 09:36:53 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc/spufs: Fix incorrect buffer offset
	in regs write
In-Reply-To: <1236145172.189228.314429009881.1.gpush@pingu>
Message-ID: <alpine.LRH.2.00.0903040935560.2416@vixen.sonytel.be>
References: <1236145172.189228.314429009881.1.gpush@pingu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Mar 2009, Jeremy Kerr wrote:
> We need to offset by *pos bytes, not *pos words.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> 
> ---
>  arch/powerpc/platforms/cell/spufs/file.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 83ef889..6b10877 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -578,7 +578,7 @@ spufs_regs_write(struct file *file, const char __user *buffer,
>  	if (ret)
>  		return ret;
>  
> -	ret = copy_from_user(lscsa->gprs + *pos - size,
> +	ret = copy_from_user((char *)lscsa->gprs + *pos - size,
>  			     buffer, size) ? -EFAULT : size;
>  
>  	spu_release_saved(ctx);

Could this be abused by an attacker to write registers or local store he's not
allowed to do?

Should it be backported to stable?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

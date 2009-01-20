Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Tue, 20 Jan 2009 10:21:17 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] PS3 ps3av_set_video_mode() make id signed
In-Reply-To: <4972456C.1050301@gmail.com>
Message-ID: <alpine.LRH.2.00.0901201018440.31271@vixen.sonytel.be>
References: <4972456C.1050301@gmail.com>
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

On Sat, 17 Jan 2009, Roel Kluin wrote:
> vi drivers/video/ps3fb.c +618
> static int ps3fb_set_par(struct fb_info *info)
> {
>         struct ps3fb_par *par = info->par;
> ... [ and at line 660 ] ...
> 	if (ps3av_set_video_mode(par->new_mode_id))
> 
> now new_mode_id is an int
> 
> vi drivers/video/ps3fb.c +132
> struct ps3fb_par {
> ...
>         int new_mode_id;
> ...
> };
> 
> vi drivers/ps3/ps3av.c +844
> int ps3av_set_video_mode(u32 id)
> 
> -------------------------^^^
> 
> {
> ...
> 	if (... || id < 0) {
> 
> --------------------^^^
> 
> 		dev_dbg(&ps3av->dev->core, "%s: error id :%d\n", __func__, id);
>                 return -EINVAL;
>         }
> ...
> 		id = ps3av_auto_videomode(&ps3av->av_hw_conf);
>                 if (id < 1) {
> ---------------------^^^
>                         printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
>                         return -EINVAL;
>                 }
> ...
> 	ps3av->ps3av_mode = id;
> 
> vi drivers/ps3/ps3av.c +763
> static int ps3av_auto_videomode()
> 
> -------^^^
> 
> +42
> static struct ps3av {
> ...
>         int ps3av_mode;
> ...
> };
> 
> --------------------->8---------------8<-------------------
> make id signed so a negative id will get noticed

Thanks for noticing! It looks OK, except...

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
> index 5324978..7aa6d41 100644
> --- a/drivers/ps3/ps3av.c
> +++ b/drivers/ps3/ps3av.c
> @@ -838,7 +838,7 @@ static int ps3av_get_hw_conf(struct ps3av *ps3av)
>  }
>  
>  /* set mode using id */
> -int ps3av_set_video_mode(u32 id)
> +int ps3av_set_video_mode(int id)
>  {
>  	int size;
>  	u32 option;

1. You forgot to update the forward declaration of ps3av_set_video_mode() in
   arch/powerpc/include/asm/ps3av.h (did you compile this succesfully?)

2. You forgot to change `u32 id' in ps3av_probe().

Can you please make these changes, too? Thx again!

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

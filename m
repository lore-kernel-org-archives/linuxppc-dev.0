Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B962ADDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 21:20:33 +1000 (EST)
Date: Fri, 18 May 2007 13:20:29 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
In-Reply-To: <20070517112215.6261992d.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.62.0705181319310.1803@pademelon.sonytel.be>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
	<20070517112215.6261992d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Segher@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 May 2007, Stephen Rothwell wrote:
> diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
> index 192b26e..11ced17 100644
> --- a/drivers/macintosh/windfarm_core.c
> +++ b/drivers/macintosh/windfarm_core.c
> @@ -216,7 +216,10 @@ int wf_register_control(struct wf_control *new_ct)
>  	new_ct->attr.attr.mode = 0644;
>  	new_ct->attr.show = wf_show_control;
>  	new_ct->attr.store = wf_store_control;
> -	device_create_file(&wf_platform_device.dev, &new_ct->attr);
> +	if (device_create_file(&wf_platform_device.dev, &new_ct->attr))
> +		printk(KERN_WARNING "windfarm: device_create_file failed"
> +			" for %s\n", new_ct->name);
> +		/* the subsystem still does useful work without the file */

Confusing indentation: the comment is not part of the branch

> @@ -326,7 +329,10 @@ int wf_register_sensor(struct wf_sensor *new_sr)
>  	new_sr->attr.attr.mode = 0444;
>  	new_sr->attr.show = wf_show_sensor;
>  	new_sr->attr.store = NULL;
> -	device_create_file(&wf_platform_device.dev, &new_sr->attr);
> +	if (device_create_file(&wf_platform_device.dev, &new_sr->attr))
> +		printk(KERN_WARNING "windfarm: device_create_file failed"
> +			" for %s\n", new_sr->name);
> +		/* the subsystem still does useful work without the file */

Ditto.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

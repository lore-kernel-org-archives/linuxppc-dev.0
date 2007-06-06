Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 530FDDDEBD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 22:21:12 +1000 (EST)
Date: Wed, 6 Jun 2007 14:21:10 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 18/18] PS3: Device registration routines.
In-Reply-To: <466623A4.1080102@am.sony.com>
Message-ID: <Pine.LNX.4.62.0706061412580.24545@pademelon.sonytel.be>
References: <20070606024407.786638029@am.sony.com>>
	<466623A4.1080102@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 5 Jun 2007, Geoff Levand wrote:
> +static int __init ps3_register_vuart_devices(void)
> +{
> +	int result;
> +	unsigned int port_number;
> +
> +	pr_debug(" -> %s:%d\n", __func__, __LINE__);
> +
> +	result = ps3_repository_read_vuart_av_port(&port_number);
> +
> +	if (result)
> +		port_number = 0; /* av default */
> +
> +	result = ps3_setup_vuart_device(PS3_MATCH_ID_AV_SETTINGS, port_number);
> +	WARN_ON(result);
> +
> +	ps3_repository_read_vuart_sysmgr_port(&port_number);
    ^^^^
> +
> +	if (result)
> +		port_number = 2; /* sysmgr default */

You forgot to assign the return value of
ps3_repository_read_vuart_sysmgr_port(). As the system manager vuart port
number is not in the repository on the firmware I'm using, port_number contains
garbage, and ps3_vuart_probe() will BUG().

As this problem is present in your current git tree, here's a patch:

Subject: [PATCH] Check return value of ps3_repository_read_vuart_sysmgr_port()

Add a missing assignment of the return value of
ps3_repository_read_vuart_sysmgr_port(). As the system manager vuart port
number is not in the repository on the firmware I'm using, port_number contains
garbage, and ps3_vuart_probe() will BUG().

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--- a/arch/powerpc/platforms/ps3/device-init.c	2007-06-06 13:58:43.000000000 +0200
+++ b/arch/powerpc/platforms/ps3/device-init.c	2007-06-06 14:12:35.000000000 +0200
@@ -505,15 +505,13 @@ static int __init ps3_register_vuart_dev
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	result = ps3_repository_read_vuart_av_port(&port_number);
-
 	if (result)
 		port_number = 0; /* av default */
 
 	result = ps3_setup_vuart_device(PS3_MATCH_ID_AV_SETTINGS, port_number);
 	WARN_ON(result);
 
-	ps3_repository_read_vuart_sysmgr_port(&port_number);
-
+	result = ps3_repository_read_vuart_sysmgr_port(&port_number);
 	if (result)
 		port_number = 2; /* sysmgr default */
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

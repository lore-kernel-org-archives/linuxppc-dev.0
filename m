Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 475B9DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:14:06 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/9] ps3: disable display flipping during mode changes
Date: Fri, 26 Jan 2007 03:13:36 +0100
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251850470.24610@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701251850470.24610@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701260313.36700.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 18:51, Geert Uytterhoeven wrote:
> @@ -33,6 +33,12 @@
>  #define DPRINTK(fmt, args...) do { } while (0)
>  #endif
>  
> +#ifdef CONFIG_FB_PS3
> +extern int ps3fb_flip_ctl(int);
> +#else
> +#define ps3fb_flip_ctl(x)
> +#endif

The empty function should by convention be defined as
'do { } while (0)', like the DPRINTK above.
Even better might be an empty inline function

static inline int ps3fb_flip_ctl(int arg)
{
	return 0;
}

that enables type checking in gcc.

	Arnd <><

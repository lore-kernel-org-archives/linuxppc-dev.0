Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17693.48421.91877.327347@cargo.ozlabs.ibm.com>
Date: Sat, 30 Sep 2006 10:41:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] move drivers/macintosh variables to BSS
In-Reply-To: <20060926201554.GA886@aepfle.de>
References: <20060926201554.GA886@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> --- linux-2.6.18.orig/drivers/macintosh/ans-lcd.c
> +++ linux-2.6.18/drivers/macintosh/ans-lcd.c
> @@ -21,8 +21,8 @@
>  #define ANSLCD_CTRL_IX 0x00
>  #define ANSLCD_DATA_IX 0x10
>  
> -static unsigned long anslcd_short_delay = 80;
> -static unsigned long anslcd_long_delay = 3280;
> +static unsigned long anslcd_short_delay;
> +static unsigned long anslcd_long_delay;
>  static volatile unsigned char __iomem *anslcd_ptr;
>  
>  #undef DEBUG
> @@ -164,6 +164,8 @@ anslcd_init(void)
>  	printk(KERN_DEBUG "LCD: init\n");
>  #endif
>  
> +	anslcd_short_delay = 80;
> +	anslcd_long_delay = 3280;

What's the point of this?  I can understand removing redundant "= 0"
initializers, but why fatten the code by 3 instructions just to remove
1 word from the data section?

Paul.

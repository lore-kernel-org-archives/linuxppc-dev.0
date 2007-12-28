Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id ACF3DDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 12:47:59 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so6402309pyi.0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 17:47:58 -0800 (PST)
Date: Thu, 27 Dec 2007 19:47:53 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Problems with arch/powerpc
Message-ID: <20071227194753.56bc92f8@vader.jdub.homelinux.org>
In-Reply-To: <47742519.8060502@pikatech.com>
References: <47742519.8060502@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Dec 2007 17:20:09 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> If this should go in linuxppc-embedded please let me know. It seems that 
> the board supports are getting posted here.
> 
> PIKA has an embedded PPC440EP board based on the AMCC Yosemite board. I 
> got the Linux 2.6.19.2 kernel working by basically copying the Yosemite 
> configuration. Now I am trying to move from the ppc to the powerpc 
> architecture using Josh Boyer's for-2.6.25 kernel. And there is no 
> Yosemite config :( We are using u-boot 1.3.0.

Yeah, I've no Yosemite board so no port for it yet.

> I have the kernel booting, but the OS runs very strange. I cannot run 
> the ash shell, it fails on the first setjmp. But I can run the hush 
> shell (we are using busybox). So it goes, many things work, others don't.
> 
> I am mounting the root filesystem over NFS, so the ethernet seem to work 
> well.
> 
> But cat /proc/interrupts shows:
> 
>            CPU0
>  16:        126   UIC   Level     serial
>  17:        520   UIC   Level     MAL TX EOB
>  18:        804   UIC   Level     MAL RX EOB
>  19:          0   UIC   Level     MAL SERR
>  20:          0   UIC   Level     MAL TX DE
>  21:          0   UIC   Level     MAL RX DE
>  28:          0   UIC   Level     EMAC
> BAD:          0

Looks fairly normal to me.

> 
> Which is quite different from the older kernel:
> 
>            CPU0
>   0:       3075  UIC0 Level     serial
>   2:       1526  UIC0 Level     IBM IIC
>   7:          0  UIC0 Level     IBM IIC
>  10:       1388  UIC0 Level     MAL TX EOB
>  11:       1839  UIC0 Level     MAL RX EOB
>  32:          0  UIC1 Level     MAL SERR
>  33:          0  UIC1 Level     MAL TX DE
>  34:          0  UIC1 Level     MAL RX DE
>  40:          1  UIC1 Level     ohci_hcd:usb1
>  60:          0  UIC1 Level     EMAC
> BAD:          0
> 

There's no support for the i2c devices on 440 in arch/powerpc yet,
which is why those don't show up.  As for the USB interrupt, you might
be missing the device-tree enabled USB driver in your config.  The
interrupt numbers will differ based on various things, so I wouldn't
worry about that.

> I have attached the dts file. It is based on the bamboo. I can provide 
> any other config, the only thing I can't provide is the hardware ;) 
> Since the new kernel doesn't show UIC0 or UIC1, just UIC I am wondering 
> if something is wrong with the dts.

I didn't see anything wrong in my cursory glance.  But I need to look
at it a bit closer to be sure.

Can you post the full boot messages (send privately if you'd like). One
thing to make sure of is if all the properties in the DTS file that say
"Filled in by zImage wrapper" are actually getting filled in.

josh

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0DF7DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 03:55:24 +1000 (EST)
Message-ID: <4714FB08.7090100@freescale.com>
Date: Tue, 16 Oct 2007 12:55:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [UNTESTED PATCH v2] 8xx: Convert mpc866ads to the new device
	binding.
References: <20071008224847.GA4053@loki.buserror.net>
	<20071016215308.764d9922@vitb.ru.mvista.com>
In-Reply-To: <20071016215308.764d9922@vitb.ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> Hi Scott,
> 
> orig one does not build (not your issue apparently):
> 
>   CC      drivers/net/fs_enet/fs_enet-main.o
> drivers/net/fs_enet/fs_enet-main.c: In function `fs_enet_probe':
> drivers/net/fs_enet/fs_enet-main.c:1252: error: implicit declaration of 
> function `SET_MODULE_OWNER'
> drivers/net/fs_enet/fs_enet-main.c:1292: error: structure has no member 
> named `poll'
> drivers/net/fs_enet/fs_enet-main.c:1293: error: structure has no member 
> named `weight'
> make[3]: *** [drivers/net/fs_enet/fs_enet-main.o] Error 1
> make[2]: *** [drivers/net/fs_enet] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> because net_device does not have 'poll' and 'weight' anymore.
> 
> Moreover, with the patch, it does not seem to boot(with upper lines commented out to get it build). I'm investigating the reason right now.

Yeah, I was working on cleaning up the mess when I got this message. :-)

Removing the napi_enable call should make it boot.  I'm now trying to 
get in to work with napi enabled...

-Scott

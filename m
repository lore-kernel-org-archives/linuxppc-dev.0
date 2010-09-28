Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA3F2B70F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 01:01:52 +1000 (EST)
Message-ID: <4CA1F1E3.3000809@emcraft.com>
Date: Tue, 28 Sep 2010 17:47:15 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 3/3] mpc512x_dma: add MPC8308 support
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1285676696-5358-4-git-send-email-yanok@emcraft.com>
	<20100928130919.1558AD5218F@gemini.denx.de>
In-Reply-To: <20100928130919.1558AD5218F@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org,
	Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfgang,

28.09.2010 17:09, Wolfgang Denk wrote:
>>   config MPC512X_DMA
>>   	tristate "Freescale MPC512x built-in DMA engine support"
>> -	depends on PPC_MPC512x
>> +	depends on PPC_MPC512x || PPC_MPC831x
>
> Is MPC831x correct here? My understanding is that MPC831x processors
> have yet other DMA cotnrollers, and we're on a MPC8308 here?

Well, PPC_MPC831x is not correct here in the strict sense, but there are 
some reasons for it:
  1. We don't really have PPC_MPC8308 config option for MPC8308 
processor. Well, maybe that was my fault that I didn't add it when I 
initially introduced support for MPC8308. But I don't actually see the 
point for it. All the differencies from MPC831x are handled run-time 
based on device-tree.
  2. Some of MPC831x (I believe it's MPC8315) really has the compatible 
DMA controller (it's called something like DMA controller of the TDM 
module). Well it will probably need some additional work in the driver 
to support this controller but hardware is mostly the same.
  3. Well, it's only compilation option you need a proper device-tree 
node for the driver to start. Ok, you can make your kernel bigger by 
compiling in the driver which is useless for your CPU but you can't 
break it provided you have a correct device-tree.

Regards, Ilya.

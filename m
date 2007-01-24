Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by ozlabs.org (Postfix) with ESMTP id B6B49DDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 03:04:51 +1100 (EST)
Subject: Re: ML403, 2.6.17.1 kernel panic
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
In-Reply-To: <45B603C1.2070601@ru.mvista.com>
References: <1169556195.16144.3.camel@localhost.localdomain>
	<45B603C1.2070601@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 24 Jan 2007 18:04:46 +0100
Message-Id: <1169658286.21182.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrei,

Firts aff all thank you very much for your help. I finally succed to
start the kernel. The problem was as SGDMA is activated then there is no
FIFO support on the TEMAC.

The kernel start properly now on NFS root file system but hangs with :
Unable to open initial console.

The root file system is just a copy of the MVISTA rootfs delivered with
ML403 eval kit.

A quick look in /dev show that there is no ttyS0 and that is why the
kernel did not succeed to open /dev/ttyS0.

My question is : 

1) Is their any config in the Kernel 2.6.17.1 to select, in order to
have an auto initialisation of /dev (like withe CONFIG_DEVFS_FS in
previous verions)?

Or should I create ttyS0 node in the root file system?

2) Is there someone in the community that succeed to use TEMAC with
SGDMA? If yes could you tell me wich kernel version and what TEMAC patch
you are using.

One more time thanks to Andrei.

Kinds regards

Le mardi 23 janvier 2007 à 15:46 +0300, Andrei Konovalov a écrit :
> Hi Chris,
> 
>  From you log it seems like the kernel tries to initialize the TEMAC's FIFO but fails.
> Do you have TEMAC configured in FIFO mode in your design?
> 
> Thanks,
> Andrei
> 

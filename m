Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B422680D8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 18:50:11 +1000 (EST)
Date: Wed, 24 Aug 2005 09:49:55 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
Message-Id: <20050824094955.21977185.ajz@cambridgebroadband.com>
In-Reply-To: <20050824050304.6508167F88@ozlabs.org>
References: <200508231616.46897.scop@digitel.com.br>
	<20050824050304.6508167F88@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Before doing a write to /dev/mtd1 try running 
~# eraseall /dev/mtd1

(eraseall is from the mtd-utils package.)

Alex


On Wed, 24 Aug 2005 13:02:31 +0800
"JohnsonCheng" <johnsoncheng@qnap.com.tw> wrote:

> Dear Ricardo and Wolfgang,
> 
> Very thanks for your kindly support.
> I am sorry I made a mistake.
> Before you mount /dev/mtdblock4, you have to use mke2fs to format it.
> Now I think my MTD function is almost ready, except write.
> When I run "dd if=/dev/mtd1 of=kernel.img", it's OK.
> But when I run "dd if=kernel.img of=/dev/mtd1", it's failed. No error
> message printed, and the process time is shortly, cause Bad CRC.
> 
> Thanks,
> Johnson Cheng
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Ricardo Scop
> Sent: Wednesday, August 24, 2005 3:17 AM
> To: JohnsonCheng; 'Robert P. J. Day'
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux Kernel MTD question
> 
> Hi Johnson,
> 
> On Tuesday 23 August 2005 02:31, JohnsonCheng wrote:
> > It doesn't work, too.
> > Error message: Invalid argument.
> Well, do you have an mtdblock4 entry in /dev?
> 
> Also, you should specify your filesystem type to mount, like in:
> 
> mount -t jffs2 /dev/mtdblock4 /mnt
> 
> BTW, -t jffs2 is just an example.
> 
> HTH,
> 
> -Scop.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

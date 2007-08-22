Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6411ADDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 06:02:36 +1000 (EST)
Message-ID: <46CC9655.3000109@freescale.com>
Date: Wed, 22 Aug 2007 15:02:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: Badness in local_bh_enable at
	kernel/softirq.c:137	(linux_denx_2.6.19.2)
References: <F1F6EC0C8B75034F9E3A79FC85122E8EA180A4@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA180A4@aquib01a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

DI BACCO ANTONIO - technolabs wrote:
> Sending ioctls to a socket I receive the following problem (only the
> first time I send a ioctl):
>  
> Badness in local_bh_enable at kernel/softirq.c:137

You're not supposed to nest a spin_lock_bh inside a spin_lock_irq. 
fs_ioctl() does this anyway, hence the warning.

-Scott

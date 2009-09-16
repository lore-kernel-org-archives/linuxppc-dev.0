Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 054B5B7B79
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 23:40:15 +1000 (EST)
Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each core in CAMPmodefor
	P2020RDB
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
Date: Wed, 16 Sep 2009 08:40:03 -0500
Message-Id: <3F599858-2550-4234-86F3-A3352576AC34@kernel.crashing.org>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com>
	<20090910093307.GA17117@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
	<20090910160233.GA24085@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 11, 2009, at 6:47 AM, Aggrwal Poonam-B10812 wrote:

>>
>> Ok, I wrongly understood protected interrupts as reserved for
>> one core. However, I still dislike two devices having the same name.
>>
>> Otherwise it may work if every interrupt is delivered to both
>> cores although statistically only one core will actually have
>> some work to do. Doesn't the kernel complain about unhandled
>> irqs however?
>>
> We don't see any such messages of unhandled interrupts, although I
> checked the corresponding files for mpc8572ds, they do not have the
> interrupts property for the serial ports at all, in both the core0 and
> core1 dts.
> Don't know the reason.

the p2020 versions shouldn't have an interrupt property in the serial  
node.  The reason we removed it in the 8572 CAMP dts is to make sure  
we get polling mode.  As Gabriel points out sharing the IRQ between  
the two OSes is not safe.  While it might seem to work it will have  
issues at some point.

- k

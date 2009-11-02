Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94DBC100830
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 04:32:46 +1100 (EST)
Subject: Re: mpc8548 does not make use of DMA when doing memory copy?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
Date: Mon, 2 Nov 2009 11:32:39 -0600
Message-Id: <15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
References: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
To: hank peng <pengxihan@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 2, 2009, at 9:40 AM, hank peng wrote:

> Kernel version is 2.6.30 and I have enabled fsl DMA engine during
> configuring kernel. After system booted, I have seen only 38 DMA
> interrupts, and no increase later when I am doing data transfer
> through network.
> So I wonder if mpc8548  had made use of DMA engine when doing memcpy,
> or maybe if there are other things I haven't noticed?

The dma engine code is not normally used for normal memcpy's in the  
kernel.  There are explicit call sites that have async behavior that  
should use it (like the networking code).

- k

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B6AFDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 19:55:14 +1000 (EST)
In-Reply-To: <9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
References: <1210224392246-git-send-email-nick.spence@freescale.com>
	<18466.38047.531381.157886@cargo.ozlabs.ibm.com>
	<9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b94d56008ca72b846fbdf8cfe9925e6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM non-cached.
Date: Thu, 8 May 2008 11:54:56 +0200
To: "Spence Nick" <Nick.Spence@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We found the problem when porting code from Linux 2.4 to 2.6, where a
> user space application maps a 1 MByte region of DRAM with the O_SYNC
> flag to communicate with an internal core that shares access to the
> DRAM but does not have any cache snooping logic.
>
> In 2.4 the mem driver honors the O_SYNC flag and makes the requested
> memory
> memory non-cached so that writes from user space are immediately
> available
> to the second core.

If you only need to write from the core running Linux, and never
read the memory back, and the secondary core never writes the memory,
your userland program can simply do dcbst on it after it wrote it.

Otherwise, if your CPU has BAT registers, you could use those to
force that memory region as non-cacheable (be careful, BATs are not
allowed to overlap each other).

If these things won't work for you, you need to do some simple device
driver, and do non-coherent DMA from it (you can view the secondary
core as an I/O device like any other).


Segher

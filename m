Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19199DDED3
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 01:12:22 +1100 (EST)
Message-Id: <367C576B-9264-4C80-B65E-1DC00632FEFA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0810080653x76234b4ma53188bed2a3d59d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPC8315ERDB PCI Express support status?
Date: Wed, 8 Oct 2008 09:08:25 -0500
References: <c384c5ea0810060642l2bbc2a08y5725a28b6d45aa8d@mail.gmail.com>
	<9509FE83-529D-4C0B-B226-B7169FA727DB@kernel.crashing.org>
	<c384c5ea0810080653x76234b4ma53188bed2a3d59d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Stuart Hughes <seh@zee2.com>,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 8:53 AM, Leon Woestenberg wrote:

> I would like these patches to be ported forward to mainline, and I can
> put some time in this, but I'ld rather first know what the Freescale
> status on the patches is?
>
> John, Stuart, could you please check if there is ongoing work in
> Freescale? I hate double efforts when I'm short on time :-) Thanks.


Leon (I also work @ FSL) and we don't have any work going on right now  
to cleanup the PCIe patches.

The reason they aren't in the kernel is the mechanism used to do PCIe  
config cycles is not acceptable for kernel.org.  The issue is that the  
code ioremaps a huge address space (128M if I remember).  The code  
should look at doing a sliding window and only use 4k of address space.

- k

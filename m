Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CA462C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 23:49:54 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2 EPN
 mask for 64-bit
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-6-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 15:49:47 +0200
Message-Id: <D3F90478-D3C9-4699-ADFD-CE752D9A569F@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-6-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> Extend MAS2 EPN mask for 64-bit hosts, to retain most significant =
bits.
> Change get tlb eaddr to use this mask.

Please see section 6.11.4.8 in the PowerISA 2.06b:

MMU behavior is largely unaffected by whether the thread is in 32-bit =
computation mode (MSRCM=3D0) or 64- bit computation mode (MSRCM=3D1). =
The only differ- ences occur in the EPN field of the TLB entry and the =
EPN field of MAS2. The differences are summarized here.

	=95  Executing a tlbwe instruction in 32-bit mode will set bits =
0:31 of the TLB EPN field to zero unless MAS0ATSEL is set, in which case =
those bits are not written to zero.
	=95  In 32-bit implementations, MAS2U can be used to read or =
write EPN0:31 of MAS2.

So if MSR.CM is not set tlbwe should mask the upper 32 bits out - which =
can happen regardless of CONFIG_64BIT.
Also, we need to implement MAS2U, to potentially make the upper 32bits =
of MAS2 available, right? But that one isn't as important as the first =
bit.


Alex

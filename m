Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3E90B6F69
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 20:08:57 +1000 (EST)
Subject: Re: [PATCH 01/17] KVM: PPC: Fix machine checks on 32-bit Book3S
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110629101642.GB25406@bloggs.ozlabs.ibm.com>
Date: Fri, 1 Jul 2011 12:08:51 +0200
Message-Id: <200FF063-5F41-4A17-9F0E-DAF16E8BC741@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629101642.GB25406@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.06.2011, at 12:16, Paul Mackerras wrote:

> Commit 69acc0d3ba ("KVM: PPC: Resolve real-mode handlers through
> function exports") resulted in vcpu->arch.trampoline_lowmem and
> vcpu->arch.trampoline_enter ending up with kernel virtual addresses
> rather than physical addresses.  This is OK on 64-bit Book3S machines,
> which ignore the top 4 bits of the effective address in real mode,
> but on 32-bit Book3S machines, accessing these addresses in real mode
> causes machine check interrupts, as the hardware uses the whole
> effective address as the physical address in real mode.
>=20
> This fixes the problem by using __pa() to convert these addresses
> to physical addresses.

Ouch. Thanks for the catch! I really need to include book3s_32 in my =
automated testing :(.


Alex

Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8698B6FF4
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Jun 2011 00:34:55 +1000 (EST)
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
Date: Sat, 18 Jun 2011 16:34:14 +0200
Message-Id: <FF184B48-CFBB-42E9-9CAE-897A56172F5E@suse.de>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
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


On 18.06.2011, at 10:27, Paul Mackerras wrote:

> The following series of patches enable KVM to exploit the hardware
> hypervisor mode on 64-bit Power ISA Book3S machines.  At present,
> POWER7 and PPC970 processors are supported.  (Note that the PPC970
> processors in Apple G5 machines don't have a usable hypervisor mode
> and are not supported by these patches.)
>=20
> Running the KVM host in hypervisor mode means that the guest can use
> both supervisor mode and user mode.  That means that the guest can
> execute supervisor-privilege instructions and access supervisor-
> privilege registers.  In addition the hardware directs most exceptions
> to the guest.  Thus we don't need to emulate any instructions in the
> host.  Generally, the only times we need to exit the guest are when it
> does a hypercall or when an external interrupt or host timer
> (decrementer) interrupt occurs.
>=20
> The focus of this KVM implementation is to run guests that use the
> PAPR (Power Architecture Platform Requirements) paravirtualization
> interface, which is the interface supplied by PowerVM on IBM pSeries
> machines.  Currently the "pseries" machine type in qemu is only
> supported by book3s_hv KVM, and book3s_hv KVM only supports the
> "pseries" machine type.  That will hopefully change in future.
>=20
> These patches are against Alex Graf's kvm-ppc-next branch.

I just applied them on top of kvm-ppc-next and started compiling for =
book3s_64_pr=3DM:

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:314: Error: undefined symbol =
`PACA_KVM_SVCPU' in operation
arch/powerpc/kernel/exceptions-64s.S:314: Error: undefined symbol =
`SVCPU_IN_GUEST' in operation
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
make: *** [arch/powerpc/kernel] Error 2


Alex

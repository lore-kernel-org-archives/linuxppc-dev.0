Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8B12B6F62
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jul 2011 04:24:59 +1000 (EST)
Subject: Re: [PATCH 0/17] Hypervisor-mode KVM on POWER7 and PPC970
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
Date: Fri, 1 Jul 2011 20:24:53 +0200
Message-Id: <01A65531-0F0C-4246-A7D6-CC8384257C88@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
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


On 29.06.2011, at 12:15, Paul Mackerras wrote:

> The first patch of the following series is a pure bug-fix for 32-bit
> kernels.
>=20
> The remainder of the following series of patches enable KVM to exploit
> the hardware hypervisor mode on 64-bit Power ISA Book3S machines.  At
> present, POWER7 and PPC970 processors are supported.  (Note that the
> PPC970 processors in Apple G5 machines don't have a usable hypervisor
> mode and are not supported by these patches.)
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
> These patches are against the master branch of the kvm tree.

Something seems to be broken with signals. When running without =
io-thread, I can't even do ctrl-c on -nographic while the guest is in =
sleep mode. But that might not be related to your patches.

I've applied 01-16 now. Sending them through some more testing and if =
they're good, sending a pull request.


Alex

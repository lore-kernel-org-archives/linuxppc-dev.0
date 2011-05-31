Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 067A9B6F7C
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 20:40:35 +1000 (EST)
Subject: Re: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110531064028.GA2533@brick.ozlabs.ibm.com>
Date: Tue, 31 May 2011 12:40:31 +0200
Message-Id: <B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
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


On 31.05.2011, at 08:40, Paul Mackerras wrote:

> The following series of patches enable KVM to exploit the hardware
> hypervisor mode on 64-bit Power ISA Book3S machines.  At present only
> POWER7 is supported, but it would be easy to add other processors.
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
> These patches are against Linus' v3.0-rc1 tree.

Thinking about the testability of this a bit more ... how much effort =
would it be to get this code running on a 970MP with SLOF? There should =
only be a few POWER7 specific pieces, right?


Alex

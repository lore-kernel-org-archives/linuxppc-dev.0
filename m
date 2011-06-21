Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BFDC9B6F8E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 19:53:19 +1000 (EST)
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
Date: Tue, 21 Jun 2011 11:53:13 +0200
Message-Id: <76643C33-517F-4E52-8DD9-BC1D923D925E@suse.de>
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

Could you please also add some mechanism that sets the guest machine =
type? We currently support 2:

  * bare metal
  * PAPR

BOOK3S_PR can't do PAPR (yet), BOOK3S_HV can't do bare metal (ever). =
User space needs to know about these limitations, so it can set the type =
accordingly and fail to start if kernel space can't provide it.

Since we might end up supporting PAPR even with _pr, it can't just be as =
simple as a CAP bitmap, since we really need to set the type.


Alex

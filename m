Return-Path: <paulus@ozlabs.org>
Date: Tue, 31 May 2011 16:40:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
Message-ID: <20110531064028.GA2533@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series of patches enable KVM to exploit the hardware
hypervisor mode on 64-bit Power ISA Book3S machines.  At present only
POWER7 is supported, but it would be easy to add other processors.

Running the KVM host in hypervisor mode means that the guest can use
both supervisor mode and user mode.  That means that the guest can
execute supervisor-privilege instructions and access supervisor-
privilege registers.  In addition the hardware directs most exceptions
to the guest.  Thus we don't need to emulate any instructions in the
host.  Generally, the only times we need to exit the guest are when it
does a hypercall or when an external interrupt or host timer
(decrementer) interrupt occurs.

The focus of this KVM implementation is to run guests that use the
PAPR (Power Architecture Platform Requirements) paravirtualization
interface, which is the interface supplied by PowerVM on IBM pSeries
machines.  Currently the "pseries" machine type in qemu is only
supported by book3s_hv KVM, and book3s_hv KVM only supports the
"pseries" machine type.  That will hopefully change in future.

These patches are against Linus' v3.0-rc1 tree.

Paul.

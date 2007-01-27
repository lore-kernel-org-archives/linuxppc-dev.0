Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29655DDFDE
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 05:30:41 +1100 (EST)
Date: Sat, 27 Jan 2007 11:30:28 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
Message-ID: <20070127183028.GA18523@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<17850.33971.762011.194195@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17850.33971.762011.194195@cargo.ozlabs.ibm.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 27, 2007 at 09:46:11AM +1100, Paul Mackerras wrote:
> Do you mean that x86 cpus themselves can actually be the target of a
> write on the bus?  That's the first time I've heard of the CPU itself
> being a target for a bus operation.

Though Eric gave a complete answer, I thought it was the Local-APIC
(onboard each CPU) is the target of the bus transaction. Intel
publishes the "Intel Interrupt Architecture" document and it describes
the API to the Local-APIC.  IA64 also uses an on-chip Local-APIC.

PA-RISC CPU (google for "PA-RISC External Interrupt Request Register")
is the target of _all_ IPI and IO interrupts (including MSI).
I think you'd find some of the comments in the PA-RISC interrupt
handling code interesting.
Look for txn_alloc_irq() in arch/parisc/kernel/irq.c.

My impression was any CPU that uses an IO-SAPIC (or -xAPIC) is
using bus transactions to communicate interrupts even if they
aren't using MSI. BIOS typically hides all the setup.

Alpha also uses bus transactions for IO interrupts. But I've read
through my ancient alpha reference manual and don't understand
exactly if the vector is part of the "DMA" transaction or is read
by the CPU off the I/O Bridge ("hose").

> Or do you mean there is some piece of hardware in the northbridge (or
> elsewhere) that accepts the MSI message writes and asserts an
> interrupt line to the CPU?  That is basically what we have on PPC.

*grin* PPC in this case looks more like "legacy x86" than x86 does today.
/me hides

hth,
grant

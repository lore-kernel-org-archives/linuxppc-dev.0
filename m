Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64BDADE174
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 13:47:00 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<17850.33971.762011.194195@cargo.ozlabs.ibm.com>
Date: Fri, 26 Jan 2007 19:46:22 -0700
In-Reply-To: <17850.33971.762011.194195@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 27 Jan 2007 09:46:11 +1100")
Message-ID: <m18xfpuqyp.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Eric W. Biederman writes:
>
>> I believe the ppc model is to allocate an interrupt source on their
>> existing interrupt controller and use that instead of the normal x86
>> case of having the MSI interrupt go transparently to the cpu.
>
> Do you mean that x86 cpus themselves can actually be the target of a
> write on the bus?  That's the first time I've heard of the CPU itself
> being a target for a bus operation.

Yes.  The cpu front side bus is packet based on all modern x86 processors,
and an irq message is one type of packet. 

> Or do you mean there is some piece of hardware in the northbridge (or
> elsewhere) that accepts the MSI message writes and asserts an
> interrupt line to the CPU?  That is basically what we have on PPC.

Nope, modern x86 cpus do not use external interrupt lines for normal
interrupts.

AMD cpus directly consume hypertransport and Intel cpus have a
proprietary but similarly capable protocol.

Eric

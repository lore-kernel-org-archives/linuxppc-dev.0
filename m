Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D68B5DE134
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 02:26:51 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
	<m18xfqw95v.fsf@ebiederm.dsl.xmission.com>
	<20070126074833.GF328@colo.lackof.org>
Date: Fri, 26 Jan 2007 08:26:13 -0700
In-Reply-To: <20070126074833.GF328@colo.lackof.org> (Grant Grundler's message
	of "Fri, 26 Jan 2007 00:48:33 -0700")
Message-ID: <m13b5xx10q.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Grundler <grundler@parisc-linux.org> writes:

> On Fri, Jan 26, 2007 at 12:15:40AM -0700, Eric W. Biederman wrote:
>> > Isn't the point of MSI to avoid any sort of interrupt controller?
>> 
>> That is how the supported platforms were designed.  But something needs
>> to translate a pci message to a cpu interrupt and on PPC apparently
>> they implemented this in their interrupt controller.
>> 
>> To be fair there are also ioapic on x86 which can do this as well
>> they just haven't been sufficiently interesting to support.
>
> Sorry, I'm not understanding your point...it's past my bedtime now
> and maybe tomorrow it will make more sense.
>
> I get the impression you are confusing Local-APIC with IO-APIC.
> The former catches MSI's on behalf of the CPU and
> the latter generates the equivalent of MSI's for IRQ lines.
> Any CPU that can support MSI's has either a Local-APIC or it's equivalent.
> (e.g. parisc or alpha)

Nope.  I'm talking about a feature that we don't use of some of Intels
IOAPICs.  All it requires is a range of addresses you can aim an
MSI at.

>> The interesting case will be when there is the equivalent of an
>> iommu for msi interrupts (and quite possibly it will be the iommu)
>> that filters iommu for hardware isolation purposes.
>
> IOMMU might give us better control over devices can write as long
> as it's always used and not bypassed (e.g. ZX1 chipset).
> Also, not all IOMMU can direct MSI transactions to a CPU.
> I thought some IOMMU implementation can only deal with cacheline
> sized transactions and I never had the impression MSI filled out
> a full cacheline. Anyway, I expect the "Virtual Machine Monitor"
> will own the IOMMU and expect that's the case in the IBM machines (RTAS
> boxen).

When you have a virtual machine monitor yes, but you might not always
have one.  The other use for that kind of hardware is isolating your
hardware devices so they can't do bad things to the rest of the system
no matter how buggy the hardware or the driver.

Anyway the point of the above was that there are things that makes sense
to exist between the device and the cpu.

Eric

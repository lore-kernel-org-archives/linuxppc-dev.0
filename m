Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rqRRf6mQVzDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 03:59:26 +1000 (AEST)
Date: Wed, 13 Jul 2016 18:58:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Dave Young <dyoung@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 bhe@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713175630.GA2668@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1911992.H2WpLRr2Fi@wuerfel> <20160712141810.GB30181@redhat.com>
 <293705810.hBL93OOmOz@wuerfel> <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
 <20160713093432.GB14522@leverpostej> <20160713173804.GA25723@porco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160713173804.GA25723@porco>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 02:38:06AM +0900, AKASHI Takahiro wrote:
> Apologies for the slow response. I'm attending LinuxCon this week.
> 
> On Wed, Jul 13, 2016 at 10:34:47AM +0100, Mark Rutland wrote:
> > On Wed, Jul 13, 2016 at 10:36:14AM +0800, Dave Young wrote:
> > > But consider we can kexec to a different kernel and a different initrd so there
> > > will be use cases to pass a total different dtb as well.
> > 
> > It depends on what you mean by "a different kernel", and what this
> > implies for the DTB.
> > 
> > I expect future arm64 Linux kernels to function with today's DTBs, and
> > the existing boot protocol. The kexec_file_load syscall already has
> > enough information for the kernel to inject the initrd and bootargs
> > properties into a DTB.
> > 
> > In practice on x86 today, kexec_file_load only supports booting to a
> > Linux kernel, because the in-kernel purgatory only implements the x86
> > Linux boot protocol. Analagously, for arm64 I think that the first
> > kernel should use its internal copy of the boot DTB, with /chosen fixed
> > up appropriately, assuming the next kernel is an arm64 Linux image.
> > 
> > If booting another OS, the only parts of the DTB I would expect to
> > change are the properties under chosen, as everything else *should* be
> > OS-independent. However the other OS may have a completely different
> > boot protocol, might not even take a DTB, and will likely need a
> > compeltely different purgatory implementation. So just allowing the DTB
> > to be altered isn't sufficient for that case.
> > 
> > There might be cases where we want a different DTB, but as far as I can
> > tell we have nothing analagous on x86 today. If we do need this, we
> > should have an idea of what real case(s) were trying to solve.
> 
> What I had in my mind was:
> 
> - Kdump
>   As Russel said, we definitely need to modify dtb.

I agree that *something* needs to modify the DTB to pass the cmdline and
initrd properties.

What I'm trying to point out that it isn't necessary that *userspace*
does so for the vast majority of kexec_file_load cases.

If userspace where to have to modify things dynamically, then you can't
have a secure deployment. Either you don't verify signatures on things
modified by userspace, giving a backdoor, or each machine has to have a
local copy of (locally) trusted private keys, which comes with other
risks (e.g. offline extraction of the keys).

>   In addition to bootargs and initrd proerties (FYI, in my arm64
>   implementation for arm64, eflcorehdr info is also passed as DT
>   property),

As pointed out, for kexec_file_load we can add code to the kernel can
add bootargs and initrd properties as necessary for this case. The
existing kexec_file_load prototype allows userspace to pass the required
information.

>   we may want to remove unnecessary devices and even add a dedicated
>   storage device for storing a core dump image.

I suspect that bringing up a minimal number of devices is better
controlled by a cmdline option. In general, figuring out what is
necessary and what is not is going to be board specific, so hacking the
FW tables (DTB or ACPI) is not a very portable/reliable approach.

Do we actually add devices in practice? More so than the above that
requires special knowledge of the platform (including things that were
not described in the boot DTB).

In the ACPI case modifying a DTB alone is not sufficient to change the
information regarding devices, as those won't be described in the DTB.
It's not possible to convert ACPI to DTB in general.

> - Say, booting BE kernel on ACPI LE kernel
>   In this case, there is no useful dtb in the kernel.

If the platform only has ACPI, then you cannot boot a BE kernel to begin
with. As above one cannot convert ACPI to DTB, so one would need
extensive platform knowledge for this to work.

I think it's fair to say that this is not a realistic/common case.

> Have said that, as Mark said, we may be able to use normal kexec_load
> system call if we don't need a "secure" kexec.
> 
> BTW, why doesn't the current kexec_load have ability of verifying
> a signature of initramfs image?

I believe the code was written before secure boot was a concern, and in
the absence of secure boot it was expected that a trusted userspace
would verify signatures itself.

> Is IMA/EVM expected to be used at runtime?

Sorry, I'm not sure what those abbreviations mean. Could you expand
them?

Thanks,
Mark.

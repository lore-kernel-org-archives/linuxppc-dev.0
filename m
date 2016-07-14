Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqf0K0qbFzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 11:54:57 +1000 (AEST)
Date: Thu, 14 Jul 2016 09:54:47 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 bhe@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160714015447.GB3121@dhcp-128-65.nay.redhat.com>
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

On 07/14/16 at 02:38am, AKASHI Takahiro wrote:
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
>   In addition to bootargs and initrd proerties (FYI, in my arm64
>   implementation for arm64, eflcorehdr info is also passed as DT
>   property), we may want to remove unnecessary devices and
>   even add a dedicated storage device for storing a core dump image.
> - Say, booting BE kernel on ACPI LE kernel
>   In this case, there is no useful dtb in the kernel.
> 
> Have said that, as Mark said, we may be able to use normal kexec_load
> system call if we don't need a "secure" kexec.
> 
> BTW, why doesn't the current kexec_load have ability of verifying
> a signature of initramfs image? Is IMA/EVM expected to be used
> at runtime?

I believe there are some limitations for verify signatures in kexec_load.
First kexec-tools need to be trusted, but there's no way to sign and
verify signature of shared libraries. There maybe other limitations I
can not remember which are also reasons why Vivek moved to current
file based syscall.

Thanks
Dave

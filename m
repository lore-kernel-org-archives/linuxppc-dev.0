Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rqDFg400PzDqKn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:35:03 +1000 (AEST)
Date: Wed, 13 Jul 2016 10:34:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Young <dyoung@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713093432.GB14522@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1911992.H2WpLRr2Fi@wuerfel> <20160712141810.GB30181@redhat.com>
 <293705810.hBL93OOmOz@wuerfel> <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 10:36:14AM +0800, Dave Young wrote:
> But consider we can kexec to a different kernel and a different initrd so there
> will be use cases to pass a total different dtb as well.

It depends on what you mean by "a different kernel", and what this
implies for the DTB.

I expect future arm64 Linux kernels to function with today's DTBs, and
the existing boot protocol. The kexec_file_load syscall already has
enough information for the kernel to inject the initrd and bootargs
properties into a DTB.

In practice on x86 today, kexec_file_load only supports booting to a
Linux kernel, because the in-kernel purgatory only implements the x86
Linux boot protocol. Analagously, for arm64 I think that the first
kernel should use its internal copy of the boot DTB, with /chosen fixed
up appropriately, assuming the next kernel is an arm64 Linux image.

If booting another OS, the only parts of the DTB I would expect to
change are the properties under chosen, as everything else *should* be
OS-independent. However the other OS may have a completely different
boot protocol, might not even take a DTB, and will likely need a
compeltely different purgatory implementation. So just allowing the DTB
to be altered isn't sufficient for that case.

There might be cases where we want a different DTB, but as far as I can
tell we have nothing analagous on x86 today. If we do need this, we
should have an idea of what real case(s) were trying to solve.

Thanks,
Mark.

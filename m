Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDrS6P4rzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:22:16 +1000 (AEST)
Subject: Re: VDSO unmap and remap support for additional architectures
To: Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, dsafonov@virtuozzo.com
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <2ce7203f-305c-6edf-0ef9-448c141cb103@kernel.org>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <57236003.5060804@codeaurora.org>
Date: Fri, 29 Apr 2016 09:22:11 -0400
MIME-Version: 1.0
In-Reply-To: <2ce7203f-305c-6edf-0ef9-448c141cb103@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andy,

On 04/28/2016 02:53 PM, Andy Lutomirski wrote:
> On 04/28/2016 08:18 AM, Christopher Covington wrote:
>> Please take a look at the following prototype of sharing the PowerPC
>> VDSO unmap and remap code with other architectures. I've only hooked
>> up arm64 to begin with. If folks think this is a reasonable approach I
>> can work on 32 bit ARM as well. Not hearing back from an earlier
>> request for guidance [1], I simply dove in and started hacking.
>> Laurent's test case [2][3] is a compelling illustration of whether VDSO
>> remap works or not on a given architecture.
> 
> I think there's a much nicer way:
> 
> https://lkml.kernel.org/r/1461584223-9418-1-git-send-email-dsafonov@virtuozzo.com
> 
> Could arm64 and ppc use this approach?  These arch_xyz hooks are gross.

Thanks for the pointer. Any thoughts on how to keep essentially
identical definitions of vdso_mremap from proliferating into every
architecture and variant?

> Also, at some point, possibly quite soon, x86 will want a way for
> user code to ask the kernel to map a specific vdso variant at a specific
> address. Could we perhaps add a new pair of syscalls:
> 
> struct vdso_info {
>     unsigned long space_needed_before;
>     unsigned long space_needed_after;
>     unsigned long alignment;
> };
> 
> long vdso_get_info(unsigned int vdso_type, struct vdso_info *info);
> 
> long vdso_remap(unsigned int vdso_type, unsigned long addr, unsigned int flags);
> 
> #define VDSO_X86_I386 0
> #define VDSO_X86_64 1
> #define VDSO_X86_X32 2
> // etc.
> 
> vdso_remap will map the vdso of the chosen type such at
> AT_SYSINFO_EHDR lines up with addr. It will use up to
> space_needed_before bytes before that address and space_needed_after
> after than address. It will also unmap the old vdso (or maybe only do
> that if some flag is set).
> 
> On x86, mremap is *not* sufficient for everything that's needed,
> because some programs will need to change the vdso type.

I don't I understand. Why can't people just exec() the ELF type that
corresponds to the VDSO they want?

Thanks,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

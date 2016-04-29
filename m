Return-Path: <dsafonov@virtuozzo.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0133.outbound.protection.outlook.com [157.56.112.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxGK40NtszDxYd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 00:28:39 +1000 (AEST)
Subject: Re: VDSO unmap and remap support for additional architectures
To: Christopher Covington <cov@codeaurora.org>, Andy Lutomirski
 <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 <criu@openvz.org>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <2ce7203f-305c-6edf-0ef9-448c141cb103@kernel.org>
 <57236003.5060804@codeaurora.org>
From: Dmitry Safonov <dsafonov@virtuozzo.com>
Message-ID: <572367B7.6030105@virtuozzo.com>
Date: Fri, 29 Apr 2016 16:55:03 +0300
MIME-Version: 1.0
In-Reply-To: <57236003.5060804@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2016 04:22 PM, Christopher Covington wrote:
> On 04/28/2016 02:53 PM, Andy Lutomirski wrote:
>> Also, at some point, possibly quite soon, x86 will want a way for
>> user code to ask the kernel to map a specific vdso variant at a specific
>> address. Could we perhaps add a new pair of syscalls:
>>
>> struct vdso_info {
>>      unsigned long space_needed_before;
>>      unsigned long space_needed_after;
>>      unsigned long alignment;
>> };
>>
>> long vdso_get_info(unsigned int vdso_type, struct vdso_info *info);
>>
>> long vdso_remap(unsigned int vdso_type, unsigned long addr, unsigned int flags);
>>
>> #define VDSO_X86_I386 0
>> #define VDSO_X86_64 1
>> #define VDSO_X86_X32 2
>> // etc.
>>
>> vdso_remap will map the vdso of the chosen type such at
>> AT_SYSINFO_EHDR lines up with addr. It will use up to
>> space_needed_before bytes before that address and space_needed_after
>> after than address. It will also unmap the old vdso (or maybe only do
>> that if some flag is set).
>>
>> On x86, mremap is *not* sufficient for everything that's needed,
>> because some programs will need to change the vdso type.
> I don't I understand. Why can't people just exec() the ELF type that
> corresponds to the VDSO they want?

I may say about my needs in it: to not lose all the existing
information in application.
Imagine you're restoring a container with 64-bit and 32-bit
applications (in compatible mode). So you need somehow
switch vdso type in restorer for a 32-bit application.
Yes, you may exec() and then - all already restored application
properties will got lost. You will need to transpher information
about mappings, make protocol between restorer binary
and main criu application, finally you'll end up with some
really much more difficult architecture than it is now.
And it'll be slower.

Also it's pretty logical: if one can switch between modes,
why can't he change vdso mapping to mode he got to?
(note: if the work about removing thread compatible flags
will be done (on x86), there will not even be such a thing,
as application mode - just difference on which syscalls it
uses: compatible or native).

Thanks,
     Dmitry Safonov

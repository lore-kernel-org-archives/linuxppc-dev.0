Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzvf315lYzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 07:37:30 +1000 (AEST)
Subject: Re: VDSO unmap and remap support for additional architectures
To: Dmitry Safonov <dsafonov@virtuozzo.com>, Andy Lutomirski
 <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 criu@openvz.org, Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 "CRIU@openvz.org" <CRIU@openvz.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <2ce7203f-305c-6edf-0ef9-448c141cb103@kernel.org>
 <57236003.5060804@codeaurora.org> <572367B7.6030105@virtuozzo.com>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <57291A15.8010105@codeaurora.org>
Date: Tue, 3 May 2016 17:37:25 -0400
MIME-Version: 1.0
In-Reply-To: <572367B7.6030105@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2016 09:55 AM, Dmitry Safonov wrote:
> On 04/29/2016 04:22 PM, Christopher Covington wrote:
>> On 04/28/2016 02:53 PM, Andy Lutomirski wrote:
>>> Also, at some point, possibly quite soon, x86 will want a way for
>>> user code to ask the kernel to map a specific vdso variant at a specific
>>> address. Could we perhaps add a new pair of syscalls:
>>>
>>> struct vdso_info {
>>>      unsigned long space_needed_before;
>>>      unsigned long space_needed_after;
>>>      unsigned long alignment;
>>> };
>>>
>>> long vdso_get_info(unsigned int vdso_type, struct vdso_info *info);
>>>
>>> long vdso_remap(unsigned int vdso_type, unsigned long addr, unsigned
>>> int flags);
>>>
>>> #define VDSO_X86_I386 0
>>> #define VDSO_X86_64 1
>>> #define VDSO_X86_X32 2
>>> // etc.
>>>
>>> vdso_remap will map the vdso of the chosen type such at
>>> AT_SYSINFO_EHDR lines up with addr. It will use up to
>>> space_needed_before bytes before that address and space_needed_after
>>> after than address. It will also unmap the old vdso (or maybe only do
>>> that if some flag is set).
>>>
>>> On x86, mremap is *not* sufficient for everything that's needed,
>>> because some programs will need to change the vdso type.
>> I don't I understand. Why can't people just exec() the ELF type that
>> corresponds to the VDSO they want?
> 
> I may say about my needs in it: to not lose all the existing
> information in application.
> Imagine you're restoring a container with 64-bit and 32-bit
> applications (in compatible mode). So you need somehow
> switch vdso type in restorer for a 32-bit application.
> Yes, you may exec() and then - all already restored application
> properties will got lost. You will need to transpher information
> about mappings, make protocol between restorer binary
> and main criu application, finally you'll end up with some
> really much more difficult architecture than it is now.
> And it'll be slower.

Perhaps a more modest exec based strategy would be for x86_64 criu to
handle all of the x86_64 restores as usual but exec i386 and/or x32 criu
service daemons and use them for restoring applications needing those ABIs.

Regards,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

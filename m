Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 394871A011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:37:45 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 10:37:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F58F1B0806B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:38:06 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QAbdtY3342694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:37:39 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QAbZE9027874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:37:39 -0600
Message-ID: <5513E16D.1030101@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 11:37:33 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com>
 <1427317867.6468.87.camel@kernel.crashing.org>
 <20150326094330.GA15407@gmail.com>
In-Reply-To: <20150326094330.GA15407@gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 cov@codeaurora.org, user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/03/2015 10:43, Ingo Molnar wrote:
> 
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> On Wed, 2015-03-25 at 19:36 +0100, Ingo Molnar wrote:
>>> * Ingo Molnar <mingo@kernel.org> wrote:
>>>
>>>>> +#define __HAVE_ARCH_REMAP
>>>>> +static inline void arch_remap(struct mm_struct *mm,
>>>>> +			      unsigned long old_start, unsigned long old_end,
>>>>> +			      unsigned long new_start, unsigned long new_end)
>>>>> +{
>>>>> +	/*
>>>>> +	 * mremap() doesn't allow moving multiple vmas so we can limit the
>>>>> +	 * check to old_start == vdso_base.
>>>>> +	 */
>>>>> +	if (old_start == mm->context.vdso_base)
>>>>> +		mm->context.vdso_base = new_start;
>>>>> +}
>>>>
>>>> mremap() doesn't allow moving multiple vmas, but it allows the 
>>>> movement of multi-page vmas and it also allows partial mremap()s, 
>>>> where it will split up a vma.
>>>
>>> I.e. mremap() supports the shrinking (and growing) of vmas. In that 
>>> case mremap() will unmap the end of the vma and will shrink the 
>>> remaining vDSO vma.
>>>
>>> Doesn't that result in a non-working vDSO that should zero out 
>>> vdso_base?
>>
>> Right. Now we can't completely prevent the user from shooting itself 
>> in the foot I suppose, though there is a legit usage scenario which 
>> is to move the vDSO around which it would be nice to support. I 
>> think it's reasonable to put the onus on the user here to do the 
>> right thing.
> 
> I argue we should use the right condition to clear vdso_base: if the 
> vDSO gets at least partially unmapped. Otherwise there's little point 
> in the whole patch: either correctly track whether the vDSO is OK, or 
> don't ...

That's a good option, but it may be hard to achieve in the case the vDSO
area has been splitted in multiple pieces.

Not sure there is a right way to handle that, here this is a best
effort, allowing a process to unmap its vDSO and having the sigreturn
call done through the stack area (it has to make it executable).

Anyway I'll dig into that, assuming that the vdso_base pointer should be
clear if a part of the vDSO is moved or unmapped. The patch will be
larger since I'll have to get the vDSO size which is private to the
vdso.c file.

> There's also the question of mprotect(): can users mprotect() the vDSO 
> on PowerPC?

Yes, mprotect() the vDSO is allowed on PowerPC, as it is on x86, and
certainly all the other architectures.
Furthermore, if it is done on a partial part of the vDSO it is splitting
the vma...

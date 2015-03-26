Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E0581A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:14:04 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 10:14:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C954817D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:14:26 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QADwRZ8061354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:13:58 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QADtxI024090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:13:58 -0600
Message-ID: <5513DBE1.4070404@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 11:13:53 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com>
 <1427317797.6468.86.camel@kernel.crashing.org>
 <20150326094844.GB15407@gmail.com>
In-Reply-To: <20150326094844.GB15407@gmail.com>
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

On 26/03/2015 10:48, Ingo Molnar wrote:
> 
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>>>> +#define __HAVE_ARCH_REMAP
>>>> +static inline void arch_remap(struct mm_struct *mm,
>>>> +			      unsigned long old_start, unsigned long old_end,
>>>> +			      unsigned long new_start, unsigned long new_end)
>>>> +{
>>>> +	/*
>>>> +	 * mremap() doesn't allow moving multiple vmas so we can limit the
>>>> +	 * check to old_start == vdso_base.
>>>> +	 */
>>>> +	if (old_start == mm->context.vdso_base)
>>>> +		mm->context.vdso_base = new_start;
>>>> +}
>>>
>>> mremap() doesn't allow moving multiple vmas, but it allows the 
>>> movement of multi-page vmas and it also allows partial mremap()s, 
>>> where it will split up a vma.
>>>
>>> In particular, what happens if an mremap() is done with 
>>> old_start == vdso_base, but a shorter end than the end of the vDSO? 
>>> (i.e. a partial mremap() with fewer pages than the vDSO size)
>>
>> Is there a way to forbid splitting ? Does x86 deal with that case at 
>> all or it doesn't have to for some other reason ?
> 
> So we use _install_special_mapping() - maybe PowerPC does that too? 
> That adds VM_DONTEXPAND which ought to prevent some - but not all - of 
> the VM API weirdnesses.

The same is done on PowerPC. So calling mremap() to extend the vDSO is
failing but splitting it or unmapping a part of it is allowed but lead
to an unusable vDSO.

> On x86 we'll just dump core if someone unmaps the vdso.

On PowerPC, you'll get the same result.

Should we prevent the user to break its vDSO ?

Thanks,
Laurent.

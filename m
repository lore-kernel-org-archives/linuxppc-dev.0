Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvB8s37JJzDqPT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 06:14:37 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6JKEBZd009941
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 16:14:35 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r8j6fq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 16:14:35 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 19 Jul 2016 21:14:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB2E71B08023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 21:15:54 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6JKEV591704194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 20:14:31 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6JKERwR029795
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:14:30 -0600
Subject: Re: [PATCH v3 02/11] mm: Hardened usercopy
To: Kees Cook <keescook@chromium.org>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <578DF109.5030704@de.ibm.com>
 <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 Daniel Micay <danielmicay@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>,
 Vitaly Wool <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Dmitry Vyukov <dvyukov@google.com>, Laura Abbott
 <labbott@fedoraproject.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Jul 2016 22:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKRDuELqGY1F-D4+MD+dMXSbiPGzf1hXb7Kp8ACBjpw9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <578E8A22.5080807@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2016 09:31 PM, Kees Cook wrote:
> On Tue, Jul 19, 2016 at 2:21 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> On 07/15/2016 11:44 PM, Kees Cook wrote:
>>> +config HAVE_ARCH_LINEAR_KERNEL_MAPPING
>>> +     bool
>>> +     help
>>> +       An architecture should select this if it has a secondary linear
>>> +       mapping of the kernel text. This is used to verify that kernel
>>> +       text exposures are not visible under CONFIG_HARDENED_USERCOPY.
>>
>> I have trouble parsing this. (What does secondary linear mapping mean?)
> 
> I likely need help clarifying this language...
> 
>> So let me give an example below
>>
>>> +
>> [...]
>>> +/* Is this address range in the kernel text area? */
>>> +static inline const char *check_kernel_text_object(const void *ptr,
>>> +                                                unsigned long n)
>>> +{
>>> +     unsigned long textlow = (unsigned long)_stext;
>>> +     unsigned long texthigh = (unsigned long)_etext;
>>> +
>>> +     if (overlaps(ptr, n, textlow, texthigh))
>>> +             return "<kernel text>";
>>> +
>>> +#ifdef HAVE_ARCH_LINEAR_KERNEL_MAPPING
>>> +     /* Check against linear mapping as well. */
>>> +     if (overlaps(ptr, n, (unsigned long)__va(__pa(textlow)),
>>> +                  (unsigned long)__va(__pa(texthigh))))
>>> +             return "<linear kernel text>";
>>> +#endif
>>> +
>>> +     return NULL;
>>> +}
>>
>> s390 has an address space for user (primary address space from 0..4TB/8PB) and a separate
>> address space (home space from 0..4TB/8PB) for the kernel. In this home space the kernel
>> mapping is virtual containing the physical memory as well as vmalloc memory (creating aliases
>> into the physical one). The kernel text is mapped from _stext to _etext in this mapping.
>> So I assume this would qualify for HAVE_ARCH_LINEAR_KERNEL_MAPPING ?
> 
> If I understand your example, yes. In the home space you have two
> addresses that reference the kernel image?

No, there is only one address that points to the kernel.
As we have no kernel ASLR yet, and the kernel mapping is 
a 1:1 mapping from 0 to memory end and the kernel is only
from _stext to _etext. The vmalloc area contains modules
and vmalloc but not a 2nd kernel mapping.

But thanks for your example, now I understood. If we have only
one address 
>>> +     if (overlaps(ptr, n, textlow, texthigh))
>>> +             return "<kernel text>";

This is just enough.

So what about for the CONFIG text:

       An architecture should select this if the kernel mapping has a secondary
       linear mapping of the kernel text - in other words more than one virtual
       kernel address that points to the kernel image. This is used to verify 
       that kernel text exposures are not visible under CONFIG_HARDENED_USERCOPY.


> I wonder if I can avoid the CONFIG entirely if I just did a
> __va(__pa(_stext)) != _stext test... would that break anyone?

Can this be resolved on all platforms at compile time?

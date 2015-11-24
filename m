Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCDB71A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 00:58:57 +1100 (AEDT)
Received: by ykba77 with SMTP id a77so18835826ykb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 05:58:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87io4rfxu5.fsf@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1SWE-yHrgCb5PN48mb40C-RoyGGOrYiMJu5KFZ_W4hWw@mail.gmail.com>
 <87io4rfxu5.fsf@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 16:58:55 +0300
Message-ID: <CAOJe8K0RfSCRSAaia+mj8g=HeehFabHLYf73L_G+wMVWjGYiCQ@mail.gmail.com>
Subject: Re: [PATCH V5 30/31] powerpc/mm: Move THP headers around
From: Denis Kirjanov <kda@linux-powerpc.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
>
>> On 11/23/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>> We support THP only with book3s_64 and 64K page size. Move
>>> THP details to hash64-64k.h to clarify the same.
> ...
>
>>> -static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
>>> -					  unsigned long addr, pmd_t *pmdp,
>>> -					  unsigned long old_pmd)
>>> -{
>>> -
>>> -	WARN(1, "%s called with THP disabled\n", __func__);
>> We can't reach this function with huge pages disabled, right?
>> Would it be better to use WARN_ON_ONCE?
>
> Shouldn't matter, if should never get called and if we get called, them
> something is really wrong, and mostly need a kernel fix. This will only
> happen during devel mistakes.

Ok, we can put the BUG() macro then, but as I know Linus doesn't like it :)
So WARN() is fine I think

>
> -aneesh
>
>

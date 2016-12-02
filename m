Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVJVJ4RLnzDvxk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 13:47:52 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tVJVH39lNz9tB1
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2016 13:47:51 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so6393718pgx.3
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2016 18:47:51 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: Move prototypes for KVM functions into
 kvm_ppc.h
In-Reply-To: <87d1hb855c.fsf@concordia.ellerman.id.au>
References: <20161201033004.2yh4txylpayxzmpu@oak.ozlabs.ibm.com>
 <87d1hb855c.fsf@concordia.ellerman.id.au>
Date: Fri, 02 Dec 2016 13:47:45 +1100
Message-ID: <87zikfgi7i.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> This moves the prototypes for functions that are only called from
>> assembler code out of asm/asm-prototypes.h into asm/kvm_ppc.h.
>> The prototypes were added in commit ebe4535fbe7a ("KVM: PPC:
>> Book3S HV: sparse: prototypes for functions called from assembler",
>> 2016-10-10), but given that the functions are KVM functions,
>> having them in a KVM header will be better for long-term
>> maintenance.
>>
>> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
>> ---
>> [For information; I intend to merge this through the KVM tree.]
>>
>>  arch/powerpc/include/asm/asm-prototypes.h | 44 -------------------------------
>>  arch/powerpc/include/asm/kvm_ppc.h        | 42 +++++++++++++++++++++++++++++
>>  arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 -
>>  arch/powerpc/kvm/book3s_hv_builtin.c      |  1 -
>>  arch/powerpc/kvm/book3s_hv_ras.c          |  2 +-
>>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 -
>>  arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 -
>>  7 files changed, 43 insertions(+), 49 deletions(-)
>
> LGTM.
>
> None of these are EXPORT_SYMBOL'ed, so moving them out of
> asm-prototypes.h is safe from that POV.
>
> cheers

Looks good to me too.

Regards,
Daniel

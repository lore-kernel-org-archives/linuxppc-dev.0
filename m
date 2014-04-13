Return-Path: <kernelfans@gmail.com>
Received: from mail-yk0-f177.google.com (mail-yk0-f177.google.com
 [209.85.160.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7ED014008C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Apr 2014 12:27:10 +1000 (EST)
Received: by mail-yk0-f177.google.com with SMTP id q200so6294633ykb.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 19:27:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3DC9A8E1-547C-4660-AB61-BE371DEDA520@suse.de>
References: <1397216707-12795-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <3DC9A8E1-547C-4660-AB61-BE371DEDA520@suse.de>
Date: Sun, 13 Apr 2014 10:27:06 +0800
Message-ID: <CAFgQCTsbr9_Y24upMSuOTqdO-gAVySBxW=o6uK2UKHk9=uQihw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: kvm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Liu Ping Fan <pingfank@linux.vnet.ibm.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2014 at 10:03 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 11.04.2014, at 13:45, Liu Ping Fan <pingfank@linux.vnet.ibm.com> wrote=
:
>
>> When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate=
_range_start
>> and mmu_notifier_invalidate_range_end, which will mark existing guest hp=
te
>> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
>> guest hpte entries.
>
> What happens when we don't? Why do we need the check? Why isn't it done i=
mplicitly? What happens when we treat a NUMA marked page as non-present? Wh=
y does it work out for us?
>
> Assume you have no idea what PAGE_NUMA is, but try to figure out what thi=
s patch does and whether you need to cherry-pick it into your downstream ke=
rnel. The description as is still is not very helpful for that. It doesn't =
even explain what really changes with this patch applied.
>
Yeah.  what about appending the following description?  Can it make
the context clear?
"Guest should not setup a hpte for the page whose pte is marked with
_PAGE_NUMA, so on the host, the numa-fault mechanism can take effect
to check whether the page is placed correctly or not."

>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> v3:
>>  rebased onto Alex's tree, branch kvm-ppc-next
>>  substitue commit log with the more clear description in Aneesh's reply =
(thanks, Aneesh)
>> ---
>> arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book=
3s_hv_rm_mmu.c
>> index 1d6c56a..1117525 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
>> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
>> @@ -234,7 +234,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned lon=
g flags,
>>               pte_size =3D psize;
>>               pte =3D lookup_linux_pte_and_update(pgdir, hva, writing,
>>                                                 &pte_size);
>> -             if (pte_present(pte)) {
>> +             if (pte_present(pte)&&!pte_numa(pte)) {
>
> Spaces missing
>
Will fix,

Thx,
Fan

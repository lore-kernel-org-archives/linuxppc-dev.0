Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x235.google.com (mail-qe0-x235.google.com
 [IPv6:2607:f8b0:400d:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3468A2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 13:12:04 +1100 (EST)
Received: by mail-qe0-f53.google.com with SMTP id cy11so1347532qeb.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 18:11:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CF6D863C-3E0A-4BEF-B985-77B336BA92F1@suse.de>
References: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383805375-14766-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <CF6D863C-3E0A-4BEF-B985-77B336BA92F1@suse.de>
Date: Fri, 8 Nov 2013 10:11:59 +0800
Message-ID: <CAFgQCTvsj6Ziif2YWOktC17oLWZkzoZaeDU70yg4vUAcRG58Tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/kvm: remove redundant assignment
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 7, 2013 at 6:06 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 07.11.2013, at 07:22, Liu Ping Fan <kernelfans@gmail.com> wrote:
>
>> ret is assigned twice with the same value, so remove the later one.
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> Acked-by: Paul Mackerras <paulus@samba.org>
>
> I suppose my last request for a patch description was slightly too abbrev=
iated :). Sorry about that.
>
> Imagine you are a Linux-stable maintainer. You have about 5000 patches in=
 front of you and you want to figure out whether a patch should get backpor=
ted into a stable tree or not.
>
> It's very easy to read through the patch description.
> It's reasonably easy to do a git show on the patch.
> It's very hard to look at the actual surrounding code that was changed.
>
> If I open a text editor on the file, I immediately see what you're saying=
:
>
>>         ret =3D RESUME_GUEST;
>>         preempt_disable();
>>         while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>>                 cpu_relax();
>>         if ((hptep[0] & ~HPTE_V_HVLOCK) !=3D hpte[0] || hptep[1] !=3D hp=
te[1] ||
>>             rev->guest_rpte !=3D hpte[2])
>>                 /* HPTE has been changed under us; let the guest retry *=
/
>>                 goto out_unlock;
>>         hpte[0] =3D (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
>>
>>         rmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>>         lock_rmap(rmap);
>>
>>         /* Check if we might have been invalidated; let the guest retry =
if so */
>>         ret =3D RESUME_GUEST;
>
> However, that scope is not given in the actual patch itself. If you look =
at the diff below, you have no idea whether the patch is fixing a bug or ju=
st removes duplication and doesn't actually have any effect. In fact, the c=
ompiled assembly should be the same with this patch and without. But you ca=
n't tell from the diff below.
>
> So what I would like to see in the patch description is something that ma=
kes it easy to understand what's going on without the need to check out the=
 source file. Something like
>
>> We redundantly set ret to RESUME_GUEST twice without changing it in betw=
een. Only do it once:
>>
>>         ret =3D RESUME_GUEST;
>>         preempt_disable();
>>         while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>>                 cpu_relax();
>>         if ((hptep[0] & ~HPTE_V_HVLOCK) !=3D hpte[0] || hptep[1] !=3D hp=
te[1] ||
>>             rev->guest_rpte !=3D hpte[2])
>>                 /* HPTE has been changed under us; let the guest retry *=
/
>>                 goto out_unlock;
>>         hpte[0] =3D (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
>>
>>         rmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>>         lock_rmap(rmap);
>>
>>         /* Check if we might have been invalidated; let the guest retry =
if so */
>>         ret =3D RESUME_GUEST;
>
>
> If I look at that patch description it immediately tells me "Ah, no need =
to worry, it's not a critical bug I need to backport". If you have a better=
 idea how to express that I'm more than happy to take that too. Otherwise j=
ust let me know whether you like the description above and I'll modify it t=
o the one that includes the code snippet when applying the patch.
>
Oh, yes. Thank you very much..
And I had a better understanding of the heavy work of maintainers :)
Will keep this in mind.

Best regards,
Pingfan

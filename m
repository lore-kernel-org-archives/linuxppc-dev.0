Return-Path: <geyslan@gmail.com>
Received: from mail-vk0-x22c.google.com (mail-vk0-x22c.google.com
 [IPv6:2607:f8b0:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 788D61A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 09:05:11 +1100 (AEDT)
Received: by vkbs1 with SMTP id s1so92032116vkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2015 14:05:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151129213300.GA28845@fergus.ozlabs.ibm.com>
References: <CAGG-pUS04iVsi3s4hkB8goWkCM3sq+QiLw7L74bbef93Z=+qwg@mail.gmail.com>
 <20151129213300.GA28845@fergus.ozlabs.ibm.com>
Date: Sun, 29 Nov 2015 19:05:08 -0300
Message-ID: <CAGG-pUQ+uZ_LXQmSq4xAXJGH61NbQj_riCF11t1O_FRdPx_1=Q@mail.gmail.com>
Subject: Re: [RFC] kvm - possible out of bounds
From: =?UTF-8?Q?Geyslan_Greg=C3=B3rio_Bem?= <geyslan@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-11-29 18:33 GMT-03:00 Paul Mackerras <paulus@ozlabs.org>:
> On Sun, Nov 29, 2015 at 05:14:03PM -0300, Geyslan Greg=C3=B3rio Bem wrote=
:
>> Hello,
>>
>> I have found a possible out of bounds reading in
>> arch/powerpc/kvm/book3s_64_mmu.c (kvmppc_mmu_book3s_64_xlate
>> function). pteg[] array could be accessed twice using the i variable
>> after the for iteration. What happens is that in the last iteration
>> the i index is incremented to 16, checked (i<16) then confirmed
>> exiting the loop.
>>
>> 277    for (i=3D0; i<16; i+=3D2) { ...
>>
>> Later there are reading attempts to the pteg last elements, but using
>> again the already incremented i (16).
>>
>> 303    v =3D be64_to_cpu(pteg[i]);  /* pteg[16] */
>> 304    r =3D be64_to_cpu(pteg[i+1]); /* pteg[17] */
>
> Was it some automated tool that came up with this?

Yep, cppcheck. As I'm still not engaged to a specific area in the
kernel, just trying to help with automated catches.

>
> There is actually no problem because the accesses outside the loop are
> only done if the 'found' variable is true; 'found' is initialized to
> false and only ever set to true inside the loop just before a break
> statement.  Thus there is a correlation between the value of 'i' and
> the value of 'found' -- if 'found' is true then we know 'i' is less
> than 16.

I figured it out after your explanation.

>
>> I really don't know if the for lace will somehow iterate until i is
>> 16, anyway I think that the last readings must be using a defined max
>> len/index or another more clear method.
>
> I think it's perfectly clear to a human programmer, though some tools
> (such as gcc) struggle with this kind of correlation between
> variables.  That's why I asked whether your report was based on the
> output from some tool.
>
>> Eg.
>>
>>     v =3D be64_to_cpu(pteg[PTEG_LEN - 2]);
>>     r =3D be64_to_cpu(pteg[PTEG_LEN - 1]);
>>
>> Or just.
>>
>>     v =3D be64_to_cpu(pteg[14]);
>>     r =3D be64_to_cpu(pteg[15]);
>
> Either of those options would cause the code to malfunction.

Yep, I understand now that v and r get the found ones. So i is needed.

>
>> I found in the same file a variable that is not used.
>>
>> 380    struct kvmppc_vcpu_book3s *vcpu_book3s;
>> ...
>> 387    vcpu_book3s =3D to_book3s(vcpu);
>
> True.  It could be removed.

I'll make a patch for that.

>
>> A question, the kvmppc_mmu_book3s_64_init function is accessed by
>> unconventional way? Because I have not found any calling to it.
>
> Try arch/powerpc/kvm/book3s_pr.c line 410:
>
>                 kvmppc_mmu_book3s_64_init(vcpu);
>
> Grep (or git grep) is your friend.

Hmm, indeed.

>
> Paul.

Thank you, Paul. If you have some other changes in progress let me know.

--=20
Regards,

Geyslan G. Bem
hackingbits.com

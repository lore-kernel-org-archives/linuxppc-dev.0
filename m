Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrPtN3Rd8zDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:52:28 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so1736240pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 00:52:28 -0700 (PDT)
Subject: Re: [PATCH V2 4/5] kvm/stats: Add provisioning for 64-bit vcpu
 statistics
To: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Matlack <dmatlack@google.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-4-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=e=hScxto3c=4rJ88Phg989UZhk+O44rV56obFP3v1SFg@mail.gmail.com>
 <9253603f-fbfb-09f1-9576-9291d1587397@redhat.com>
 <CALzav=cueDab=SQ0WmL6JcAY-18SLvcaVF9Zc1Ezs_f-eP7HOA@mail.gmail.com>
 <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
 <578681D6.8070801@de.ibm.com>
 <46eaef93-af3a-4dbb-eb3e-df3d63b1eb1c@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <57889634.9030302@gmail.com>
Date: Fri, 15 Jul 2016 17:52:20 +1000
MIME-Version: 1.0
In-Reply-To: <46eaef93-af3a-4dbb-eb3e-df3d63b1eb1c@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/07/16 19:42, Paolo Bonzini wrote:
>
> On 13/07/2016 20:00, Christian Borntraeger wrote:
>>>>>> I thought u64 still existed on 32-bit architectures. unsigned long
>>>>>> would be fine but with the caveat that certain stats would overflow on
>>>>>> 32-bit architectures.
>>>> Yes, but not all 32-bit architectures can do atomic read-modify-write
>>>> (e.g. add) operations on 64-bit values.
>> So what about only doing it for the VCPU events? Those should be only
>> modified by one CPU. We would have some odd values on 32bit overflow, but
>> this will be certainly better than just start with 0
> If that's good enough for PPC, that's fine.
>
> Paolo

I'm don't feel great about having vcpu_stats as u64 and vm_stats still as u32
it's just a bit inconsistent.

That being said, it's only the vcpu_stats which I require to be u64 at this
stage so it's possible to just upgrade those.

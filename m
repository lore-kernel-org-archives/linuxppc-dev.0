Return-Path: <dmatlack@google.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpFtt1Nm3zDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 05:45:25 +1000 (AEST)
Received: by mail-oi0-x236.google.com with SMTP id u201so162924635oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 12:45:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-4-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=e=hScxto3c=4rJ88Phg989UZhk+O44rV56obFP3v1SFg@mail.gmail.com>
 <9253603f-fbfb-09f1-9576-9291d1587397@redhat.com>
 <CALzav=cueDab=SQ0WmL6JcAY-18SLvcaVF9Zc1Ezs_f-eP7HOA@mail.gmail.com>
 <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 11 Jul 2016 12:45:04 -0700
Message-ID: <CALzav=dKq4GLcQQ8wQm9iNSbQPYK64224aAtz0ve06KPvSfUww@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] kvm/stats: Add provisioning for 64-bit vcpu
 statistics
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2016 at 12:31 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 11/07/2016 19:30, David Matlack wrote:
>> On Mon, Jul 11, 2016 at 10:05 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>
>>> On 11/07/2016 18:51, David Matlack wrote:
>>>>>> vcpus have statistics associated with them which can be viewed within the
>>>>>> debugfs. Currently it is assumed within the vcpu_stat_get() and
>>>>>> vcpu_stat_get_per_vm() functions that all of these statistics are
>>>>>> represented as 32-bit numbers. The next patch adds some 64-bit statistics,
>>>>>> so add provisioning for the display of 64-bit vcpu statistics.
>>>> Thanks, we need 64-bit stats in other places as well. Can we use this
>>>> opportunity to wholesale upgrade all KVM stats from u32 to u64? Most
>>>> of this patch is duplicated code with "u32" swapped with "u64".
>>>>
>>>
>>> I'm not sure of what 32-bit architectures would do, but perhaps we could
>>> upgrade them to unsigned long at least.
>>
>> I thought u64 still existed on 32-bit architectures. unsigned long
>> would be fine but with the caveat that certain stats would overflow on
>> 32-bit architectures.
>
> Yes, but not all 32-bit architectures can do atomic read-modify-write
> (e.g. add) operations on 64-bit values.

I think that's ok, none of the stats currently use atomic operations.

>
> Paolo

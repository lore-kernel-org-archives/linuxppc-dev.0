Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpXdK3sHpzDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 16:49:41 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id t190so522456pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 23:49:41 -0700 (PDT)
Subject: Re: [PATCH V2 3/5] kvm/ppc/book3s_hv: Implement halt polling in the
 kvm_hv kernel module
To: David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-3-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=cUiiQ=OW=qKZ=J1jOC2KUoA8HeD2P_y_4odfkjCMJ-fw@mail.gmail.com>
 <78e920ba-b596-5475-ff30-0dd2c23d97b6@redhat.com>
 <CALzav=dDJCKo1SchBJJmxU2WLdxvAkybXmR34L7C_cyDe750VA@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <57848F26.3060505@gmail.com>
Date: Tue, 12 Jul 2016 16:33:10 +1000
MIME-Version: 1.0
In-Reply-To: <CALzav=dDJCKo1SchBJJmxU2WLdxvAkybXmR34L7C_cyDe750VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/07/16 03:26, David Matlack wrote:
> On Mon, Jul 11, 2016 at 10:07 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 11/07/2016 18:57, David Matlack wrote:
>>> On Mon, Jul 11, 2016 at 12:08 AM, Suraj Jitindar Singh
>>> <sjitindarsingh@gmail.com> wrote:
>>>> This patch introduces new halt polling functionality into the kvm_hv kernel
>>>> module. When a vcore is idle it will poll for some period of time before
>>>> scheduling itself out.
>>> Is there any way to reuse the existing halt-polling code? Having two
>>> copies risks them diverging over time.
>> s/risks/guarantees/ :(
>>
>> Unfortunately, handling of the hardware threads in KVM PPC is a mess,
>> and I don't think it's possible to remove the duplication.
> Ah, ok. That's a shame.

It's definitely not ideal having this code duplicated, although we have
the issue that on PPC we only poll once all of the vcpus on a vcore have
ceded and need to retain a reference to that vcore.

Additionally we only actually do this in HV code, on the KVM PR
version we call the generic halt-polling code which doesn't know
about vcores.

I don't see an easy way to use the existing function.

>
>> Paolo

Return-Path: <dmatlack@google.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpBq06pxBzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 03:26:52 +1000 (AEST)
Received: by mail-oi0-x236.google.com with SMTP id r2so157687922oih.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 10:26:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <78e920ba-b596-5475-ff30-0dd2c23d97b6@redhat.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-3-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=cUiiQ=OW=qKZ=J1jOC2KUoA8HeD2P_y_4odfkjCMJ-fw@mail.gmail.com>
 <78e920ba-b596-5475-ff30-0dd2c23d97b6@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 11 Jul 2016 10:26:31 -0700
Message-ID: <CALzav=dDJCKo1SchBJJmxU2WLdxvAkybXmR34L7C_cyDe750VA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] kvm/ppc/book3s_hv: Implement halt polling in the
 kvm_hv kernel module
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

On Mon, Jul 11, 2016 at 10:07 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 11/07/2016 18:57, David Matlack wrote:
>> On Mon, Jul 11, 2016 at 12:08 AM, Suraj Jitindar Singh
>> <sjitindarsingh@gmail.com> wrote:
>> > This patch introduces new halt polling functionality into the kvm_hv kernel
>> > module. When a vcore is idle it will poll for some period of time before
>> > scheduling itself out.
>>
>> Is there any way to reuse the existing halt-polling code? Having two
>> copies risks them diverging over time.
>
> s/risks/guarantees/ :(
>
> Unfortunately, handling of the hardware threads in KVM PPC is a mess,
> and I don't think it's possible to remove the duplication.

Ah, ok. That's a shame.

>
> Paolo

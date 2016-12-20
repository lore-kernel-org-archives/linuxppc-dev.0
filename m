Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjNZh0trlzDwLZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 14:30:04 +1100 (AEDT)
Received: by mail-io0-x22b.google.com with SMTP id p42so169806053ioo.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:30:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMqctQJaLO_2_XhE7SGLyvQYvUEgxSNoussEiPvdpS2cDRc5w@mail.gmail.com>
References: <CAFgQCTv4SmBdp91BNKiy6PzijLCzyYHFoezZeqBVbJPwCP=PkA@mail.gmail.com>
 <CAOMqctQJaLO_2_XhE7SGLyvQYvUEgxSNoussEiPvdpS2cDRc5w@mail.gmail.com>
From: Liu ping fan <kernelfans@gmail.com>
Date: Tue, 20 Dec 2016 11:30:01 +0800
Message-ID: <CAFgQCTum4X2np+dV3-hkQ8MzvSwEEg-u7ZfCrZxDetdh9hOAgw@mail.gmail.com>
Subject: Re: a question about powervm
To: Michal Suchanek <hramrach@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 19, 2016 at 5:58 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> Hello,
>
> On 19 December 2016 at 10:09, Liu ping fan <kernelfans@gmail.com> wrote:
>> Hi guys,
>>
>> I am using a pSeries. It runs on powerVM.
>> My question is whether the cpuX under /sys/devices/system/cpu
>> corresponds to a real cpu or not.
>> I think it is not the same as the cpu on kvm-guest, which is emulated
>> by a linux process.
>
> In general the hypervisor (powerVM or KVM) needs to disable access of
> the guest to some CPU features in order to manage multiple guests. So
> some CPU features are either disabled or emulated by the hypervisor to
> prevent the guest from interfering with isolation of the guests from
> each other and the host. On the other hand, emulating the whole CPU is
> ineffective so to achieve reasonable guest speed it must run on a real
> CPU most of the time. That means that in most cases the CPU you see in
> the guest will have a subset of the features of the CPU the host sees.
>
Thank you for the explanation. And sorry not to explain my question clearly.
I wonders about the mapping between guest-CPU and physical cpu. On
powerVM, except the feature exposed by host, it is 1:1 map right?

> Some virtualization solutions allow to overcommit CPU time so you can
> allocate more CPUs to guests than you physically have. Then when
> running the guest will use an actual physical CPU but when it is
> sleeping other guest may use the CPU.
>
Yes, agree.

Thanks!

Return-Path: <hramrach@gmail.com>
Received: from mail-vk0-x229.google.com (mail-vk0-x229.google.com
 [IPv6:2607:f8b0:400c:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thxG01lF2zDwKg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:59:04 +1100 (AEDT)
Received: by mail-vk0-x229.google.com with SMTP id 137so117696097vkl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 01:59:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFgQCTv4SmBdp91BNKiy6PzijLCzyYHFoezZeqBVbJPwCP=PkA@mail.gmail.com>
References: <CAFgQCTv4SmBdp91BNKiy6PzijLCzyYHFoezZeqBVbJPwCP=PkA@mail.gmail.com>
From: Michal Suchanek <hramrach@gmail.com>
Date: Mon, 19 Dec 2016 10:58:20 +0100
Message-ID: <CAOMqctQJaLO_2_XhE7SGLyvQYvUEgxSNoussEiPvdpS2cDRc5w@mail.gmail.com>
Subject: Re: a question about powervm
To: Liu ping fan <kernelfans@gmail.com>
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

Hello,

On 19 December 2016 at 10:09, Liu ping fan <kernelfans@gmail.com> wrote:
> Hi guys,
>
> I am using a pSeries. It runs on powerVM.
> My question is whether the cpuX under /sys/devices/system/cpu
> corresponds to a real cpu or not.
> I think it is not the same as the cpu on kvm-guest, which is emulated
> by a linux process.

In general the hypervisor (powerVM or KVM) needs to disable access of
the guest to some CPU features in order to manage multiple guests. So
some CPU features are either disabled or emulated by the hypervisor to
prevent the guest from interfering with isolation of the guests from
each other and the host. On the other hand, emulating the whole CPU is
ineffective so to achieve reasonable guest speed it must run on a real
CPU most of the time. That means that in most cases the CPU you see in
the guest will have a subset of the features of the CPU the host sees.

Some virtualization solutions allow to overcommit CPU time so you can
allocate more CPUs to guests than you physically have. Then when
running the guest will use an actual physical CPU but when it is
sleeping other guest may use the CPU.

HTH

Michal

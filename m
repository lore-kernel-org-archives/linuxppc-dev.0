Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com
 [IPv6:2607:f8b0:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmQMS41ZHzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 16:02:12 +1100 (AEDT)
Received: by mail-vk0-x22e.google.com with SMTP id t126so244670vkb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:02:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vaeruemb.fsf@linux.vnet.ibm.com>
References: <20180221010111.30517-1-bsingharora@gmail.com>
 <87vaeruemb.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Feb 2018 16:02:08 +1100
Message-ID: <CAKTCnznDmHOmSyr8YHPbbUKD_4JpE61mL-NAy2sF07eQio0gbQ@mail.gmail.com>
Subject: Re: [RFC] powerpc/powernv/mce: Don't silently restart the machine
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 3:54 PM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>> On MCE the current code will restart the machine with
>> ppc_md.restart(). This case was extremely unlikely since
>> prior to that a skiboot call is made and that resulted in
>> a checkstop for analysis.
>>
>> With newer skiboots, on P9 we don't checkstop the box by
>> default, instead we return back to the kernel to extract
>> useful information at the time of the MCE. While we still
>> get this information, this patch converts the restart to
>> a panic(), so that if configured a dump can be taken and
>> we can track and probably debug the potential issue causing
>> the MCE.
>
> I agree with the patch, although I'd be nervous stating that skiboot is
> going to keep this behaviour. In *theory* we should only ever get a
> platform error when there's actually something that isn't the kernel's
> fault.
>
> Like any firmware promise though, it's slightly less reliable than one
> from a politician.
>
> I'd say that in this case deferring to policy on what to do in event of
> panic() is the right thing.
>

Your right, except that with NPUs and coherent device memory, things
change. It is a platform error on the device side, the large issue is
that the CPU touched this memory. Ideally we want the device and
device driver to handle this error, but its racy as the CPU now treats
it as a platform error on the system side. IOW, the definition of
platform has grown and so has the definition of platform error and it
can no longer be solely contained inside of one boxes firmware.

Balbir Singh.

Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyZn43fCxzDrn2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 13:55:52 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id p33so5318979uag.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 18:55:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171214233220.19f3b36d@roar.ozlabs.ibm.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
 <20171213080828.2800-2-bsingharora@gmail.com>
 <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
 <20171214111213.07ba99a4@gmail.com>
 <20171214115137.5603f77d@roar.ozlabs.ibm.com>
 <CAKTCnzkF0ntwaXs3STmCT0tNz-LZyyPnSMHh8rTG=oFQw7fL=w@mail.gmail.com>
 <20171214233220.19f3b36d@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 15 Dec 2017 13:55:49 +1100
Message-ID: <CAKTCnznRRNT3cBP911KGAbAPn=_7W9T6h_SdG9wu5nCfFsegKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel can
 get HMI's
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 12:32 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 14 Dec 2017 23:16:26 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> On Thu, Dec 14, 2017 at 12:51 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
>
>> >> I can't call smp_send_nmi_ipi due to the nmi_ipi_busy_count and
>> >> I'm worried about calling a stale nmi_ipi_function via the
>> >> system_reset_exception path, if we are OK with it, I can revisit
>> >> the code path
>> >
>> > You shouldn't get a stale one, that would also be a bug -- we
>> > have to cope with NMIs coming in at any time that are triggered
>> > externally (not by smp_send_nmi_ipi), so if you see any bugs
>> > there those need to be fixed separately.
>> >
>>
>> Yes, I think it's a bug, nothing clears nmi_ipi_function (from what
>> I can see), so when the next NMI comes in and goes into
>> pnv_system_reset_exception
>> it'll execute the stale handler.
>
> The CPU won't be in the nmi_ipi_pending_mask though, so it shouldn't
> get that far. You could add a bit of paranoia to clear the function
> pointer I suppose, but AFAIKS it's not needed.
>

Yep your right, but these things are so subtle :) I will as paranoia
cleanup nmi_ipi_function, but I'll add that as a TODO

Balbir Singh.

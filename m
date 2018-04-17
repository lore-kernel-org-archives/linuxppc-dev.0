Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QfvQ65KCzF1xg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 08:25:06 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id c3so13661598uae.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:25:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=nMDksZq_1pWXGqKFTQ8x5pO=Ojw=TQdPkT+ZqBwEGwA@mail.gmail.com>
References: <20180417091129.23069-1-alistair@popple.id.au>
 <CAKTCnz=nMDksZq_1pWXGqKFTQ8x5pO=Ojw=TQdPkT+ZqBwEGwA@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 18 Apr 2018 08:25:03 +1000
Message-ID: <CAKTCnz=XURfUE68aUd0dV+Mo7O76iJTggiwukLBgigi-F8eDNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powernv/npu: Do a PID GPU TLB flush when invalidating
 a large address range
To: Alistair Popple <alistair@popple.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, arbab@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 7:17 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Tue, Apr 17, 2018 at 7:11 PM, Alistair Popple <alistair@popple.id.au> wrote:
>> The NPU has a limited number of address translation shootdown (ATSD)
>> registers and the GPU has limited bandwidth to process ATSDs. This can
>> result in contention of ATSD registers leading to soft lockups on some
>> threads, particularly when invalidating a large address range in
>> pnv_npu2_mn_invalidate_range().
>>
>> At some threshold it becomes more efficient to flush the entire GPU TLB for
>> the given MM context (PID) than individually flushing each address in the
>> range. This patch will result in ranges greater than 2MB being converted
>> from 32+ ATSDs into a single ATSD which will flush the TLB for the given
>> PID on each GPU.
>>
>> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>> +       }
>>  }
>>
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Balbir Singh <bsingharora@gmail.com>

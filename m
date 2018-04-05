Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gndn6ylLzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 13:00:55 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id f63-v6so9371641oic.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 20:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180405095755.58b3891f@roar.ozlabs.ibm.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-3-bsingharora@gmail.com>
 <20180405095755.58b3891f@roar.ozlabs.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Apr 2018 20:00:52 -0700
Message-ID: <CAPcyv4hqKsOy9GU=NcMGj38pXnuEMRhXfox6jVwQ37+mcjnvhA@mail.gmail.com>
Subject: Re: [RESEND 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <mawilcox@microsoft.com>, "Luck,
 Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ adding Matthew, Christoph, and Tony  ]

On Wed, Apr 4, 2018 at 4:57 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu,  5 Apr 2018 09:19:42 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> The pmem infrastructure uses memcpy_mcsafe in the pmem
>> layer so as to convert machine check excpetions into
>> a return value on failure in case a machine check
>> exception is encoutered during the memcpy.
>>
>> This patch largely borrows from the copyuser_power7
>> logic and does not add the VMX optimizations, largely
>> to keep the patch simple. If needed those optimizations
>> can be folded in.
>
> So memcpy_mcsafe doesn't return number of bytes copied?
> Huh, well that makes it simple.

Well, not in current kernels, but we need to add that support or
remove the direct call to copy_to_iter() in fs/dax.c. I'm looking
right now to add "bytes remaining" support to the x86 memcpy_mcsafe(),
but for copy_to_user we also need to handle bytes remaining for write
faults. That fix is hopefully something that can land in an early
4.17-rc, but it won't be ready for -rc1.

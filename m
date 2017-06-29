Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyyKp10mXzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:36:30 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id r62so11185726qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:36:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD002D97F@AcuExch.aculab.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
 <20170628170411.28864-3-bsingharora@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD002D97F@AcuExch.aculab.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 29 Jun 2017 21:36:27 +1000
Message-ID: <CAKTCnzkptf=p9SzpyFRtDXEHRMDznukFsaeFxVERZvDLq5Bf_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] powerpc/vmlinux.lds: Align __init_begin to 16M
To: David Laight <David.Laight@aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 9:29 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Balbir Singh
>> Sent: 28 June 2017 18:04
>> For CONFIG_STRICT_KERNEL_RWX align __init_begin to 16M.
>> We use 16M since its the larger of 2M on radix and 16M
>> on hash for our linear mapping. The plan is to have
>> .text, .rodata and everything upto __init_begin marked
>> as RX. Note we still have executable read only data.
>> We could further align rodata to another 16M boundary.
>> I've used keeping text plus rodata as read-only-executable
>> as a trade-off to doing read-only-executable for text and
>> read-only for rodata.
> ...
>
> Doesn't this go against 'address space randomisation'?
> (Yes I realise a PIC kernel is probably non-trivial to compile
> and load.)

I presume you mean Kernel ASLR. I am not sure why you think
it goes against KASLR, it's just aligning the _stext and __init_begin,
they can be anywhere in memory. I've tested with a relocatable kernel

Balbir Singh.

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7B8w4flgzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 18:56:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
In-Reply-To: <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
 <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
 <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
Date: Mon, 08 Aug 2016 18:56:13 +1000
Message-ID: <87vazbskpe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> On Friday 05 August 2016 12:23 AM, Hari Bathini wrote:
>> On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
>>> The code already knows how to reserve 5% based on the size of the 
>>> machine's
>>> memory, as long as no commandline parameter is passed. So why can't we
>>> just use that logic?
>>
>> That is the default value reserved but not a good enough value for
>> every case. It is a bit difficult to come up with a robust formula
>> that works for every case as new kernel changes could make the
>> values obsolete. But it won't be all that difficult to find values that
>> work for different memory ranges for a given kernel version.
>> Passing that as range based input with "fadump_reserve_mem"
>> parameter would work for every memory configuration on a
>> given system, which is what this patch is trying to provide..
>
> You want me to add this to the changelog on respin?

I'm not really convinced.

Distros are going to want to specify a fixed set of values for different
memory sizes, at least that's what I've seen in the past with kdump. So
I don't see why we can't just do that in the kernel with a formula based
on memory size, and maybe some other information.

Maybe the formula is more complicated than 5% of RAM, but it shouldn't
be *that* much more complicated.

cheers

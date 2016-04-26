Return-Path: <emachado@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvP1W6XZ7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 23:23:43 +1000 (AEST)
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qvP1V5nCbz9t5h
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 23:23:42 +1000 (AEST)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <emachado@linux.vnet.ibm.com>;
 Tue, 26 Apr 2016 10:23:37 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0F8441DC0072
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 09:23:25 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3QCLHnI4931682
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 09:21:17 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3QDNSfS031102
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 10:23:30 -0300
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
To: Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B4508.6060806@linux.vnet.ibm.com>
 <1460525779.30704.7.camel@ellerman.id.au>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 shuahkh@osg.samsung.com, akpm@linux-foundation.org, oleg@redhat.com,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 davej@redhat.com, tglx@linutronix.de, sukadev@linux.vnet.ibm.com,
 davem@davemloft.net, sam.bobroff@au1.ibm.com
From: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Message-ID: <571F6BCE.2050505@linux.vnet.ibm.com>
Date: Tue, 26 Apr 2016 10:23:26 -0300
MIME-Version: 1.0
In-Reply-To: <1460525779.30704.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2016 02:36 AM, Michael Ellerman wrote:
> On Mon, 2016-04-11 at 03:32 -0300, Edjunior Barbosa Machado wrote:
>> Hi Michael, Anshuman,
>>
>> I've managed to implement the GDB support for the new regsets and test
>> on Power8 (BE and LE).
> 
> Great work thanks!
> 
>> The following is an example of GDB 'info
>> registers all' partial output showing the new registers when inside a
>> suspended transaction on Power8 LE using this patchset. Please let me
>> know if you need any additional information or tests from GDB side.
> 
> What's the plan for merging the gdb changes?

Thanks for the feedback, Michael. I intend to submit the patches to the
gdb mailing list for review right after the kernel patchset is checked in.

> 
>> (gdb) info registers all
>> ...
>> dscr           0x0      0
>> ppr            0xc000000000000  3377699720527872
>> tar            0x0      0
>> ebbrr          <unavailable>
>> ebbhr          <unavailable>
>> bescr          <unavailable>
>> siar           <unavailable>
>> sdar           <unavailable>
>> sier           <unavailable>
>> mmcr2          <unavailable>
>> mmcr0          <unavailable>
>> tfhar          0x10002b30       268446512
>> texasr         0x110000098000001        76561196215435265
>> tfiar          0x10002ad9       268446425
>> cr0            0x10002b2c       268446508
> 
> Using 'c' as the prefix is a bit confusing here, as 'cr0' is usually used to
> refer to the CR0 field of CR.
> 
> Speaking of which, I don't see CR here? Or is it somewhere above in the ... ?
> 
> Maybe the prefix could be 'c_' ?
> 
> Or do other arches already use 'c' as the prefix?

Good point, I hadn't thought about the possible confusion with CR
register (CR doesn't appear in the excerpt because it is just a partial
output of 'info registers all', reduced to the new registers only). As
far as I am aware, we don't have other arches that use 'c' as prefix
(Are there other arches that provide checkpointed registers? s390 gdb
uses 't' as prefix, but for the transactional regs, which would be the
"opposite" of our checkpointed ones here, if I'm not mistaken), but this
can be changed with no difficult in gdb code.

Thanks and regards,
--
Edjunior Barbosa Machado

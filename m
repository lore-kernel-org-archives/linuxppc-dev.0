Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlCGD4m1PzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:36:20 +1000 (AEST)
Message-ID: <1460525779.30704.7.camel@ellerman.id.au>
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>,  linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, shuahkh@osg.samsung.com, oleg@redhat.com,
 dhowells@redhat.com,  Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 tglx@linutronix.de,  davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com,  sam.bobroff@au1.ibm.com
Date: Wed, 13 Apr 2016 15:36:19 +1000
In-Reply-To: <570B4508.6060806@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B4508.6060806@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-11 at 03:32 -0300, Edjunior Barbosa Machado wrote:
> Hi Michael, Anshuman,
> 
> I've managed to implement the GDB support for the new regsets and test
> on Power8 (BE and LE).

Great work thanks!

> The following is an example of GDB 'info
> registers all' partial output showing the new registers when inside a
> suspended transaction on Power8 LE using this patchset. Please let me
> know if you need any additional information or tests from GDB side.

What's the plan for merging the gdb changes?

> (gdb) info registers all
> ...
> dscr           0x0      0
> ppr            0xc000000000000  3377699720527872
> tar            0x0      0
> ebbrr          <unavailable>
> ebbhr          <unavailable>
> bescr          <unavailable>
> siar           <unavailable>
> sdar           <unavailable>
> sier           <unavailable>
> mmcr2          <unavailable>
> mmcr0          <unavailable>
> tfhar          0x10002b30       268446512
> texasr         0x110000098000001        76561196215435265
> tfiar          0x10002ad9       268446425
> cr0            0x10002b2c       268446508

Using 'c' as the prefix is a bit confusing here, as 'cr0' is usually used to
refer to the CR0 field of CR.

Speaking of which, I don't see CR here? Or is it somewhere above in the ... ?

Maybe the prefix could be 'c_' ?

Or do other arches already use 'c' as the prefix?

Otherwise looks good.

cheers

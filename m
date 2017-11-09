Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXg7H5xXtzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 21:55:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Torsten Duwe <duwe@lst.de>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
In-Reply-To: <20171107145233.lmlg5lkfcczkxj4d@treble>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de> <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au> <20171107113105.GA19204@lst.de>
 <20171107145233.lmlg5lkfcczkxj4d@treble>
Date: Thu, 09 Nov 2017 21:55:38 +1100
Message-ID: <87h8u3pvpx.fsf@concordia.ellerman.id.au>
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

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Tue, Nov 07, 2017 at 12:31:05PM +0100, Torsten Duwe wrote:
>> On Tue, Nov 07, 2017 at 07:34:29PM +1100, Michael Ellerman wrote:
>> > > So, just brainstorming a bit, here are the possible solutions I can
>> > > think of:
>> > >
>> > > a) Create a special klp stub for such calls (as in Kamalesh's patch)
>> > >
>> > > b) Have kpatch-build rewrite the function to insert nops after calls to
>> > >    previously-local functions.  This would also involve adjusting the
>> > >    offsets of intra-function branches and relocations which come
>> > >    afterwards in the same section.  And also patching up the DWARF
>> > >    debuginfo, if we care about that (I think we do).  And also patching
>> > >    up the jump tables which GCC sometimes creates for switch statements.
>> > >    Yuck.  I'm pretty sure this is a horrible idea.
>> > 
>> > It's fairly horrible. It might be *less* horrible if you generated an
>> > assembly listing using the compiler, modified that, and then fed that
>> > through the assembler and linker.
>
> Ah, that would work a lot better.

This should be fairly doable, you just need to spot function calls to
local symbols, eg. "bl bar", and if there's no nop trailing you add one.
The hard part is probably futzing with Makefiles to insert the extra step.

...
>> This might also be doable with a gcc "plugin", which would not require changes
>> to the compiler itself.
>
> Hm, that's not a bad idea.
>
>> OTOH there's no such thing as a weak static function...
>
> Yeah.  Instead of weak, maybe just make them global (remove the
> "static")?

I don't think that will work. The compiler still knows that the callee
is local to the caller, even if the callee is global.

Making the callee weak mans the compiler can't be sure the call will go
there, and so has to do a global call.

> Anyway, thanks for the ideas.  I may try them out and see what sticks.

Great, thanks for looking into it.

cheers

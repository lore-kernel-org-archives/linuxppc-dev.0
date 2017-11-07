Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWXTc5mQMzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 01:52:36 +1100 (AEDT)
Date: Tue, 7 Nov 2017 08:52:33 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171107145233.lmlg5lkfcczkxj4d@treble>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de>
 <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au>
 <20171107113105.GA19204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171107113105.GA19204@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2017 at 12:31:05PM +0100, Torsten Duwe wrote:
> On Tue, Nov 07, 2017 at 07:34:29PM +1100, Michael Ellerman wrote:
> > > So, just brainstorming a bit, here are the possible solutions I can
> > > think of:
> > >
> > > a) Create a special klp stub for such calls (as in Kamalesh's patch)
> > >
> > > b) Have kpatch-build rewrite the function to insert nops after calls to
> > >    previously-local functions.  This would also involve adjusting the
> > >    offsets of intra-function branches and relocations which come
> > >    afterwards in the same section.  And also patching up the DWARF
> > >    debuginfo, if we care about that (I think we do).  And also patching
> > >    up the jump tables which GCC sometimes creates for switch statements.
> > >    Yuck.  I'm pretty sure this is a horrible idea.
> > 
> > It's fairly horrible. It might be *less* horrible if you generated an
> > assembly listing using the compiler, modified that, and then fed that
> > through the assembler and linker.

Ah, that would work a lot better.

> > > c) Create a new GCC flag which treats all calls as global, which can be
> > >    used by kpatch-build to generate the right code (assuming this flag
> > >    doesn't already exist).  This would be a good option, I think.
> > 
> > That's not impossible, but I doubt it will be all that popular with the
> > toolchain folks who'd have to implement it :)  It will also take a long
> > time to percolate out to users.
> 
> BTDT ;-)

Yeah, maybe that's not so realistic.

> > > d) Have kpatch-build do some other kind of transformation?  For example,
> > >    maybe it could generate klp stubs which the callee calls into.  Each
> > >    klp stub could then do a proper global call to the SHN_LIVEPATCH
> > >    symbol.
> > 
> > That could work.
> Indeed. There is no reason to load that off onto the kernel module loader.

I agree that doing the same work in tooling would be better than adding
complexity to the kernel.

> > > Do I understand the problem correctly?  Do the potential solutions make
> > > sense?  Any other possible solutions I missed?
> > 
> > Possibly, I'm not really across how kpatch works in detail and what the
> > constraints are.
> > 
> > One option would be to detect any local calls made by the patched
> > function and pull those in as well - ie. make them part of the patch.
> > The pathological case could obviously end up pulling in every function
> > in the kernel, but in practice that's probably unlikely. It already
> > happens to some extent anyway via inlining.

That's definitely a possibility, but I'd rather not go there because it
increases risk and cognitive load.

> > If modifying the source is an option, a sneaky solution is to mark the
> > local functions as weak, which means the compiler/linker has to assume
> > they could become global calls.

That could work, but it means the patch author has to modify the patch.
I'd rather have tooling hide this problem somehow.

> This might also be doable with a gcc "plugin", which would not require changes
> to the compiler itself.

Hm, that's not a bad idea.

> OTOH there's no such thing as a weak static function...

Yeah.  Instead of weak, maybe just make them global (remove the
"static")?

Anyway, thanks for the ideas.  I may try them out and see what sticks.

-- 
Josh

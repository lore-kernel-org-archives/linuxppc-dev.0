Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWS193ldkzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 22:31:08 +1100 (AEDT)
Date: Tue, 7 Nov 2017 12:31:05 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171107113105.GA19204@lst.de>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de> <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760am4hd6.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2017 at 07:34:29PM +1100, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > On Tue, Oct 31, 2017 at 07:39:59PM +0100, Torsten Duwe wrote:
> >> On Tue, Oct 31, 2017 at 09:53:16PM +0530, Naveen N . Rao wrote:
> >> > On 2017/10/31 03:30PM, Torsten Duwe wrote:
> >> > > 
> >> > > Maybe I failed to express my views properly; I find the whole approach
> >> [...]
> >> > > NAK'd-by: Torsten Duwe <duwe@suse.de>
> >> > 
> >> > Hmm... that wasn't evident at all given Balbir's reponse to your 
> >> > previous concerns and your lack of response for the same:
> >> > https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg125350.html
> >> 
> >> To me it was obvious that the root cause was kpatch's current inability to
> >> deal with ppc calling conventions when copying binary functions. Hence my
> >> hint at the discussion about a possible source-level solution that would
> >> work nicely for all architectures.
> >
> > That other discussion isn't relevant.  Even if we do eventually decide
> > to go with a source-based approach, that's still a long ways off.
> 
> OK, that was my thinking, but good to have it confirmed.

It depends. We can write and compile live patching modules right away. From
my point of view it's a matter of proceedingly automating this task.

> > For the foreseeable future, kpatch-build is the only available safe way
> > to create live patches.  We need to figure out a way to make it work,
> > one way or another.

As stated, I disagree here, but let's leave that aside, and stick to
your ( :-) problem.

> > If I understand correctly, the main problem here is that a call to a
> > previously-local-but-now-global function is missing a needed nop
> > instruction after the call, which is needed for restoring r2 (the TOC
> > pointer).
> 
> Yes, that's the root of the problem.
Yes.

> > So, just brainstorming a bit, here are the possible solutions I can
> > think of:
> >
> > a) Create a special klp stub for such calls (as in Kamalesh's patch)
> >
> > b) Have kpatch-build rewrite the function to insert nops after calls to
> >    previously-local functions.  This would also involve adjusting the
> >    offsets of intra-function branches and relocations which come
> >    afterwards in the same section.  And also patching up the DWARF
> >    debuginfo, if we care about that (I think we do).  And also patching
> >    up the jump tables which GCC sometimes creates for switch statements.
> >    Yuck.  I'm pretty sure this is a horrible idea.
> 
> It's fairly horrible. It might be *less* horrible if you generated an
> assembly listing using the compiler, modified that, and then fed that
> through the assembler and linker.
> 
> > c) Create a new GCC flag which treats all calls as global, which can be
> >    used by kpatch-build to generate the right code (assuming this flag
> >    doesn't already exist).  This would be a good option, I think.
> 
> That's not impossible, but I doubt it will be all that popular with the
> toolchain folks who'd have to implement it :)  It will also take a long
> time to percolate out to users.

BTDT ;-)

> > d) Have kpatch-build do some other kind of transformation?  For example,
> >    maybe it could generate klp stubs which the callee calls into.  Each
> >    klp stub could then do a proper global call to the SHN_LIVEPATCH
> >    symbol.
> 
> That could work.
Indeed. There is no reason to load that off onto the kernel module loader.

> > Do I understand the problem correctly?  Do the potential solutions make
> > sense?  Any other possible solutions I missed?
> 
> Possibly, I'm not really across how kpatch works in detail and what the
> constraints are.
> 
> One option would be to detect any local calls made by the patched
> function and pull those in as well - ie. make them part of the patch.
> The pathological case could obviously end up pulling in every function
> in the kernel, but in practice that's probably unlikely. It already
> happens to some extent anyway via inlining.
> 
> If modifying the source is an option, a sneaky solution is to mark the
> local functions as weak, which means the compiler/linker has to assume
> they could become global calls.

This might also be doable with a gcc "plugin", which would not require changes
to the compiler itself. OTOH there's no such thing as a weak static function...

	Torsten

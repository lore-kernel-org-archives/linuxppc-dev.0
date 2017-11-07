Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWHCP2zb6zDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 15:54:25 +1100 (AEDT)
Date: Mon, 6 Nov 2017 22:54:19 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171107045419.aozlfdo7tpnubz72@treble>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171031183959.GA4313@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2017 at 07:39:59PM +0100, Torsten Duwe wrote:
> On Tue, Oct 31, 2017 at 09:53:16PM +0530, Naveen N . Rao wrote:
> > On 2017/10/31 03:30PM, Torsten Duwe wrote:
> > > 
> > > Maybe I failed to express my views properly; I find the whole approach
> [...]
> > > NAK'd-by: Torsten Duwe <duwe@suse.de>
> > 
> > Hmm... that wasn't evident at all given Balbir's reponse to your 
> > previous concerns and your lack of response for the same:
> > https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg125350.html
> 
> To me it was obvious that the root cause was kpatch's current inability to
> deal with ppc calling conventions when copying binary functions. Hence my
> hint at the discussion about a possible source-level solution that would
> work nicely for all architectures.

That other discussion isn't relevant.  Even if we do eventually decide
to go with a source-based approach, that's still a long ways off.

For the foreseeable future, kpatch-build is the only available safe way
to create live patches.  We need to figure out a way to make it work,
one way or another.

If I understand correctly, the main problem here is that a call to a
previously-local-but-now-global function is missing a needed nop
instruction after the call, which is needed for restoring r2 (the TOC
pointer).

So, just brainstorming a bit, here are the possible solutions I can
think of:

a) Create a special klp stub for such calls (as in Kamalesh's patch)

b) Have kpatch-build rewrite the function to insert nops after calls to
   previously-local functions.  This would also involve adjusting the
   offsets of intra-function branches and relocations which come
   afterwards in the same section.  And also patching up the DWARF
   debuginfo, if we care about that (I think we do).  And also patching
   up the jump tables which GCC sometimes creates for switch statements.
   Yuck.  I'm pretty sure this is a horrible idea.

c) Create a new GCC flag which treats all calls as global, which can be
   used by kpatch-build to generate the right code (assuming this flag
   doesn't already exist).  This would be a good option, I think.

d) Have kpatch-build do some other kind of transformation?  For example,
   maybe it could generate klp stubs which the callee calls into.  Each
   klp stub could then do a proper global call to the SHN_LIVEPATCH
   symbol.

Do I understand the problem correctly?  Do the potential solutions make
sense?  Any other possible solutions I missed?

-- 
Josh

Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXn0J3bx0zDrLS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 02:19:59 +1100 (AEDT)
Date: Thu, 9 Nov 2017 09:19:55 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Torsten Duwe <duwe@lst.de>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Jessica Yu <jeyu@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171109151955.gl3z3l2ary4ayj7b@treble>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de>
 <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au>
 <20171107113105.GA19204@lst.de>
 <20171107145233.lmlg5lkfcczkxj4d__32032.512050546$1510066460$gmane$org@treble>
 <1510225685.pzdd3dgj9m.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1510225685.pzdd3dgj9m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 09, 2017 at 04:49:05PM +0530, Naveen N. Rao wrote:
> > > > > d) Have kpatch-build do some other kind of transformation?  For example,
> > > > >    maybe it could generate klp stubs which the callee calls into.  Each
> > > > >    klp stub could then do a proper global call to the SHN_LIVEPATCH
> > > > >    symbol.
> > > > > That could work.
> > > Indeed. There is no reason to load that off onto the kernel module loader.
> > 
> > I agree that doing the same work in tooling would be better than adding
> > complexity to the kernel.
> 
> [In case we're considering this as an option...]
> 
> While I agree that it's better to do this in the tool in general, for this
> particular scenario, I think it is better to do this in the kernel.
> 
> From what I understand, the challenge here is the need to save/restore toc,
> *without* creating a local stack frame for the stub to use. So, we will have
> to use the livepatch stack in one form or the other. I'm not sure if we can
> do anything else in a klp stub.
> 
> And, if we have to use the livepatch stack, I think it is better to let the
> kernel control that so that kpatch doesn't need to change for any changes in
> livepatch_handler() for instance. The current patch reuses
> livepatch_handler() and makes its usage for kpatch quite explicit.

FWIW, I think it won't matter anyway.  I'm currently pursuing the option
of inserting nops after local calls, because it has less runtime
complexity than using a stub.

I think I've figured out a way to do it with a GCC plugin, but if that
doesn't work I'll try the asm listing sed approach suggested by Michael.

-- 
Josh

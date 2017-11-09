Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXgfZ3L1XzDrL2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 22:19:17 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA9BJA6j136013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 06:19:15 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e4n77jg80-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 06:19:14 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 9 Nov 2017 11:19:11 -0000
Date: Thu, 09 Nov 2017 16:49:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Jessica Yu
 <jeyu@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de> <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au> <20171107113105.GA19204@lst.de>
 <20171107145233.lmlg5lkfcczkxj4d__32032.512050546$1510066460$gmane$org@treble>
In-Reply-To: <20171107145233.lmlg5lkfcczkxj4d__32032.512050546$1510066460$gmane$org@treble
 >
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1510225685.pzdd3dgj9m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Poimboeuf wrote:
> On Tue, Nov 07, 2017 at 12:31:05PM +0100, Torsten Duwe wrote:
>> On Tue, Nov 07, 2017 at 07:34:29PM +1100, Michael Ellerman wrote:
>> > > So, just brainstorming a bit, here are the possible solutions I can
>> > > think of:
>> > >
>> > > a) Create a special klp stub for such calls (as in Kamalesh's patch)
>> > >
>> > > b) Have kpatch-build rewrite the function to insert nops after calls=
 to
>> > >    previously-local functions.  This would also involve adjusting th=
e
>> > >    offsets of intra-function branches and relocations which come
>> > >    afterwards in the same section.  And also patching up the DWARF
>> > >    debuginfo, if we care about that (I think we do).  And also patch=
ing
>> > >    up the jump tables which GCC sometimes creates for switch stateme=
nts.
>> > >    Yuck.  I'm pretty sure this is a horrible idea.
>> >=20
>> > It's fairly horrible. It might be *less* horrible if you generated an
>> > assembly listing using the compiler, modified that, and then fed that
>> > through the assembler and linker.
>=20
> Ah, that would work a lot better.
>=20
>> > > c) Create a new GCC flag which treats all calls as global, which can=
 be
>> > >    used by kpatch-build to generate the right code (assuming this fl=
ag
>> > >    doesn't already exist).  This would be a good option, I think.
>> >=20
>> > That's not impossible, but I doubt it will be all that popular with th=
e
>> > toolchain folks who'd have to implement it :)  It will also take a lon=
g
>> > time to percolate out to users.
>>=20
>> BTDT ;-)
>=20
> Yeah, maybe that's not so realistic.
>=20
>> > > d) Have kpatch-build do some other kind of transformation?  For exam=
ple,
>> > >    maybe it could generate klp stubs which the callee calls into.  E=
ach
>> > >    klp stub could then do a proper global call to the SHN_LIVEPATCH
>> > >    symbol.
>> >=20
>> > That could work.
>> Indeed. There is no reason to load that off onto the kernel module loade=
r.
>=20
> I agree that doing the same work in tooling would be better than adding
> complexity to the kernel.

[In case we're considering this as an option...]

While I agree that it's better to do this in the tool in general, for=20
this particular scenario, I think it is better to do this in the kernel.

>From what I understand, the challenge here is the need to save/restore=20
toc, *without* creating a local stack frame for the stub to use. So, we=20
will have to use the livepatch stack in one form or the other. I'm not=20
sure if we can do anything else in a klp stub.

And, if we have to use the livepatch stack, I think it is better to let=20
the kernel control that so that kpatch doesn't need to change for any=20
changes in livepatch_handler() for instance. The current patch reuses=20
livepatch_handler() and makes its usage for kpatch quite explicit.

- Naveen

=

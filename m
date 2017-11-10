Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY58r2vK5zDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 14:28:26 +1100 (AEDT)
Date: Thu, 9 Nov 2017 21:28:23 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Torsten Duwe <duwe@lst.de>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Jessica Yu <jeyu@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171110032823.nnpqsrrfwr6ye4uc@treble>
References: <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de>
 <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au>
 <20171107113105.GA19204@lst.de>
 <20171107145233.lmlg5lkfcczkxj4d__32032.512050546$1510066460$gmane$org@treble>
 <1510225685.pzdd3dgj9m.naveen@linux.ibm.com>
 <20171109151955.gl3z3l2ary4ayj7b@treble>
 <CAKTCnznuZFHgVjjnx+gBAk3RSenxS=PJLFBsxOq4Zzw=ru=HMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAKTCnznuZFHgVjjnx+gBAk3RSenxS=PJLFBsxOq4Zzw=ru=HMg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2017 at 01:06:25PM +1100, Balbir Singh wrote:
> On Fri, Nov 10, 2017 at 2:19 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > FWIW, I think it won't matter anyway.  I'm currently pursuing the option
> > of inserting nops after local calls, because it has less runtime
> > complexity than using a stub.
> >
> > I think I've figured out a way to do it with a GCC plugin, but if that
> > doesn't work I'll try the asm listing sed approach suggested by Michael.
> >
> 
> A plugin that runs for the new kernel with the patch? Just for
> specific files involved in the patch?

The plugin will affect the code generation of all functions in the patch
module.  So all calls in all replacement functions will have the nops.

Here's a prototype (not yet fully tested):

  https://github.com/jpoimboe/kpatch/blob/TODO-ppc-fix/kpatch-build/gcc-plugins/ppc64le-plugin.c

-- 
Josh

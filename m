Return-Path: <Peter.Oberparleiter@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51BB6DE119
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:43:12 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m71FgAHm180208
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 15:42:10 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m71FgAwk700486
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 17:42:10 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m71Fg9PA013819
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 17:42:10 +0200
In-Reply-To: <20080731231206.80940fba.akpm@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
Message-ID: <OF6FEAA9CB.C1447125-ONC1257498.004ECFF8-C1257498.00561AEF@de.ibm.com>
From: Peter 1 Oberparleiter <Peter.Oberparleiter@de.ibm.com>
Date: Fri, 1 Aug 2008 17:40:29 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote on 01.08.2008 08:12:06:
> On Fri, 1 Aug 2008 15:29:36 +1000 Tony Breeds <tony@bakeyournoodle.com> 
wrote:
> > On Thu, Jul 31, 2008 at 06:13:28PM +0530, Kamalesh Babulal wrote:
> > > Hi Andrew,
> > > 
> > > make allyesconfig with 2.6.27-rc1-mm1 kernel on powerpc fails 
> > > with build error
> > 
> > <snip>
> > 
> > Turning off GCOV "fixes" this.  Not really the best solution but at
> > least it narrows doen the search effort.
> 
> Thanks.
> 
> > Peter,
> >    Can you have a look at how this can be fixed, if at all?
> > 
> 
> Am not terribly happy with the state of the gcov patches.  They STILL
> leave thousands of dead symlinks lying around after `make mrproper'


This is caused by patch

    gcov-create-links-to-gcda-files-in-build-directory.patch

which can be simply removed as it is no longer needed since patch

    gcov-add-gcov-profiling-infrastructure-revert-link-changes.patch

has been added to -mm.

> and
> generally seem to muck up the kbuild system a bit, although nothing
> that a bit of Sam love wouldn't fix.

Hm, by now the only change to kbuild is the addition of gcc options
-fprofile-arcs/-ftest-coverage depending on the respective config
symbols. If there is anything else that should be changed, please
let me know.

> Plus it breaks the build on a few architectures (branch out of range,
> mainly), but that's a fairly minor thing which could even be worked
> around in Kconfig (disable the offending code if gcov is enabled)

Some of the problems caused/uncovered by enabling gcov profiling for
a kernel build on some architectures simply cannot be fixed by a change
to the kernel patch itself. I'm wondering if it would be possible
to disable this configuration option when specifying allyesconfig. That
way at least generic testing wouldn't be affected.


Regards,
  Peter

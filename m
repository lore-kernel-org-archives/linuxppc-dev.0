Return-Path: <dave@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3210B7BBB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 02:56:56 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9MFqldZ020880
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 11:52:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9MFuqfM052876
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 11:56:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9M9wcmv009246
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 05:58:38 -0400
Subject: Re: [PATCH 3/5 v4] Export memory_sysdev_class
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4AE07AB7.2070901@austin.ibm.com>
References: <4ADF1C49.2030201@austin.ibm.com>
	<4ADF1E42.3020907@austin.ibm.com> <1256141009.23737.22.camel@nimitz>
	<4AE07AB7.2070901@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Oct 2009 08:56:46 -0700
Message-Id: <1256227006.23737.784.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-22 at 10:31 -0500, Nathan Fontenot wrote:
> Dave Hansen wrote:
> > On Wed, 2009-10-21 at 09:44 -0500, Nathan Fontenot wrote:
> >> Export the memory_sysdev_class structure.  This is needed so we can create
> >> a 'release' file in sysfs in addition to the existing 'probe' file in
> >> order to support DLPAR removal of memory on the powerpc/pseries platform.
> >> The new 'release' file will be powerpc/pseries only.
> > 
> > Please do it in generic code.  You may only need it on ppc today, but
> > somebody else is going to want the same thing tomorrow on another arch.
> 
> I thought about this but wasn't sure if having the probe/release sysfs files
> for memory and cpu be in generic code would be accepted.

Although we don't want to pollute the generic code with lots of per-arch
cruft, this still looks pretty generic to me.  It is also really nice to
have all of the sysfs files for one directory be in a single place in
the source.

> Would it be acceptable to put the new release file for memory under the
> ARCH_MEMORY_PROBE config option?

That sounds fine to me.  It may need a slightly tuned name if you can
think of anything better.  I can't off the top of my head.

x86's is really only there for testing reasons.   I would use mem= to
shrink a machine's memory at boot then use the probe file to re-add it
later.  I did that before I had hardware that could do real hotplug.

> This would reduce the number of arch'es
> that would require stubs as it appears only powerpc and x86 define this.

Yeah, that'd be a nice side-effect I guess.

-- Dave

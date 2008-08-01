Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AEC6DDFE6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 16:12:58 +1000 (EST)
Date: Thu, 31 Jul 2008 23:12:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
Message-Id: <20080731231206.80940fba.akpm@linux-foundation.org>
In-Reply-To: <20080801052936.GZ20457@bakeyournoodle.com>
References: <20080731000354.24b55d5b.akpm@linux-foundation.org>
	<4891B370.5040208@linux.vnet.ibm.com>
	<20080801052936.GZ20457@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
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

On Fri, 1 Aug 2008 15:29:36 +1000 Tony Breeds <tony@bakeyournoodle.com> wrote:

> On Thu, Jul 31, 2008 at 06:13:28PM +0530, Kamalesh Babulal wrote:
> > Hi Andrew,
> > 
> > make allyesconfig with 2.6.27-rc1-mm1 kernel on powerpc fails with build error
> 
> <snip>
> 
> Turning off GCOV "fixes" this.  Not really the best solution but at
> least it narrows doen the search effort.

Thanks.

> Peter,
> 	Can you have a look at how this can be fixed, if at all?
> 

Am not terribly happy with the state of the gcov patches.  They STILL
leave thousands of dead symlinks lying around after `make mrproper' and
generally seem to muck up the kbuild system a bit, although nothing
that a bit of Sam love wouldn't fix.

Plus it breaks the build on a few architectures (branch out of range,
mainly), but that's a fairly minor thing which could even be worked
around in Kconfig (disable the offending code if gcov is enabled)

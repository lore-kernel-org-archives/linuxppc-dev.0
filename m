Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 3B5C3DE1DD
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 14:21:11 +1000 (EST)
Date: Thu, 9 Apr 2009 23:21:04 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090409232104.60d25d26@manatee.lan>
In-Reply-To: <20090409000112.GI16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<1239173283.10104.38.camel@localhost>
	<20090408134736.682bd56d@manatee.lan>
	<20090409000112.GI16602@bilbo.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds <tony@bakeyournoodle.com> wrote:

> On Wed, Apr 08, 2009 at 01:47:36PM -0500, Nathan Lynch wrote:
> 
> > I think I had some reason for doing it this way, but I'm drawing a
> > blank right now.
> > 
> > In the meantime, can someone post the warnings that gcc emits for
> > cacheinfo.c, as well as the gcc version?  I can't reproduce them with
> > 4.3.2 on Fedora.
> 
> ---
> [tony@thor ~]$ egrep cacheinfo tmp/build.log 
> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function 'associativity_show':
> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:562: warning: 'associativity' may be used uninitialized in this function
> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function 'size_show':
> /scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:513: warning: 'size_kb' may be used uninitialized in this function

Thanks.

So I think I've convinced myself that the warnings are incorrect and
that uninitialized use is not possible.

But I find it odd that gcc gives warnings for these sites but not others
in the file that use the same idiom (e.g. line_size_show,
nr_sets_show).  I'd guess that inlining is implicated somehow.  Would I
be justified in worrying that this version of gcc is generating
incorrect code?

If not, then I'm fine with the uninitialized_var() changes, but do
please include the warnings and the compiler version in the changelog.

Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8E98DE140
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 03:43:44 +1000 (EST)
Date: Thu, 15 May 2008 10:43:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: michael@ellerman.id.au
Subject: Re: [patch 3/4] macintosh: replace deprecated __initcall with
	device_initcall
Message-Id: <20080515104302.1b78e522.akpm@linux-foundation.org>
In-Reply-To: <1210842517.17568.41.camel@localhost>
References: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
	<18475.47278.446992.728481@cargo.ozlabs.ibm.com>
	<20080514230647.15d58897.akpm@linux-foundation.org>
	<1210832908.17568.16.camel@localhost>
	<20080514234102.d5735054.akpm@linux-foundation.org>
	<1210842517.17568.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rpjday@crashcourse.ca,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 19:08:37 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:

> On Wed, 2008-05-14 at 23:41 -0700, Andrew Morton wrote:
> > On Thu, 15 May 2008 16:28:28 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> > 
> > > On Wed, 2008-05-14 at 23:06 -0700, Andrew Morton wrote:
> > > > On Thu, 15 May 2008 14:14:38 +1000 Paul Mackerras <paulus@samba.org> wrote:
> > > > 
> > > > > akpm@linux-foundation.org writes:
> > > > > 
> > > > > > -__initcall(adb_init);
> > > > > > +device_initcall(adb_init);
> > > > > 
> > > > > There's no particular reason why this needs to go in 2.6.26, is there?
> > > > > It looks to me like something that I should queue up for 2.6.27.
> > > > > 
> > > > 
> > > > No, this make no difference in code generation - it's just a
> > > > use-the-modern-interface thing.
> > > 
> > > I missed the memo about __initcall being deprecated, or is it only
> > > deprecated for use in device drivers?
> > > 
> > 
> > It's just old-fashioned, that's all.
> >
> > #define pure_initcall(fn)		__define_initcall("0",fn,0)
> > 
> > #define core_initcall(fn)		__define_initcall("1",fn,1)
> > #define core_initcall_sync(fn)		__define_initcall("1s",fn,1s)
> > #define postcore_initcall(fn)		__define_initcall("2",fn,2)
> > #define postcore_initcall_sync(fn)	__define_initcall("2s",fn,2s)
> > #define arch_initcall(fn)		__define_initcall("3",fn,3)
> > #define arch_initcall_sync(fn)		__define_initcall("3s",fn,3s)
> > #define subsys_initcall(fn)		__define_initcall("4",fn,4)
> > #define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
> > #define fs_initcall(fn)			__define_initcall("5",fn,5)
> > #define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
> > #define rootfs_initcall(fn)		__define_initcall("rootfs",fn,rootfs)
> > #define device_initcall(fn)		__define_initcall("6",fn,6)
> > #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
> > #define late_initcall(fn)		__define_initcall("7",fn,7)
> > #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
> > 
> > #define __initcall(fn) device_initcall(fn)
> > 
> > See, we have the nicely-ordered foo_initcall()'s, and the old-fashioned
> > legacy __initcall happens to map onto device_initcall().
> > 
> > Such code should use device_initcall() directly.  So we see at which
> > stage in initcalls this function will be called.
> 
> Yeah fair enough. 
> 
> A little git'ing tells me there were 31 new __initcall()'s added between
> 2.6.24 and 2.6.25, and there are 12 more lurking between 2.6.25 and
> linux-next. They're breeding!
> 
> You can't stick a #warning inside a #define can you? How about:
> 
> #define __initcall(fn)				\
> do {						\
> int Use_device_initcall_not___initcall_please;	\
> device_initcall(fn);				\
> } while (0)
> 
> Which gives:
> warning: unused variable ______Use_device_initcall_not___initcall_please___
> 
> ..
> 
> Yeah OK that was a joke.

I'm sure Andy can give us a checkpatch warning when someone uses
__initcall.  That'll help a bit.

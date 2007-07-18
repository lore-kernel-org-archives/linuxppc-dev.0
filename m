Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32B14DE100
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jul 2007 04:38:30 +1000 (EST)
Date: Wed, 18 Jul 2007 09:55:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eugene Surovegin <ebs@ebshome.net>, linux-mm@kvack.org, Christoph
	Lameter <clameter@sgi.com>
Subject: Re: [Bugme-new] [Bug 8778] New: Ocotea board: kernel reports access
	of bad area during boot with DEBUG_SLAB=y
Message-Id: <20070718095537.d344dc0a.akpm@linux-foundation.org>
In-Reply-To: <20070718155940.GB29722@gate.ebshome.net>
References: <bug-8778-10286@http.bugzilla.kernel.org/>
	<20070718005253.942f0464.akpm@linux-foundation.org>
	<20070718083425.GA29722@gate.ebshome.net>
	<1184766070.3699.2.camel@zod.rchland.ibm.com>
	<20070718155940.GB29722@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: bart.vanassche@gmail.com, netdev@vger.kernel.org,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2007 08:59:40 -0700 Eugene Surovegin <ebs@ebshome.net> wrote:

> On Wed, Jul 18, 2007 at 08:41:10AM -0500, Josh Boyer wrote:
> > On Wed, 2007-07-18 at 01:34 -0700, Eugene Surovegin wrote:
> > > On Wed, Jul 18, 2007 at 12:52:53AM -0700, Andrew Morton wrote:
> > > > On Wed, 18 Jul 2007 00:07:50 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> > > > 
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=8778
> > > > > 
> > > > >            Summary: Ocotea board: kernel reports access of bad area during
> > > > >                     boot with DEBUG_SLAB=y
> > > 
> > > Slab debugging is probably the culprit here. I had similar problem 
> > > couple of years ago, not sure something has changed since then, 
> > > haven't checked.
> > > 
> > > When slab debugging was enabled it made memory allocations non L1 
> > > cache line aligned. This is very bad for DMA on non-coherent cache 
> > > arches (PPC440 is one of those archs).
> > > 
> > > I have a hack for EMAC which tries to "workaround" this problem:
> > > 	http://kernel.ebshome.net/emac_slab_debug.diff
> > > which might help.
> > 
> > Would you be opposed to including that patch in mainline?
> 
> Yes. I don't think it's the right way to fix this issue. IMO, the 
> right one is to fix slab allocator. You cannot change all drivers to 
> do this kind of cache flushing, and yes, I saw the same problem with 
> PCI based NIC I tried on Ocotea at the time.
> 

hm.  It should be the case that providing SLAB_HWCACHE_ALIGN at
kmem_cache_create() time will override slab-debugging's offsetting
of the returned addresses.

Or is the problem occurring with memory which is returned from kmalloc(),
rather than from kmem_cache_alloc()?

A complete description of the problem would help here, please.

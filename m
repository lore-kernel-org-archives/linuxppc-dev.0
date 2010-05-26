Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8099B7D20
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 03:31:33 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4QHVTFb008606
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 23:01:29 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4QHVTfD2301968
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 23:01:29 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4QHVSDT005646
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 03:31:28 +1000
Date: Wed, 26 May 2010 23:01:24 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [Patch 1/4] Allow arch-specific cleanup before breakpoint
	unregistration
Message-ID: <20100526173124.GA8283@in.ibm.com>
References: <20100526065129.GA3746@in.ibm.com>
	<20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091356.GB29003@in.ibm.com>
	<1274787559_8162@mail4.comsite.net>
	<4250.1274867681@redhat.com> <20100526171742.GA5563@in.ibm.com>
	<20100526172314.GD5299@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100526172314.GD5299@nowhere>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Millton Miller <miltonm@bga.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 26, 2010 at 07:23:15PM +0200, Frederic Weisbecker wrote:
> On Wed, May 26, 2010 at 10:47:42PM +0530, K.Prasad wrote:
> > On Wed, May 26, 2010 at 10:54:41AM +0100, David Howells wrote:
> > > K.Prasad <prasad@linux.vnet.ibm.com> wrote:
> > > 
> > > > > My understanding is weak function definitions must appear in a different C
> > > > > file than their call sites to work on some toolchains.
> > > > > 
> > > > 
> > > > Atleast, there are quite a few precedents inside the Linux kernel for
> > > > __weak functions being invoked from the file in which they are defined
> > > > (arch_hwblk_init, arch_enable_nonboot_cpus_begin and hw_perf_disable to
> > > > name a few).
> > > > Moreover the online GCC docs haven't any such constraints mentioned.
> > > 
> > > I've seen problems in this area.  gcc sometimes inlines a weak function that's
> > > in the same file as the call point.
> > > 
> > 
> > We've seen such behaviour even otherwise....even with noinline attribute
> > in place. I'm not sure if this gcc fix
> > (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=16922) helped correct the
> > behaviour, but the lesson has been to not trust a function to be
> > inlined/remain non-inline consistently.
> 
> 
> If we can't put the call to the function in the same file of its weak
> definition, then perf is totally screwed.
> 
> And in fact it makes __weak basically useless and unusable. I guess
> that happened in old gcc versions that have been fixed now.
> 
> Anyway, I'm personally fine with this patch (you can put my hack
> if you want).
>

I guess you meant "Acked-by:" :-)

Thanks, I'll add the same.

--K.Prasad
 

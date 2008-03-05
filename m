Return-Path: <pbadari@gmail.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 157A5DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 09:32:25 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m25MWMFY015348
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 17:32:22 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m25MWMbc178412
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 15:32:22 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m25MWMiF028128
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 15:32:22 -0700
Subject: Re: 2.6.25-rc3-mm1 ppc64 boot hang
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080305135425.c8ebf8e4.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<1204752855.7939.42.camel@dyn9047017100.beaverton.ibm.com>
	<20080305135425.c8ebf8e4.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 14:35:42 -0800
Message-Id: <1204756542.7939.44.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-03-05 at 13:54 -0800, Andrew Morton wrote:
> On Wed, 05 Mar 2008 13:34:14 -0800
> Badari Pulavarty <pbadari@gmail.com> wrote:
> 
> > On Tue, 2008-03-04 at 01:19 -0800, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc3/2.6.25-rc3-mm1/
> > > 
> > 
> > Hi Andrew,
> > 
> > Not able to boot 2.6.25-rc3-mm1 my ppc64 box.
> > 2.6.25-rc2-mm1 and 2.6.25-rc3 boots fine.
> > 
> > I applied slab.c fix also.
> > 
> > Any other known issues ? My config file attached.
> > Here are the messages on the console.
> 
> The semaphore consolidation code enables interrupts early in boot, when it
> shouldn't.  This tends to make powerpc blow up.  Could be that this is what
> you're hitting.
> 
> Matthew, is this ging to be fixed soon?

Yes. I just backed out git-semaphore.patch and machine booted fine.

Thanks,
Badari

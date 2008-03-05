Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E4A6DDED2
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 08:55:32 +1100 (EST)
Date: Wed, 5 Mar 2008 13:54:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.25-rc3-mm1 ppc64 boot hang
Message-Id: <20080305135425.c8ebf8e4.akpm@linux-foundation.org>
In-Reply-To: <1204752855.7939.42.camel@dyn9047017100.beaverton.ibm.com>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<1204752855.7939.42.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 05 Mar 2008 13:34:14 -0800
Badari Pulavarty <pbadari@gmail.com> wrote:

> On Tue, 2008-03-04 at 01:19 -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc3/2.6.25-rc3-mm1/
> > 
> 
> Hi Andrew,
> 
> Not able to boot 2.6.25-rc3-mm1 my ppc64 box.
> 2.6.25-rc2-mm1 and 2.6.25-rc3 boots fine.
> 
> I applied slab.c fix also.
> 
> Any other known issues ? My config file attached.
> Here are the messages on the console.

The semaphore consolidation code enables interrupts early in boot, when it
shouldn't.  This tends to make powerpc blow up.  Could be that this is what
you're hitting.

Matthew, is this ging to be fixed soon?

Thanks.  

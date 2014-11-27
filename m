Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11B551A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 05:27:35 +1100 (AEDT)
Date: Thu, 27 Nov 2014 20:27:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/2] mm, sched: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Message-ID: <20141127182710.GA30735@redhat.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-3-git-send-email-dahi@linux.vnet.ibm.com>
 <20141127172449.GA30380@redhat.com>
 <20141127173218.GA30419@redhat.com>
 <20141127190842.75a9cce3@thinkpad-w530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141127190842.75a9cce3@thinkpad-w530>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, David.Laight@ACULAB.COM,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 07:08:42PM +0100, David Hildenbrand wrote:
> > > > -
> > > > -	__might_sleep(__FILE__, __LINE__, 0);
> > > > +	if (unlikely(!pagefault_disabled()))
> > > > +		__might_sleep(__FILE__, __LINE__, 0);
> > > >    
> > 
> > Same here: so maybe make might_fault a wrapper
> > around __might_fault as well.
> 
> Yes, I also noticed that. It was part of the original code.
> For now I kept this revert as close as possible to
> the original patch.
> 
> Better fix this in an add-on patch? Or directly in this commit?

IMHO it's up to you really.

> At least for
> the in-header function it is easy to fix in this patch.
> 
> Thanks!

Right.

Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEC411A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 05:08:54 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 18:08:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id F37CB1B08049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 18:09:02 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARI8l0k16908524
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 18:08:47 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARI8jmv030015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 11:08:47 -0700
Date: Thu, 27 Nov 2014 19:08:42 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 2/2] mm, sched: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Message-ID: <20141127190842.75a9cce3@thinkpad-w530>
In-Reply-To: <20141127173218.GA30419@redhat.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-3-git-send-email-dahi@linux.vnet.ibm.com>
 <20141127172449.GA30380@redhat.com>
 <20141127173218.GA30419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> > > -
> > > -	__might_sleep(__FILE__, __LINE__, 0);
> > > +	if (unlikely(!pagefault_disabled()))
> > > +		__might_sleep(__FILE__, __LINE__, 0);
> > >    
> 
> Same here: so maybe make might_fault a wrapper
> around __might_fault as well.

Yes, I also noticed that. It was part of the original code.
For now I kept this revert as close as possible to
the original patch.

Better fix this in an add-on patch? Or directly in this commit? At least for
the in-header function it is easy to fix in this patch.

Thanks!

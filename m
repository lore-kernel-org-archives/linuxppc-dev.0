Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6851DDF59
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 03:24:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3OHOnL8013888
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:24:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3OHOnBr118750
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:24:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3OHOmGX000960
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:24:49 -0600
Date: Tue, 24 Apr 2007 12:24:48 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
Message-ID: <20070424172448.GX31947@austin.ibm.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177378733.14873.52.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, 2007 at 11:38:53AM +1000, Benjamin Herrenschmidt wrote:
> > The only reason for using threads here is to get the error recovery
> > out of an interrupt context (where errors may be detected), and then,
> > an hour later, decrement a counter (which is how we limit these to 
> > 6 per hour). Thread reaping is "trivial", the thread just exits
> > after an hour.
> 
> In addition, it should be a thread and not done from within keventd
> because :
> 
>  - It can take a long time (well, relatively but still too long for a
> work queue)

Uhh, 15 or 20 seconds even. That's a long time by any kernel standard.

>  - The driver callbacks might need to use keventd or do flush_workqueue
> to synchronize with their own workqueues when doing an internal
> recovery.
> 
> > Since these are events rare, I've no particular concern about
> > performance or resource consumption. The current code seems 
> > to work just fine. :-)
> 
> I think moving to kthread's is cleaner (just a wrapper around kernel
> threads that simplify dealing with reaping them out mostly) and I agree
> with Christoph that it would be nice to be able to "fire off" kthreads
> from interrupt context.. in many cases, we abuse work queues for things
> that should really done from kthreads instead (basically anything that
> takes more than a couple hundred microsecs or so).

It would be nice to have threads that can be "fired off" from an
interrupt context.  That would simplify the EEH code slightly 
(removing a few dozen lines of code that do this bounce).

I presume that various device drivers might find this useful as well.

--linas

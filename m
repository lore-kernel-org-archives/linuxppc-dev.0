Return-Path: <mlei30@yahoo.com>
Received: from web61015.mail.yahoo.com (web61015.mail.yahoo.com
	[209.73.179.24]) by ozlabs.org (Postfix) with SMTP id 9B1CC67B9A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 11:57:05 +1000 (EST)
Message-ID: <20050714015703.34280.qmail@web61015.mail.yahoo.com>
Date: Wed, 13 Jul 2005 18:57:03 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <17068cbdcbb1e2de531d33eb07f768e5@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan,

No one intents to make memory corruption in kernel
space but it happens sometimes.

Say I have a global var in my kernel module which
called test-mod, it picks up a physical page allocated
by some code with  kmalloc and later kfreed(suppose
when it does, the whole page gets freed). But then
this code forgets a pointer(which maped to this
physical page) already freed and modifies the pointer,
the write gets thru since that virt address's PTE
still valid and points to the physical page currently
used by test-mod. So the memory corruption happens.

Maybe I miss something in the linux kernel code that
prevents this double PTE thing.

Ming

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Jul 13, 2005, at 2:48 PM, ming lei wrote:
> 
> > Why linux kernel does such thing and no one
> consider
> > it's a problem?
> 
> Because we don't write software that accesses the
> memory
> from both of those locations, unless it is very
> intentional
> and necessary.  If you are just fishing for ways
> software
> _could_ do bad things, there are tons of them.  It's
> our
> job to write it so it doesn't :-)
> 
> Thanks.
> 
> 
> 	-- Dan
> 
> 



		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

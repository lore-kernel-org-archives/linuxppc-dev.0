Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BA1CDE28E
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 06:43:08 +1000 (EST)
Date: Fri, 4 Jul 2008 14:42:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: the printk problem
Message-ID: <20080704204252.GM14894@parisc-linux.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<20080704132716.f1e12554.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080704132716.f1e12554.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-ia64@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, Peter Anvin <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 01:27:16PM -0700, Andrew Morton wrote:
> On Fri, 4 Jul 2008 13:02:05 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > so I think we could easily just say that we extend %p in various ways:
> > > 
> > >  - %pS - print pointer as a symbol
> > > 
> > > and leave tons of room for future extensions for different kinds of 
> > > pointers. 
> 
> If this takes off we might want a register-your-printk-handler
> interface.  Maybe.
> 
> We also jump through hoops to print things like sector_t and
> resource_size_t.  They always need to be cast to `unsiged long long',
> which generates additional stack space and text in some setups.

The thing is that GCC checks types.  So it's fine to add "print this
pointer specially", but you can't in general add new printf arguments
without also hacking GCC.  Unless you use -Wno-format, and require
sparse to check special kernel types.

> And then there's the perennial "need to cast u64 to unsigned long long
> to print it".  If we were to do
> 
> 	printk("%SL", (void *)some_u64);
> 
> then that's still bloody ugly, but it'll save a little text-n-stack.

u64 is easy to fix, and I don't know why we haven't.  Just make it
unsigned long long on all architectures.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

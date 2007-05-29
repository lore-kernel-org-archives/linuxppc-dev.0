Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 May 2007 16:33:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Don't use HOSTCFLAGS in BOOTCFLAGS
Message-ID: <20070529063347.GA8404@localhost.localdomain>
References: <20070529032924.GA30266@localhost.localdomain>
	<d35e07648ef5813bd9e3572eec36bfb3@kernel.crashing.org>
	<20070529053445.GD30266@localhost.localdomain>
	<5dbbc18a80b465a00d6bbb764c06af86@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5dbbc18a80b465a00d6bbb764c06af86@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 08:26:49AM +0200, Segher Boessenkool wrote:
> >> Also, is there any reason why you can't simply use $(CC) -m32 with
> >> the kernel $(CFLAGS) ?
> >
> > I did think about that.  But the kernel CFLAGS does includes
> > -ffixed-r2 and -Iarch/powerpc which I don't think we want here.
> 
> Both of these should be fairly harmless.  But sure, it
> is cleaner to have separate flags -- the booter and the
> kernel run in different environments, after all.

Well, the -I is potentially dangerous, because it allows people to get
away with header file dependecies outside the booter specific headers.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

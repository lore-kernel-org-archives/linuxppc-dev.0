Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02CCDDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 16:06:12 +1100 (EST)
Date: Thu, 6 Nov 2008 06:06:04 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081106050604.GA31556@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
	<20081013011827.GA1299@wotan.suse.de>
	<18706.28132.850598.687949@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18706.28132.850598.687949@cargo.ozlabs.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 06, 2008 at 03:09:08PM +1100, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > > 
> > > Implement a more optimal mutex fastpath for powerpc, making use of acquire
> > > and release barrier semantics. This takes the mutex lock+unlock benchmark
> > > from 203 to 173 cycles on a G5.
> > > 
> > > +static inline int
> > > +__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> > > +{
> > > +	if (likely(__mutex_cmpxchg_lock(count, 1, 0) == 1))
> > > +		return 1;
> > 
> > Oops, I must have sent the wrong version. This needs a return 0 here.
> 
> Are you going to send the right version?  (or did you send it and I
> missed it?)

Hmm, I thought I did but perhaps not. Will do...


> Also I note that the comment you added just before that routine says:
> 
> + * Change the count from 1 to a value lower than 1, and return 0 (failure)
> + * if it wasn't 1 originally, or return 1 (success) otherwise. This function
> + * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
> 
> yet just doing a __mutex_cmpxchg_lock isn't going to do that.  So
> please fix either the comment or the code (or both :).

OK.

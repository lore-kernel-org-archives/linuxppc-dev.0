Return-Path: <jdl@jdl.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Fri, 23 Sep 2005 08:32:20 BST."
	<606.1127460740@warthog.cambridge.redhat.com>
References: <E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
Date: Fri, 23 Sep 2005 07:52:03 -0500
Message-Id: <E1EIn23-0001pB-H0@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Howells mumbled:
> 
> rwsems on ppc64 should really be using a 64-bit counter, not a 32-bit counter
> ,
> otherwise you limit the maximum number of processes to 32K-ish.
> 
> The counter should be "signed long" really.

No problem.  I _can_ resubmit the patch with this fix.
However, I am not certain that I should yet.

But what do you wan to do with ppc32 land then?
Leaving it a "signed long" will limit ppc32 land but
not ppc64 folks.  (No problem.)  Or we can have it
be "singed long long" for ppc32 to also get 64 bits.
(Again, no problem.)

Also, this begs the question of the comment from Paul:

    struct rw_semaphore {
	/* XXX this should be able to be an atomic_t  -- paulus */
	signed int		count;

Which, of course is:

    typedef struct { volatile int counter; } atomic_t;

Changing the size of counter will cause bad sizes
due to the actual treatment of count as an atomic_t.

So.  Should we, in fact, convert it to be an atomic_t
and further dispense with the casts?:

    static inline void __down_write(struct rw_semaphore *sem)
    {
	int tmp;

	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
				(atomic_t *)(&sem->count));

And if we _do_ convert it to be an atomic_t, should _that_
be where the real type for count gets established?

And finally, I've been working on merging header files
under the vague guideline of "merge maintaining existing
functionality/breakage".  I've been trying NOT to introduce
simultaneous "improvements" at the risk of breaking something.

To that end, I ask if the request to make 'count' be 64-bits
should be submitted as a follow on patch that stands on its
own and can clean up around it as necessary?  Or do you want
it mixed in with this "merge" patch too?

Just need to know the preferences.

Thanks,
jdl

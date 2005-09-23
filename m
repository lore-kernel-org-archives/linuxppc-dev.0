Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1EIn23-0001pB-H0@jdl.com> 
References: <E1EIn23-0001pB-H0@jdl.com> <E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
To: Jon Loeliger <jdl@freescale.com>
Date: Fri, 23 Sep 2005 15:09:28 +0100
Message-ID: <23115.1127484568@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jon Loeliger <jdl@freescale.com> wrote:

> No problem.  I _can_ resubmit the patch with this fix.
> However, I am not certain that I should yet.

I'd suggest that you wait until the merge is complete, I think.

> But what do you wan to do with ppc32 land then?
> Leaving it a "signed long" will limit ppc32 land but
> not ppc64 folks.  (No problem.)

I'd suggest "signed long" in both cases. A maximum of 32K processes on ppc32
is probably reasonable.

> Also, this begs the question of the comment from Paul:
> 
>     struct rw_semaphore {
> 	/* XXX this should be able to be an atomic_t  -- paulus */
> 	signed int		count;

Paul can be wrong sometimes:-)

Changing to atomic_t would leave the 32K process limit in place.

> Changing the size of counter will cause bad sizes
> due to the actual treatment of count as an atomic_t.

You will not be able to use the standard atomic ops unless you increase them
to 64-bits on ppc64.

> And if we _do_ convert it to be an atomic_t, should _that_
> be where the real type for count gets established?

You should not do that unless you increase atomic_t to 64-bits on ppc64.

> And finally, I've been working on merging header files
> under the vague guideline of "merge maintaining existing
> functionality/breakage".  I've been trying NOT to introduce
> simultaneous "improvements" at the risk of breaking something.

Sounds reasonable.

> To that end, I ask if the request to make 'count' be 64-bits
> should be submitted as a follow on patch that stands on its
> own and can clean up around it as necessary?  Or do you want
> it mixed in with this "merge" patch too?

Follow-on is fine.

David

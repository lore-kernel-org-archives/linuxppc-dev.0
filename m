Return-Path: <hollisb@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07F59B7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Oct 2009 12:29:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9K1Z4aj008858
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 21:35:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9K1TuNt257168
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 21:29:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9K1Tt7p019430
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2009 21:29:56 -0400
Subject: Re: linux-next: tree build failure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200910201142.34006.rusty@rustcorp.com.au>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<4AD6EB17020000780001A050@vpn.id2.novell.com>
	<1255976369.13995.98.camel@slab.beaverton.ibm.com>
	<200910201142.34006.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Mon, 19 Oct 2009 18:29:53 -0700
Message-Id: <1256002193.6546.2.camel@slab>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-20 at 11:42 +1030, Rusty Russell wrote:
> On Tue, 20 Oct 2009 04:49:29 am Hollis Blanchard wrote:
> > On Thu, 2009-10-15 at 08:27 +0100, Jan Beulich wrote:
> > > My perspective is that it just uncovered already existing brokenness.
> > 
> > Sorry, I thought it was clear, but to be more explicit: I propose the
> > following patch, which replaces the current BUILD_BUG_ON implementation
> > with Rusty's version.
> 
> OK, I switched my brain back on.  Yeah, I agree: we may still want
> BUILD_OR_RUNTIME_BUG_ON one day, but I like this.
> 
> It's just missing the giant comment that it needs :)
> 
> /**
>  * BUILD_BUG_ON - break compile if a condition is true.
>  * @cond: the condition which the compiler should know is false.
>  *
>  * If you have some code which relies on certain constants being equal, or
>  * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
>  * detect if someone changes it.
>  *
>  * The implementation uses gcc's reluctance to create a negative array, but
>  * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
>  * to inline functions).  So as a fallback we use the optimizer; if it can't
>  * prove the condition is false, it will cause a link error on the undefined
>  * "__build_bug_on_failed".  This error is less neat, and can be harder to
>  * track down.
>  */

Do you want to put together a signed-off patch Rusty? It's your code, so
I don't feel comfortable doing that.

Once we have that, can we remove the mysterious MAYBE_BUILD_BUG_ON
statements introduced in previous patches? (Does it BUG or doesn't it??)

-- 
Hollis Blanchard
IBM Linux Technology Center

Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: linux-next: tree build failure
Date: Tue, 20 Oct 2009 11:42:32 +1030
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<4AD6EB17020000780001A050@vpn.id2.novell.com>
	<1255976369.13995.98.camel@slab.beaverton.ibm.com>
In-Reply-To: <1255976369.13995.98.camel@slab.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200910201142.34006.rusty@rustcorp.com.au>
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

On Tue, 20 Oct 2009 04:49:29 am Hollis Blanchard wrote:
> On Thu, 2009-10-15 at 08:27 +0100, Jan Beulich wrote:
> > My perspective is that it just uncovered already existing brokenness.
> 
> Sorry, I thought it was clear, but to be more explicit: I propose the
> following patch, which replaces the current BUILD_BUG_ON implementation
> with Rusty's version.

OK, I switched my brain back on.  Yeah, I agree: we may still want
BUILD_OR_RUNTIME_BUG_ON one day, but I like this.

It's just missing the giant comment that it needs :)

/**
 * BUILD_BUG_ON - break compile if a condition is true.
 * @cond: the condition which the compiler should know is false.
 *
 * If you have some code which relies on certain constants being equal, or
 * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
 * detect if someone changes it.
 *
 * The implementation uses gcc's reluctance to create a negative array, but
 * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
 * to inline functions).  So as a fallback we use the optimizer; if it can't
 * prove the condition is false, it will cause a link error on the undefined
 * "__build_bug_on_failed".  This error is less neat, and can be harder to
 * track down.
 */

Thanks!
Rusty.

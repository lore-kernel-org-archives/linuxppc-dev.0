Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D51CD679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 06:19:45 +1000 (EST)
Date: Fri, 6 May 2005 12:45:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050506154539.GA6452@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: How to fix 8xx dcbst bug?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dan,

So, restarting this conversation...

On Tue, Apr 05, 2005 at 11:58:17AM -0400, Dan Malek wrote:
> 
> On Apr 4, 2005, at 3:17 PM, Marcelo Tosatti wrote:
> 
> >Problem is that the "dcbst" instruction will, _sometimes_ (the 
> >failure/success rate is about 1/4
> >with my test application) fault as a _write_ operation on the data.
> 
> Oh, geeze .... It's all coming back to me now ....
> 
> The 8xx cache operations don't always operate as defined in the PEM.
> There are likely to be some archive discussions within the Freescale
> knowledge data base that describe the different behaviors I've seen
> with the chip variants and revisions.  I can't find any of those e-mail
> discussions, so I'll try to recall from memory.
> 
> The PEM cache instructions are all implemented in a microcode that
> uses the 8xx unique cache control SPRs.  Depending upon the state
> of the cache and MMU, it seems in some cases the EA translation is
> subject to a "normal" protection match instead of a load operation 
> match.
> 
> The behavior of these operations isn't consistent across all of the 8xx
> processor revisions, especially with early silicon if people are still
> using those.	During conversations with Freescale engineers, it seems
> the only guaranteed operation was to use the 8xx unique SPRs, but
> I think I only did that in 8xx specific functions.
>
> We have way too much code in the TLB exception handlers already,
> so let's just try a tlbia of the EA in the update_mmu_cache, with an 
> #ifdef
> for the 8xx.	

>  We may want to make the dcbxxx instructions 
> some
> kind of macro, so on 8xx we can include such operations in otherwise
> "standard" software.

Now that I think of it, userspace dcbst users should not be an issue
because the intermediate invalid TLB entry is not visible to applications.

Userspace sees only: not present pte, or valid present pte.

Well, at least the entry which has been causing problems,
created by DataStoreTLBMiss.

Is it safe to assume that dcbst usage on userspace is restricted
to valid TLBs? Since MMU SPRs are restricted to supervisor 
protection, I think so.

So, if that is true, can you please merge the update_mmu_cache() fix 
for the dcbst misbehaviour previously discussed ? 

Thanks!!

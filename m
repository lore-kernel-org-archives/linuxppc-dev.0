Date: Thu, 6 Sep 2001 11:06:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
Message-ID: <20010906110607.C20279@zax>
References: <20010830175217.H858@zax> <3B95307D.1BE64A98@mvista.com> <20010905110451.A599@zax> <3B95A796.248A0E99@mvista.com> <20010905144125.H6636@zax> <3B9645EB.DC7F3A6C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B9645EB.DC7F3A6C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 05, 2001 at 11:34:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > But when it hits zero we'll also get another timer interrupt and will
> > shortly be updating it with a corrected value.  Why does it matter
> > that the value is reloaded?
>
> I don't understand the reason for this discussion.  Is something
> not working correctly?  If so, make it work better and send me a
> patch.

Well, there's nothing actually broken, but allowing the set_dec() in
timer_interrupt() to affect the PIT should keep the timer interrupts
from drifting too far from the time base, and hence slightly reduce
the jitter in jiffies.  But, no, I don't actually have any timings or
data to confirm that that is the case.  I've been running this way in
my kernel for a month or so, so it certainly doesn't break anything
badly.  I'm trying to find out if my understanding of the situation is
actually correct.

And the patch:

diff -urN ../linuxppc_2_4_devel/include/asm-ppc/time.h linux-bungo/include/asm-ppc/time.h
--- ../linuxppc_2_4_devel/include/asm-ppc/time.h	Wed Aug 29 10:41:56 2001
+++ linux-bungo/include/asm-ppc/time.h	Thu Sep  6 11:01:04 2001
@@ -46,7 +46,7 @@
 static __inline__ void set_dec(unsigned int val)
 {
 #if defined(CONFIG_4xx)
-	return;		/* Have to let it auto-reload */
+	mtspr(SPRN_PIT, val);
 #elif defined(CONFIG_8xx_CPU6)
 	set_dec_cpu6(val);
 #else

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

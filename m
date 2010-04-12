Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 5DC6BB7D1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Apr 2010 13:47:13 +1000 (EST)
In-Reply-To: <1270975151.6865.140.camel@pasglop>
References: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>	
	<1270735170.19546.2.camel@concordia>
	<OFD957C4B7.2DDD66CF-ON882576FF.0069A7B1-882576FF.006B689A@selinc.com>
	<1270975151.6865.140.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: Question regarding the DTLB Miss exceptions
Message-ID: <OF69BF75D7.F222C4A2-ON88257703.00133151-88257703.0014C317@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Sun, 11 Apr 2010 20:46:46 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > 
> > It's checking to see if the following bits of DSISR are set:
> > 0 - set by DTLB miss if no hash table entry group is found
> 
> No. 0 means we hit a direct store segment. This is a historical feature
> of the architecture which we don't use, so should not happen.
> 

Sorry, would have helped if I had specified the processor; we're using an 
MPC8347, so it's an e300c1 core.  Also, my fat-fingering of the keyboard 
got me on this one - bit 0 on the e300 should be cleared.  I put in bit 
1's definition by mistake in my last email.

> > 2 - an invalid bit
> 
> Not sure what 2 is about.

Yeah, and that's the one I'm trying to figure out why the DTLB Miss on 
Store exception code is setting before calling the DSI exception code :).

> > are set and calling it a "weird error".  What the heck does that mean, 
a 
> > "weird error"?
> 
> Nah. It's a bad name. It means it's an error that is either something we
> don't support (like direct store) or something that doesn't need to go
> through hash_page, such as a breakpoint match.
> 

Thanks, that actually helps, knowing that what's being done is determining 
reasons to call hash_page or not.  Also knowing (which I suppose I should 
have figured out earlier) that some of the bits in DSISR are not defined 
for the e300c1 core but that the code is designed to support 
implementations that DO define those bits helps make sense of what I'm 
looking at.

> 
> I missed the earlier discussion, what is your problem ?
> 

Well, the problem I'm having is really irrelevant to the question at hand. 
 My original question to the list was "why is the DTLB Store Miss 
exception setting bit two of the DSISR (an invalid bit according to the 
architecture) before calling the DSI exception?".

Thanks for the explanations!

Bruce

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 954FBB6EEE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 11:46:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e: Fix extlb size
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1302046749.2549.186.camel@pasglop>
Date: Tue, 5 Apr 2011 20:45:48 -0500
Message-Id: <52FDCC6C-2F2F-47CC-8E6D-02A65FD21BCF@kernel.crashing.org>
References: <a0ae014cf06639bb9aea24149c24e51acbaf2598.1301984934.git.michael@ellerman.id.au>
	<F4D669C2-BAD4-4B79-BE24-FB5AD2961160@kernel.crashing.org>
	<1302046749.2549.186.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2011, at 6:39 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-04-05 at 07:41 -0500, Kumar Gala wrote:
>>> Rework it to make it a bit clearer, and also correct. We want 3 save
>>> areas, each EX_TLB_SIZE _bytes_.
>> 
>> Where does the 3 come from?  I have a guess, and think its possible we
>> (FSL) want 4?
> 
> Wrong guess :-) It's not about exception levels. It's about how much
> the handler can re-enter (2 with E.PT, 3 with virtual linear)
> 
> For MC's, CRITs etc... which we don't support on Book3E 64-bit at this
> stage, you'll have to probably backup the whole area... that or move
> the TLB frame pointer SPR to a separate set of 3 levels, but then you'd
> have to fix the code that makes assumption about level 0 being at a
> fixed offset in the PACA and instead use alignment tricks. We need that
> because that's how we "reset" the TLB frame when a second level finds
> a fault.
> 
> Cheers,
> Ben.

Gotcha, can we add a comment here about what the '3' is about.

- k

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C74B567B28
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:20:45 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <425429BF.1050706@nortel.com>
References: <425429BF.1050706@nortel.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:19:56 +1000
Message-Id: <1112829596.9518.210.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 12:26 -0600, Chris Friesen wrote:
> I want to retrieve the msr (which is 64-bits) on a 970 when running in 
> 32-bit mode.  I have the following bit of code that seems to work, but 
> when looking at the code it always seems to use a suboptimal register 
> for the low word, and then it ends up having to copy it to the right 
> register to create a long long register pair.
> 
> static inline unsigned long long get_msr()
> {
> 	union {
> 		struct {
> 			unsigned long low;
> 			unsigned long high;
> 		} words;
> 		unsigned long long val;
> 	} val;
>          asm volatile( \
>                  "mfmsr  %0               \n\t" \
>                  "rldicl %1,%0,32,32       \n\t" \
>                  "rldicl %0,%0,0,32        \n\t" \
>                  : "=r" (val.words.low), "=r" (val.words.high));
> 	return val.val;
> }

Is this in kernel mode ? Why are you doing that ? 

> Using this code, the optimised assembly output of
> 
> 	unsigned long long a = asdf();
> 	unsigned long long b = asdf();
> 
> is
> 
> 	mfmsr  5
> 	rldicl 0,5,32,32
> 	rldicl 5,5,0,32
> 	mr 6,0
> 	mfmsr  7
> 	rldicl 9,7,32,32
> 	rldicl 7,7,0,32
> 	mr 8,9
> 
> I figure it should have been able to use registers 6/8 in the first 
> place, and save the extra moves.
> 
> Is there any way to help gcc optimise this?
> 
> 
> Chris
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

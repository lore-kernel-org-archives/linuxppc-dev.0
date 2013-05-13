Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB77E2C0099
 for <linuxppc-dev@ozlabs.org>; Tue, 14 May 2013 02:56:06 +1000 (EST)
In-Reply-To: <1368441187.24723.38.camel@i7.infradead.org>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
 <1368441187.24723.38.camel@i7.infradead.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A549319-FA61-4FB2-97D1-2D9273331019@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Date: Mon, 13 May 2013 18:55:27 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 	rlwinm 10,4,8,0xffffffff
> 	rlwinm 11,3,8,0xffffffff
> 	rlwimi 10,4,24,0,7
> 	rlwimi 11,3,24,0,7
> 	rlwimi 10,4,24,16,23
> 	rlwimi 11,3,24,16,23
> 	mr 4,11
> 	mr 3,10

>> Actually, I'd swap the two mr instructions to never
>> have an instruction that uses the result from the
>> previous one.
>
> Bad GCC. No biscuit.
>
> Should we file a PR?

This is scheduled just fine.  Every pair of instructions here can
execute together (on most CPUs, if not all); all instructions after
it are dependent on previous instructions.  There also is no issue
(group) restriction that makes this scheduling suboptimal afaics.


Segher

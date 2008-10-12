Return-Path: <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48F15B7D.3060608@genesi-usa.com>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
Content-Type: text/plain
Date: Sun, 12 Oct 2008 15:05:37 +1100
Message-Id: <1223784337.8157.193.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Would the examples (page copy, page clear) be an okay place to do it?
> These sections can't be preempted anyway (right?), and it's noted that
> doing it with AltiVec is a tad faster than using MMU tricks or standard
> copies?

I think typically page copying and clearing -are- preemptible. I'm not
sure what you mean by MMU tricks, but it's not clear whether using
altivec will result in any significant performance gain here,
considering the cost of enabling/disabling altivec (added to handling
the preemption issue).

However, nothing prevents you from trying to do it and we'll see what
the results are with hard numbers.

> In Scott's case, while "optimizing memcpy for 48byte blocks" was a joke,
> this is 3 load/stores in AltiVec, which as long as every SKB is 16
> byte aligned (is there any reason why it would not be? :)

In this case, the cost of enabling/saving/restoring altivec will far
outweight any benefit. In addition, skb's are often not well aligned due
to the alignment tricks done with packet headers.

> skb_clone might not be something you want to dump AltiVec into and would
> make a mess if an skb got extended somehow, but the principle is outlined
> in a very good document from a very long time ago;
> 
> http://www.motorola.com.cn/semiconductors/sndf/conference/PDF/AH1109.pdf
> 
> I think a lot of it still holds true as long as you really don't care
> about preemption under these circumstances (where network throughput
> is more important, and where AltiVec actually *reduces* CPU time, the
> overhead of disabling preemption is lower anyway). You could say the
> same about the RAID functions - I bet LatencyTOP has a field day when
> you're using RAID5 AltiVec.

RAID6 actually :-)

In any case, as I said, people are welcome to implement something that
can be put to the test and measured. If it proves beneficial enough, then
I see no reason not to merge it. Basically, enough talks, just do something
and we'll see whether it proves useful or not.

Cheers,
Ben.

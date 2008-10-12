Return-Path: <neko@genesi-usa.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id E54FBDDDD8
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 13:06:00 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so683160wra.1
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 19:05:58 -0700 (PDT)
Message-ID: <48F15B7D.3060608@genesi-usa.com>
Date: Sat, 11 Oct 2008 21:05:49 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	
	<20081008154212.GA21723@secretlab.ca>	
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>	
	<48EDD905.6070609@mikroswiat.pl>	
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>	
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
In-Reply-To: <1223764226.8157.182.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-10-09 at 10:37 -0500, Matt Sealey wrote:
>> Ahem, but nobody here wants AltiVec in the kernel do they?
> 
> It depends. We do use altivec in the kernel for example for
> RAID accelerations.
> 
> The reason where we require a -real-good- reason to do it is
> simply because of the drawbacks. The cost of enabling altivec
> in the kernel can be high (especially if the user is using it)
> and it's not context switched for kernel code (just like the
> FPU) for obvious performance reasons. Thus any use of altivec in the
> kernel must be done within non-preemptible sections, which can
> cause higher latencies in preemptible kernels.

Would the examples (page copy, page clear) be an okay place to do it?
These sections can't be preempted anyway (right?), and it's noted that
doing it with AltiVec is a tad faster than using MMU tricks or standard
copies?

In Scott's case, while "optimizing memcpy for 48byte blocks" was a joke,
this is 3 load/stores in AltiVec, which as long as every SKB is 16
byte aligned (is there any reason why it would not be? :)

skb_clone might not be something you want to dump AltiVec into and would
make a mess if an skb got extended somehow, but the principle is outlined
in a very good document from a very long time ago;

http://www.motorola.com.cn/semiconductors/sndf/conference/PDF/AH1109.pdf

I think a lot of it still holds true as long as you really don't care
about preemption under these circumstances (where network throughput
is more important, and where AltiVec actually *reduces* CPU time, the
overhead of disabling preemption is lower anyway). You could say the
same about the RAID functions - I bet LatencyTOP has a field day when
you're using RAID5 AltiVec. But if you're more concerned about fast disk
access, would you really care (especially since the algorithm is
automatically selected on boot, you've not much chance of having any
choice in the matter anyway)?

Granted it also doesn't help Scott one bit. Sorry :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

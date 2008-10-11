Return-Path: <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48EE2553.30903@genesi-usa.com>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com>
Content-Type: text/plain
Date: Sun, 12 Oct 2008 09:30:26 +1100
Message-Id: <1223764226.8157.182.camel@pasglop>
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

On Thu, 2008-10-09 at 10:37 -0500, Matt Sealey wrote:
> 
> Ahem, but nobody here wants AltiVec in the kernel do they?

It depends. We do use altivec in the kernel for example for
RAID accelerations.

The reason where we require a -real-good- reason to do it is
simply because of the drawbacks. The cost of enabling altivec
in the kernel can be high (especially if the user is using it)
and it's not context switched for kernel code (just like the
FPU) for obvious performance reasons. Thus any use of altivec in the
kernel must be done within non-preemptible sections, which can
cause higher latencies in preemptible kernels.

Ben.

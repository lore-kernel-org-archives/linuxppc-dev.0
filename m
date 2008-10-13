Return-Path: <scottwood@freescale.com>
Message-ID: <48F3B7A2.3010004@freescale.com>
Date: Mon, 13 Oct 2008 16:03:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	
	<20081008154212.GA21723@secretlab.ca>	
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>	
	<48EDD905.6070609@mikroswiat.pl>	
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>	
	<48EE2553.30903@genesi-usa.com>
	<1223764226.8157.182.camel@pasglop>	
	<48F15B7D.3060608@genesi-usa.com>	
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
	<1223931027.8157.272.camel@pasglop>
In-Reply-To: <1223931027.8157.272.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Dominik Bozek <domino@mikroswiat.pl>, linuxppc-embedded@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> It doesn't need to be done in non-preemptible sections, if you have a
>> separate per-thread save area for kernel fp/altivec use (and appropriate
>> flags so an FP unavailable handler knows which regs to restore), and you
>> can avoid using it in a preempting context.
> 
> Yuck.

Hmm?  It's simple and achieves the desired result (avoiding 
non-preemptible regions without unduly restricting the ability to 
extract performance from the hardware).

Would it be nicer to avoid FP/Altivec in the kernel altogether?  Sure. 
If the benchmarking says that we're better off with it, though, then so 
be it.

-Scott

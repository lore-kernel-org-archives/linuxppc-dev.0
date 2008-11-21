Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id DAC32DDDDF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 19:41:32 +1100 (EST)
Date: Fri, 21 Nov 2008 09:41:18 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: times(2) sys call bug?
Message-ID: <20081121084118.GA27809@iram.es>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18725.63534.3316.841949@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 21, 2008 at 10:52:14AM +1100, Paul Mackerras wrote:
> Joakim Tjernlund writes:
> 
> > This little hack changes the kernel sys call handling in an crude
> > way and then it works. Apperently the kernel thinks is an error if the
> > syscall returns a value between -_LAST_ERRNO and -1.
> 
> Try this patch and let me if it fixes it.  If it does I'll push it
> upstream.

With your patch, you won't get EFAULT if you pass a bad
address, but a constant, time independent value, unless
I miss something. 

Of course there are peoaple who claim that EFAULT is a
bad idea to start with and that you should send a SIGSEGV
instead, and I can see their point. 

But with the current implementation, it is a game that 
you can't win: any syscall that wants to return an
arbitrary integer multiplexed with an error value is
broken beyond repair, by design.

Oh, well. 

	Gabriel

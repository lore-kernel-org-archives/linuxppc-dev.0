Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18726.31050.149408.815256@cargo.ozlabs.ibm.com>
Date: Fri, 21 Nov 2008 20:03:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: times(2) sys call bug?
In-Reply-To: <20081121084118.GA27809@iram.es>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
	<20081121084118.GA27809@iram.es>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert writes:

> On Fri, Nov 21, 2008 at 10:52:14AM +1100, Paul Mackerras wrote:
> > Joakim Tjernlund writes:
> > 
> > > This little hack changes the kernel sys call handling in an crude
> > > way and then it works. Apperently the kernel thinks is an error if the
> > > syscall returns a value between -_LAST_ERRNO and -1.
> > 
> > Try this patch and let me if it fixes it.  If it does I'll push it
> > upstream.
> 
> With your patch, you won't get EFAULT if you pass a bad
> address, but a constant, time independent value, unless
> I miss something. 

I think you are missing something, namely that I put the call to
force_successful_syscall_return() AFTER the return -EFAULT.

You should get an EFAULT error if the address is bad, i.e. on return
to userspace with cr0.SO = 1 and r3 = EFAULT (note, not -EFAULT).  On
a non-error return you should get cr0.SO = 0 and r3 containing the
return value (even if it's -EFAULT).  It's possible that glibc will
stuff it up again after that but I hope not.

Paul.

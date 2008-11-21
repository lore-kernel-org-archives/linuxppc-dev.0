Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 63404DDDDF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 19:47:37 +1100 (EST)
Subject: Re: times(2) sys call bug?
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20081121084118.GA27809@iram.es>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
	<20081121084118.GA27809@iram.es>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 09:47:35 +0100
Message-Id: <1227257255.5224.115.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-21 at 09:41 +0100, Gabriel Paubert wrote:
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

Not so, look again:

asmlinkage long sys_times(struct tms __user * tbuf)
{
	...
	if (tbuf) {
		...
		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
			return -EFAULT;
	}
	force_successful_syscall_return();
	return (long) jiffies_64_to_clock_t(get_jiffies_64());
}

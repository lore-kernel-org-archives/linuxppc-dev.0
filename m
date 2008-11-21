Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 0FCBFDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 19:31:28 +1100 (EST)
Subject: Re: times(2) sys call bug?
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18725.63534.3316.841949@cargo.ozlabs.ibm.com>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 09:31:25 +0100
Message-Id: <1227256285.5224.112.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-21 at 10:52 +1100, Paul Mackerras wrote:
> Joakim Tjernlund writes:
> 
> > This little hack changes the kernel sys call handling in an crude
> > way and then it works. Apperently the kernel thinks is an error if the
> > syscall returns a value between -_LAST_ERRNO and -1.
> 
> Try this patch and let me if it fixes it.  If it does I'll push it
> upstream.
> 

It does fix the problem, thanks. You might want to do the same
to time(2)?
This workaround lets you get around the times(2) problem. Perhaps
you want to mention it in the commit msg:

static clock_t
our_times(void)        /* Make times(2) behave rationally on Linux */
{
	clock_t ret;

	errno   = 0;
	ret     = times(NULL);
	if (errno != 0)
		ret = (clock_t) (-errno);
	return ret;
}

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17261.57380.473046.69200@cargo.ozlabs.ibm.com>
Date: Sun, 6 Nov 2005 21:51:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131264050.10031.265.camel@baythorne.infradead.org>
References: <1131264050.10031.265.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix ppc32 smp build.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Fix PPC32 SMP build -- instead of setting the now non-existent
> smp_tb_synchronized when the timebases are synchronised, we clear the
> CPU_FTR_USE_TB bit when they're not. Does this look sane, and did I miss
> cases where they're not synchronised?

I don't like clearing the USE_TB bit, since the alternative is to use
the RTC (a la 601), and most cpus will take an illegal instruction
exception if you try to do that.

If we really can get unsynchronized timebases still, then I suppose we
need to bring back the smp_tb_synchronized variable, but I was
assuming that we could get the timebases synchronized one way or
another.  If the to-and-fro involved in synchronizing the timebases
doesn't work then there is an awful lot of other stuff that is going
to fall on its face too...  Maybe the solution is just to panic if we
can't get the other cpu to talk to us enough to synchronize the
timebases.

Paul.

Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id E310FDDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 03:14:22 +1000 (EST)
Date: Thu, 19 Jun 2008 12:09:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC/PATCH 0/3] sched: allow arch override of cpu power
Message-ID: <20080619170945.GB9594@localdomain>
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
	<20080619095048.GD15228@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080619095048.GD15228@elte.hu>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> 
> * Nathan Lynch <ntl@pobox.com> wrote:
> > So it would be nice to have the scheduler slightly prefer primary 
> > threads on POWER6 machines.  These patches, which allow the 
> > architecture to override the scheduler's CPU "power" calculation, are 
> > one possible approach, but I'm open to others.  Please note: these 
> > seemed to have the desired effect on 2.6.25-rc kernels (2-3% 
> > improvement in a kernbench-like make -j <nr_cores>), but I'm not 
> > seeing this improvement with 2.6.26-rc kernels for some reason I am 
> > still trying to track down.
> 
> ok, i guess that discrepancy has to be tracked down before we can think 
> about these patches - but the principle is OK.

Great.  I'll keep trying to figure out what's going on there.


> One problem is that the whole cpu-power balancing code in sched.c is a 
> bit ... unclear and under-documented. So any change to this area should 
> begin at documenting the basics: what do the units mean exactly, how are 
> they used in balancing and what is the desired effect.
>
> I'd not be surprised if there were a few buglets in this area, SMT is 
> not at the forefront of testing at the moment. There's nothing 
> spectacularly broken in it (i have a HT machine myself), but the 
> concepts have bitrotten a bit. Patches - even if they just add comments 
> - are welcome :-)

Okay, I'll have a look.  Thanks Ingo.

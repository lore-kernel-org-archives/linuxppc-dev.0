Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 57F94DE14D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 01:21:41 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Fri, 13 Mar 2009 15:24:36 +0100
References: <200903131121.00077.david.jander@protonic.nl>
	<9223B51A-4340-4636-B1F8-6D49A5F8833A@kernel.crashing.org>
In-Reply-To: <9223B51A-4340-4636-B1F8-6D49A5F8833A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903131524.36865.david.jander@protonic.nl>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 March 2009 14:21:57 Kumar Gala wrote:
> >
> 
> What does cat /proc/cpuinfo show on this board?

# cat /proc/cpuinfo
processor       : 0
cpu             : e300c4
clock           : 400.000000MHz
revision        : 1.0 (pvr 8086 2010)
bogomips        : 99.84
timebase        : 50000000
platform        : MPC5121 Generic

> > +#ifdef CONFIG_PPC_MPC512x
> > +/* MPC512x: workaround for errata in die M36P and earlier:
> > + * Implement LRW for TLB way.
> > + */
> 
> This errata impacts a number of cores and so we should make this a CPU  
> feature fixup rather than #ifdef code.

It should impact only MPC5121e and probably MPC5123, but according to
Freescale no other processors that use this core...
Anyway, I'll try to investigate about how to write a "CPU feature fixup",
I've never done that before (If you could give me a hint?)

> > +       mfspr   r3,SPRN_DMISS
> > +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
> > +       lis     r2,lrw@ha       /* Search index in lrw[] */
> > +       addi    r2,r2,lrw@l
> > +       tophys(r2,r2)
> > +       lwzx    r1,r3,r2       /* Get item from lrw[] */
> > +       cmpwi   0,r1,0         /* Was it way 0 last time? */
> 
> Why not use a bit vector since we only need one bit of information.   
> Additionally we can use a single SPRG at that point instead to keep  
> track of the LRU information.

Sounds interesting. I am just learning my first steps in powerpc-assembly, so
please forgive if this is a little inefficient still. I'll try again next week.

Greetings,

-- 
David Jander
Protonic Holland.

Return-Path: <ntl@pobox.com>
Received: from proof.pobox.com (proof.pobox.com [207.106.133.28])
	by ozlabs.org (Postfix) with ESMTP id 0DE5767B25
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 11:10:16 +1000 (EST)
Date: Thu, 6 Apr 2006 20:10:02 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
Message-ID: <20060407011002.GF9208@localdomain>
References: <20060404112459.C9170679EB@ozlabs.org>
	<20060404172550.GE25663@localdomain>
	<1144236210.6788.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1144236210.6788.6.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2006-04-04 at 12:25 -0500, Nathan Lynch wrote:
> 
> > 2. I've tried it before.  Hope I'm remembering this correctly, but I
> >    think my experience was that query-cpu-stopped-state reported
> >    nonsense for cpus that were started by OF.  This was on Power5,
> >    btw.
> 
> That's not what I see, perhaps I have newer firmware?

I tried your patch (non-kexec boot) on a 1-way SMT power5 with
2.6.17-rc1 and got the badness below, and I think it matches what I
ran into in the past.  Maybe doing query-cpu-stopped-state on a thread
that has yet to be started by RTAS mucks things up?

Memory: 2047640k/2097152k available (5356k kernel code, 49512k
reserved, 1412k data, 900k bss, 240k init)
Calibrating delay loop... 375.80 BogoMIPS (lpj=751616)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
Processor 1 is stuck.               <<<<<<<<
Brought up 1 CPUs
Node 0 CPUs: 0
migration_cost=0

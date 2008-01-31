Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 7093CDDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 07:42:33 +1100 (EST)
Date: Thu, 31 Jan 2008 14:41:58 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Kernel oops while duming user core.
Message-ID: <20080131204158.GV14201@localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080131201601.GA10501@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Thu, Jan 31, 2008 at 11:40:04AM -0600, Rune Torgersen wrote:
> > Unable to handle kernel paging request for data at address 0x48024000
> > Faulting instruction address: 0xc000f0a0
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > PREEMPT Innovative Systems ApMax
> 
> Does it happen without preempt?
> 
> > Modules linked in: drv_wd(P) drv_scc devcom drv_pcir tipc drv_ss7
> > drv_auxcpu drv_leds(P) drv_ethsw proc_sysinfo(P) i2c_8266(P)
> > NIP: c000f0a0 LR: c0011fec CTR: 00000080
> > REGS: eebe9b70 TRAP: 0300   Tainted: P         (2.6.24-test)
> 
> Does it happen without the modules?

I doubt the modules are the problem; there was a practically identical
report from someone with an untainted 2.6.24-rc kernel a few weeks ago
(see my first reply to Rune).

> 
> > MSR: 00009032 <EE,ME,IR,DR>  CR: 24004442  XER: 00000000
> > DAR: 48024000, DSISR: 20000000
> 
> Hmm, this doesn't look like a valid DSISR, so I'm guessing this was a TLB
> miss that got redirected to DataAccess (or is there something that causes
> DSRISR[2] to be set on 8280?  I didn't see anything in the manual...). 
> However, SRR1 in that case seems to indicate a store, which dcbst shouldn't
> generate (except on 8xx, according to the comment in update_mmu_cache).
> 
> Do you have a simple test case that we could try to reproduce?  I tried a
> simple core dump on an 8280, and it worked.

Is the crashing program multithreaded?  The first report had firefox
triggering the oops.

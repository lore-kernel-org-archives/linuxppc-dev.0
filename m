Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.srv.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 91BF367A80
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 04:42:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16885.13185.849070.479328@alkaid.it.uu.se>
Date: Mon, 24 Jan 2005 18:42:25 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1106529935.5587.9.camel@gaston>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
 > 
 > > I know about this problem, I'm working on a proper fix. Thanks for your
 > > report.
 > 
 > Can you send me the PVR value for both of these CPUs
 > (cat /proc/cpuinfo) ? I can't find right now why they would lock up
 > unless the default idle loop is _not_ run properly, that is for some
 > reason, NAP or DOZE mode end up not beeing enabled. Can you send me
 > your .config as well ?

=== cpuinfo.emac ===
processor	: 0
cpu		: 7447/7457, altivec supported
clock		: 1249MHz
revision	: 1.1 (pvr 8002 0101)
bogomips	: 830.66
machine		: PowerMac6,4
motherboard	: PowerMac6,4 MacRISC3 Power Macintosh 
detected as	: 287 (Unknown Intrepid-based)
pmac flags	: 00000000
L2 cache	: 512K unified
memory		: 256MB
pmac-generation	: NewWorld

=== cpuinfo.beige-g3 ===
processor	: 0
cpu		: 7455, altivec supported (a Sonnet G4 upgrade processor)
clock		: 66MHz <-- bogus, is 1.0GHz in reality
revision	: 2.1 (pvr 8001 0201)
bogomips	: 999.42
machine		: Power Macintosh
motherboard	: AAPL,Gossamer MacRISC
detected as	: 48 (PowerMac G3 (Gossamer))
pmac flags	: 00000000
memory		: 768MB
pmac-generation	: OldWorld

The .config files are a bit big, I'm sending them off-list.

 > Finally, try that patch and tell me if it makes a difference. It makes
 > sure we re-enable interrupts in cpu_idle, and thus should only be a
 > workaround. I found _one_ actual code path where we fail to re-enable
 > them, and this is when neither DOZE nor NAP mode is enabled, which
 > should not happen on any G3 (they should all support DOZE mode), and
 > might happe non some G4s if the chipset doesn't support NAP or
 > powersave_nap is set to 0 in proc, but that shouldn't be the case of an
 > eMac neither...
 > 
 > --- linux-work.orig/arch/ppc/kernel/idle.c	2005-01-24 11:42:35.000000000 +1100
 > +++ linux-work/arch/ppc/kernel/idle.c	2005-01-24 12:19:41.114353760 +1100
 > @@ -39,17 +39,15 @@
 >  	powersave = ppc_md.power_save;
 >  
 >  	if (!need_resched()) {
 > +		local_irq_enable();
 >  		if (powersave != NULL)
 >  			powersave();
 >  		else {
 >  #ifdef CONFIG_SMP
 >  			set_thread_flag(TIF_POLLING_NRFLAG);
 > -			local_irq_enable();
 >  			while (!need_resched())
 >  				barrier();
 >  			clear_thread_flag(TIF_POLLING_NRFLAG);
 > -#else
 > -			local_irq_enable();
 >  #endif
 >  		}
 >  	}

Yes, this patch made the eMac boot Ok -- I can't test the Beige G3 until Friday.

/Mikael

Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg.
	traps, exceptions and ptrace
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20091210174135.GW2937@zod.rchland.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
	<20091210172711.GV2937@zod.rchland.ibm.com>
	<20091210174135.GW2937@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Dec 2009 12:05:09 -0600
Message-Id: <1260468309.1174.1.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-10 at 12:41 -0500, Josh Boyer wrote:
> On Thu, Dec 10, 2009 at 12:27:11PM -0500, Josh Boyer wrote:
> >On Thu, Dec 10, 2009 at 01:57:27PM -0200, Dave Kleikamp wrote:
> >>+static void prime_debug_regs(struct thread_struct *thread)
> >>+{
> >>+	mtspr(SPRN_IAC1, thread->iac1);
> >>+	mtspr(SPRN_IAC2, thread->iac2);
> >>+	mtspr(SPRN_IAC3, thread->iac3);
> >>+	mtspr(SPRN_IAC4, thread->iac4);
> >>+	mtspr(SPRN_DAC1, thread->dac1);
> >>+	mtspr(SPRN_DAC2, thread->dac2);
> >>+	mtspr(SPRN_DVC1, thread->dvc1);
> >>+	mtspr(SPRN_DVC2, thread->dvc2);
> >>+	mtspr(SPRN_DBCR0, thread->dbcr0);
> >>+	mtspr(SPRN_DBCR1, thread->dbcr1);
> >>+	mtspr(SPRN_DBCR2, thread->dbcr2);
> >
> >405 has no DBCR2, so I doubt setting it via mtspr would be good.  Does this
> >compile for 40x and did you test it at all?
> >
> >Also, looking at the current kernel it seems SPRN_DBCR2 is only defined for
> >CONFIG_PPC_BOOK3E_64 which is also inaccurate.
> 
> I mis-read the code on this part.  SPRN_DBCR2 gets defined unconditionally,
> so Book-E should be fine.  Still seems broken on 405 though.

Agreed.  I'll rushed through the 405 stuff a bit.  I'll scrutinize and
test it before I post again.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

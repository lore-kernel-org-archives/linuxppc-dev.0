Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39599B6F70
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 14:12:17 +1000 (EST)
Subject: Re: [PATCH] powerpc: add denormalisation exception handling for
	POWER6/7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9875FD87-1762-4CCE-8A34-7BAC2C42E9A6@kernel.crashing.org>
References: <11738.1310363538@neuling.org>
	<9875FD87-1762-4CCE-8A34-7BAC2C42E9A6@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jul 2011 14:12:04 +1000
Message-ID: <1310443924.4968.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-07-11 at 22:51 -0500, Kumar Gala wrote:
> On Jul 11, 2011, at 12:52 AM, Michael Neuling wrote:
> 
> > On POWER6 and POWER7 if the input operand to an instruction is a
> > denormalised single precision binary floating we can take a
> > denormalisation exception where it's expected that the hypervisor (HV=1)
> > will fix up the inputs before the instruction is run.
> > 
> > This adds code to handle this denormalisation exception for POWER6 and
> > POWER7.
> > 
> > It also add a CONFIG_PPC_DENORMALISATION option and sets it in
> > pseries/ppc64_defconfig. 
> > 
> > This is useful on bare metal systems only.  Based on patch from Milton
> > Miller.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > 
> > ---
> > arch/powerpc/Kconfig                   |    7 +
> > arch/powerpc/configs/ppc64_defconfig   |    1 
> > arch/powerpc/configs/pseries_defconfig |    1 
> > arch/powerpc/include/asm/ppc-opcode.h  |    2 
> > arch/powerpc/include/asm/reg.h         |    1 
> > arch/powerpc/kernel/exceptions-64s.S   |  125 +++++++++++++++++++++++++++++++++
> > 6 files changed, 137 insertions(+)
> 
> Is it possible to run POWER6/7 systems in baremetal if you are not IBM?
> 
> Just wondering if this is useful to anyone but IBM.

While I cannot obviously comment on unreleased systems, the fact that
we've been contributing all sort of patches to run P7 in "HV" mode and
KVM on them should be enough of a hint :-)

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91BCEDE677
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:45:57 +1100 (EST)
Subject: Re: [PATCH 1/20] [POWERPC] Reworking machine check handling and
	Fix 440/440A
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071213135317.0cffbfb8@weaponx>
References: <20071213073836.A25EDDDF80@ozlabs.org>
	<20071213135317.0cffbfb8@weaponx>
Content-Type: text/plain; charset=utf-8
Date: Fri, 14 Dec 2007 07:38:56 +1100
Message-Id: <1197578336.15741.154.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This breaks non-44x based arch/ppc platforms.  For example ep405 in
> arch/ppc fails with:
> 
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c: In function ‘machine_check_440A’:
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: ‘MCSR_IB’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: (Each undeclared identifier is reported only once
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: for each function it appears in.)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:262: error: ‘MCSR_DRB’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:264: error: ‘MCSR_DWB’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:266: error: ‘MCSR_TLBP’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:268: error: ‘MCSR_ICP’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:272: error: ‘MCSR_DCSP’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:274: error: ‘MCSR_DCFP’ undeclared (first use in this function)
> /home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:276: error: ‘MCSR_IMPE’ undeclared (first use in this function)
> make[2]: *** [arch/ppc/kernel/traps.o] Error 1
> 
> The same is true for other platforms as well.  Getting closer...

True, I intended to use 4xx not 44x for the ifdef... very easy typo to
make.

Ben.

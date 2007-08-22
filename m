Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0CFFDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:57:57 +1000 (EST)
In-Reply-To: <653AD812-D186-4876-BF52-F3A5D887B82E@kernel.crashing.org>
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
	<653AD812-D186-4876-BF52-F3A5D887B82E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <694575D6-C4BC-4FFB-91C1-B692181CEF6F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Date: Wed, 22 Aug 2007 09:59:58 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 8:25 AM, Kumar Gala wrote:

> How do we want to handle the include cleanup I've got.
>
> I know you'd like some way of showing it complete.  Any ideas?

So I did the following:

1. generate a file listing of asm-powerpc vs asm-ppc and diff them to  
find all files in asm-ppc not in asm-powerpc (after my patches)
2. count the number of references using the following grep:

	grep -r asm/ppcboot.h . | grep -v arch/ppc | grep -v include/asm-ppc  
| grep -v arch/[a-o,q-z] | grep -v include/asm-[a-o,q-z] | wc -l

I get the following results:

0: asm/amigappc.h
0: asm/gg2.h
0: asm/gt64260_defs.h
0: asm/gt64260.h
0: asm/harrier.h
0: asm/hawk_defs.h
0: asm/hawk.h
0: asm/ibm403.h
0: asm/ibm405.h
0: asm/ibm_ocp.h
0: asm/ibm_ocp_pci.h
0: asm/immap_85xx.h
0: asm/m8260_pci.h
0: asm/md.h
0: asm/mk48t59.h
0: asm/mpc10x.h
0: asm/mpc8260_pci9.h
0: asm/mv64x60_defs.h
0: asm/mv64x60.h
0: asm/ocp_ids.h
0: asm/open_pic.h
0: asm/pc_serial.h
0: asm/pnp.h
0: asm/ppc4xx_dma.h
0: asm/ppc4xx_pic.h
0: asm/ppc_sys.h
0: asm/prep_nvram.h
0: asm/raven.h
0: asm/rio.h
0: asm/todc.h
1: asm/amipcmcia.h
1: asm/mpc83xx.h
1: asm/residual.h
1: asm/zorro.h
2: asm/amigayle.h
2: asm/ppcboot.h
3: asm/ibm4xx.h
4: asm/ibm44x.h
4: asm/traps.h
8: asm/ocp.h
12: asm/bootinfo.h
29: asm/amigaints.h
32: asm/amigahw.h

I think we can all agree that the amiga*.h, zorro.h and traps.h can  
be ignored since they have to do with amiga/apus support.

I'll take a look at the following and see what's going on:

1: asm/mpc83xx.h
1: asm/residual.h
2: asm/ppcboot.h
3: asm/ibm4xx.h
4: asm/ibm44x.h
8: asm/ocp.h
12: asm/bootinfo.h

- k

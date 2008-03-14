Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC5EBDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 13:11:57 +1100 (EST)
In-Reply-To: <20080313224234.0A4FB26F993@magilla.localdomain>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
	<20080313224234.0A4FB26F993@magilla.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7d9961563967d5f810a5f597519a7c63@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Fri, 14 Mar 2008 03:11:12 +0100
To: Roland McGrath <roland@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The pointer to the test case was given here before.

Oh, I missed that.  Anyway, I wanted to see the asm, and who knows,
with different compiler versions and all that.

> 	0x10000984 <child_thread+52>:   bl      0x10001750 <sleep>
> 	0x10000988 <child_thread+56>:   lis     r9,4097
> --->	0x1000098c <child_thread+60>:   stw     r29,7792(r9)

> 	0x0000000010000d4c <child_thread+60>:   bl      0x10000a88
> 	0x0000000010000d50 <child_thread+64>:   ld      r2,40(r1)
> 	0x0000000010000d54 <child_thread+68>:   ld      r9,-32688(r2)
> --->	0x0000000010000d58 <child_thread+72>:   std     r29,0(r9)

In both these cases, the storage access goes to LSU0, so you're
not hitting the errata.

I noticed set_dabr() doesn't do proper synchronisation insns, could
you try this patch?  I doubt it helps, but it changes the code to do
"the right thing".


diff --git a/arch/powerpc/kernel/process.c 
b/arch/powerpc/kernel/process.c
index 4846bf5..ee925f5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -250,7 +250,9 @@ int set_dabr(unsigned long dabr)

         /* XXX should we have a CPU_FTR_HAS_DABR ? */
  #if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
+       asm("sync");
         mtspr(SPRN_DABR, dabr);
+       asm("isync");
  #endif
         return 0;
  }


(badly copy/pasted, please apply by hand.  Will send a real patch later 
;-) )

If this doesn't help, and the failures stay intermittent, I don't think 
there
is a close-to-the-hardware problem here.


Segher

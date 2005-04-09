Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2EFE67B2C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Apr 2005 05:04:08 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Date: Sat, 9 Apr 2005 21:03:54 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEGMCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <86e2fa4b5afe5bd8afc33ca47a7ab50c@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 8xx v2.6 TLB problems and suggested workaround
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Apr 8, 2005, at 7:07 AM, Marcelo Tosatti wrote:
> 
> > 1) _tlbie() on update_mmu_cache() surrounded by CONFIG_8xx #ifdef
> > Did you give up about it?
> 
> I think a tlbia() of the vaddr should work here.  No sense blowing
> away the whole TLB cache for this.

Umm, isn't it the other way around? tlbie flushes one TLB whereas tlbia flushes
all TLBs.

> > What else you think can be done?
> 
> It would be interesting to change __flush_dcache_icache()
> to use the 8xx SPR cache operations instead of the dcbst instruction.

yes, but I think these operates on physical addresses which makes it a bit harder.
I still think this can be resolved in fault.c. Replace 
	andis.	r11, r10, 0x0200	/* If set, indicates store op */
	beq	2f
in the DTLB Error handler with
	andis.	r11, r10, 0x4800	/* If set, indicates invalid pte or protection violation */
	bne	2f
In fault.c you can check if both store and invalid is set simultaneously. If it is, clear
the store flag and continue as usual.

> I wouldn't be surprised if it worked differently, but I'd not be
> able to explain it :-)
> 
> Thanks.
> 
> 	-- Dan
> 

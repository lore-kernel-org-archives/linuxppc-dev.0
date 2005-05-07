Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36900679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 04:11:06 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"Dan Malek" <dan@embeddededge.com>
Date: Sat, 7 May 2005 20:10:38 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHGEJMCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050424165520.GA22786@logos.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
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

> Hi Dan, Joakim,
> 
> On Sat, Apr 23, 2005 at 08:00:39PM -0400, Dan Malek wrote:
> > 
> > On Apr 23, 2005, at 7:51 PM, Joakim Tjernlund wrote:
> > 
> > >hmm, I have more than 24MB of memory and I can run CONFIG_PIN_TLB just
> > >fine with modules off in kernel 2.4. Havn't tried 2.6 yet.
> > 
> > Doh.  Oh, I see.  We only do the optimization for the instruction 
> > misses.
> > I'll have to take a closer look at Marcelo's 2.6 tests.
> 
> The PIN TLB entry option does not make much difference in my tests, 
> never did.
> 
> Who wrote the code? Are there results which indicate a performance gain
> from TLB pinning on 8xx? If so, where are such results? 
> 
> One problem that I've noted is that initial_mmu sets {I,D}TLB index
> to be 27 (11100). 
> 
> MI_RSV4I protects TLB's 27...31.
> 
> Given that both {I,D}TLB INDEX's are _decreased_ on each update, it seems
> to me that initial_mmu should set {I,D}TLB INDEX to 31, which will then 
> decrease down to 27 after 4 TLB's are created.  
> 
> Another question that comes to mind is why initial_mmu does create 
> additional 8Meg TLB entries for D-cache but not for I-cache: 
> 
> #ifdef CONFIG_PIN_TLB
>         /* Map two more 8M kernel data pages.
>         */
> 	...
> #endif

Not completly sure that this is correct. There are a few:
	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
later on which will "overflow" 0x1f00 into 0x2000 etc.

 Jocke
> 
> I'll do some more CONFIG_PIN_TLB tests this week...
> 
> --- head_8xx.S.orig2	2005-04-24 17:55:59.000000000 -0300
> +++ head_8xx.S	2005-04-24 17:57:44.000000000 -0300
> @@ -697,7 +697,7 @@
>  	tlbia			/* Invalidate all TLB entries */
>  #ifdef CONFIG_PIN_TLB
>  	lis	r8, MI_RSV4I@h
> -	ori	r8, r8, 0x1c00
> +	ori	r8, r8, 0x1f00
>  #else
>  	li	r8, 0
>  #endif
> @@ -705,7 +705,7 @@
>  
>  #ifdef CONFIG_PIN_TLB
>  	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
> -	ori	r10, r10, 0x1c00
> +	ori	r10, r10, 0x1f00
>  	mr	r8, r10
>  #else
>  	lis	r10, MD_RESETVAL@h

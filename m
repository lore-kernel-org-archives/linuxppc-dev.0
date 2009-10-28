Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F378B7BED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 09:18:03 +1100 (EST)
Subject: Re: Cache enable missing while creating TLBs for PPC440
	platform.head_44x.S file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vineeth _ <blacklites@gmail.com>
In-Reply-To: <a9b543570910280639j1ea9038du452249e89215a57e@mail.gmail.com>
References: <a9b543570910280639j1ea9038du452249e89215a57e@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 09:17:51 +1100
Message-ID: <1256768271.26770.9.camel@pasglop>
Mime-Version: 1.0
Cc: Johnny Hung <johnny.hacking@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-28 at 19:09 +0530, Vineeth _ wrote:
> Hi,
> we are porting Linux 2.6.30 on a ppc440x5 based board.
> when we check the kernel code in arch/powerpc/kernel/head_44x.S file @
> line number 162,
> while creating the TLB for 256MB, the cache enable/disable property is
> not set by the kernel ? or are we missing smthing ?
> when we gave that particular attribute, things started working. Please
> find the kernel code below. We added "PPC44x_TLB_I" attribute to set
> the cache, kernel started working.

Ugh ?

Why would you want to set I on the kernel memory ? I means "cache
inhibited", which -disables- the cache. You really don't want that. You
must have something else wrong.

Cheers,
Ben.

> ----arch/powerpc/kernel/head_44x.S
> 
> /* Load the kernel PID = 0 */
> li  r0,0
> mtspr   SPRN_PID,r0
> sync
> 
> /* Initialize MMUCR */
> li  r5,0
> mtspr   SPRN_MMUCR,r5
> sync
> 
> /* pageid fields */
> clrrwi  r3,r3,10        /* Mask off the effective page number */
> ori r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_256M
> 
> /* xlat fields */
> clrrwi  r4,r4,10        /* Mask off the real page number */
> /* ERPN is 0 for first 4GB page */
> 
> /* attrib fields */
> /* Added guarded bit to protect against speculative loads/stores */
> li  r5,0
> ori r5,r5,(PPC44x_TLB_I|PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX
> | PPC44x_TLB_G)
> /* that cache thing u see above line is added by some malguns there's
> some issue */
> 
> li      r0,63                    /* TLB slot 63 */
> 
> tlbwe   r3,r0,PPC44x_TLB_PAGEID /* Load the pageid fields */
> tlbwe   r4,r0,PPC44x_TLB_XLAT   /* Load the translation fields */
> tlbwe   r5,r0,PPC44x_TLB_ATTRIB /* Load the attrib/access fields */
> 
> ---------
> 
> Is this can be considered as a good patch ?
> 
> Thanks
> Vineeth _
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

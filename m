Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39B1B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 03:46:49 +1100 (AEDT)
Message-ID: <1444149995.5336.282.camel@freescale.com>
Subject: Re: [PATCH v2 01/25] powerpc/8xx: Save r3 all the time in DTLB miss
 handler
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 6 Oct 2015 11:46:35 -0500
In-Reply-To: <5613CE1C.40806@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <2d35de4435e873f23d37e3b5b5fb34c64421f136.1442939410.git.christophe.leroy@c-s.fr>
 <20150928220717.GA6161@home.buserror.net> <5613CE1C.40806@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 15:35 +0200, Christophe Leroy wrote:
> Le 29/09/2015 00:07, Scott Wood a écrit :
> > On Tue, Sep 22, 2015 at 06:50:29PM +0200, Christophe Leroy wrote:
> > > We are spending between 40 and 160 cycles with a mean of 65 cycles in
> > > the TLB handling routines (measured with mftbl) so make it more
> > > simple althought it adds one instruction.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Does this just make it simpler or does it make it faster?  What is the
> > performance impact?  Is the performance impact seen with or without
> > CONFIG_8xx_CPU6 enabled?  Without it, it looks like you're adding an
> > mtspr/mfspr combo in order to replace one mfspr.
> > 
> > 
> The performance impact is not noticeable. Theoritically it adds 1 cycle 
> on a mean of 65 cycles, that is 1.5%. Even in the worst case where we 
> spend around 10% of the time in TLB handling exceptions, that represents 
> only 0.15% of the total CPU time. So that's almost nothing.
> Behind the fact to get in simpler, the main reason is because I need a 
> third register for the following patch in the set, otherwise I would 
> spend a more time saving and restoring CR several times.

FWIW, the added instruction is an SPR access and I doubt that's only one 
cycle.

-Scott

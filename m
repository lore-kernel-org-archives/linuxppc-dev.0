Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0102.outbound.protection.outlook.com [157.56.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9B381A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 08:07:31 +1000 (AEST)
Date: Mon, 28 Sep 2015 17:07:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 01/25] powerpc/8xx: Save r3 all the time in DTLB miss
 handler
Message-ID: <20150928220717.GA6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <2d35de4435e873f23d37e3b5b5fb34c64421f136.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2d35de4435e873f23d37e3b5b5fb34c64421f136.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:29PM +0200, Christophe Leroy wrote:
> We are spending between 40 and 160 cycles with a mean of 65 cycles in
> the TLB handling routines (measured with mftbl) so make it more
> simple althought it adds one instruction.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Does this just make it simpler or does it make it faster?  What is the
performance impact?  Is the performance impact seen with or without
CONFIG_8xx_CPU6 enabled?  Without it, it looks like you're adding an
mtspr/mfspr combo in order to replace one mfspr.

-Scott

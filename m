Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNChm4YsKzDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 11:51:28 +1000 (AEST)
Message-ID: <1501721928.2664.17.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Aug 2017 10:58:48 +1000
In-Reply-To: <87r2wtr03d.fsf@concordia.ellerman.id.au>
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
 <87r2wtr03d.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 10:01 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Wed, 2017-08-02 at 18:43 +0200, Cédric Le Goater wrote:
> > > If xive_find_target_in_mask() fails to find a cpu, the fuzz value used
> > > in xive_pick_irq_target() is decremented and reused in the last
> > > returning call to xive_find_target_in_mask(). This can result in such
> > > WARNINGs if the initial fuzz value is zero :
> > 
> > Ah indeed ... would have worked better if "fuzz" had been unsigned.
> 
> Is that an ack or a changes requested?

Either ;-) The original code would have been fine with an unsigned, I
didn't realize it was signed and going negative. That said, cedric
patch is fine.

Cheers,
Ben.

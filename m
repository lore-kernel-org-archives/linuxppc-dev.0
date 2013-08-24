Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46A232C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:20:20 +1000 (EST)
Message-ID: <1377303610.3819.4.camel@pasglop>
Subject: Re: [PATCH] powerpc/ppc64: remove __volatile__ in  get_current()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Yang <James.Yang@freescale.com>
Date: Sat, 24 Aug 2013 10:20:10 +1000
In-Reply-To: <alpine.LRH.2.00.1308231832570.4940@ra8135-ec1.am.freescale.net>
References: <1376110162-3462-1-git-send-email-James.Yang@freescale.com>
 <alpine.LRH.2.00.1308231832570.4940@ra8135-ec1.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 18:40 -0500, James Yang wrote:
> Scott's been able to put enough doubt in me to think that this is not 
> entirely safe, even though the testing and code generation show it to 
> work.  Please reject this patch.
> 
> I think there is still value in getting the unnecessary loads to be 
> removed since it would also allow unnecessary conditional branches to 
> be removed.  I'll think about alternate ways to do this.

Hrm, The problem has to do with PACA accesses moving around accross
preempt boundaries, it's a bit tricky, but in the case of "current"
shouldn't be a problem... while the rest of the PACA might change (CPU#
etc...) current remains stable for the point of view of a given thread.

So I think the patch is fine.

Scott ?

Now, we do need some serious rework of PACA accesses. I'm very *VERY*
nervous with what we have now. A bit of grepping shows dozens of cases
where gcc copies r13 into another register or even saves/restores it, it
scares the shit out of me :-)

My thinking is to make r13 a hidden reg like we do (or used to) on ppc32
with r2 and break down paca access into two forms:

 - Direct access of a single field -> asm loads/stores inline

 - Anything else, uses a get_paca/put_paca construct that includes a
preempt_disable/enable (and maybe along with a __get_paca/__put_paca
pair that doesn't). This basically does a mr of r13 into another
register and basically hides the whole lot from gcc.

The former would be used for single fields, the latter, while adding a
potentially unnecessary mr, will be much safer vs. gcc playing games
with r13.

Any volunteer ? Haven't had time to do it myself so far :-)

Cheers,
Ben.

Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 81C6EDDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 22:29:58 +1000 (EST)
Date: Thu, 25 Oct 2007 14:29:12 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] mpc52xx: stop drivers from accessing clock config
	directly
Message-ID: <20071025122912.GF3369@nd47.coderock.org>
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
	<20071024191206.GD3369@nd47.coderock.org>
	<fa686aa40710241314w2dbe0863ja15746614cff0dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710241314w2dbe0863ja15746614cff0dd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 24/10/07 14:14 -0600, Grant Likely wrote:
> On 10/24/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > On 24/10/07 12:24 -0600, Grant Likely wrote:
> > > Domen,
> > >
> > > Here's a real solution to the problem.  I've somewhat tested this on
> > > the lite5200b.  Can you give it a spin on efika and see if SPI still
> > > works for you?
> >
> > My test case was lite5200b too, I don't think I ever tried SPI on
> > efika.
> > (Are even the right pins on irda connector, or is a necessary line
> > missing?)
> 
> Hmm, I guess that's right.  Can you at least make sure it still boots
> on Efika?  Some of the clock detection stuff has changed so I want to
> make sure it still boots.

OK, with the following patch it compiles and boots.
I don't have any psc configured as spi in device tree though.



---
 arch/powerpc/platforms/52xx/efika.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux.git/arch/powerpc/platforms/52xx/efika.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/52xx/efika.c
+++ linux.git/arch/powerpc/platforms/52xx/efika.c
@@ -180,7 +180,7 @@ static void __init efika_setup_arch(void
 {
 	rtas_initialize();
 
-	mpc52xx_setup_clocks();
+	mpc5200_setup_clocks();
 
 	efika_pcisetup();
 

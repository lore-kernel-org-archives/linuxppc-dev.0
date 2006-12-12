Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9436067C72
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 15:53:59 +1100 (EST)
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
References: <200612120402.kBC42USg007674@toshiba.co.jp>
	<1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 15:53:46 +1100
Message-Id: <1165899226.11914.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-12 at 15:13 +1100, Michael Ellerman wrote:
> On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> > op_model_cell supports native Cell processor. Under LPAR environment,
> > it cannot work.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> > ---
> > 
> > Index: linux-powerpc-git/arch/powerpc/oprofile/common.c
> > diff -u linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1 linux-powerpc-git/arch/powerpc/oprofile/common.c:1.2
> > --- linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1	Wed Dec  6 08:25:43 2006
> > +++ linux-powerpc-git/arch/powerpc/oprofile/common.c	Wed Dec  6 08:43:15 2006
> > @@ -149,6 +149,8 @@
> >  #ifdef CONFIG_PPC64
> >  #ifdef CONFIG_PPC_CELL_NATIVE
> >  		case PPC_OPROFILE_CELL:
> > +			if (firmware_has_feature(FW_FEATURE_LPAR))
> > +				return -ENODEV;
> >  			model = &op_model_cell;
> >  			break;
> >  #endif
> 
> Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.

For now, it probably is as none of the LPAR env. for cell work with that
op_model.

Ben.

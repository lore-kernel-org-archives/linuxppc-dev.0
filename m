Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24BC967F17
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:49:54 +1100 (EST)
Date: Tue, 12 Dec 2006 20:49:45 +0900 (JST)
Message-Id: <200612121149.kBCBnjol020416@toshiba.co.jp>
To: michael@ellerman.id.au
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
In-Reply-To: <1165899356.14839.20.camel@concordia.ozlabs.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Tue, 2006-12-12 at 15:53 +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2006-12-12 at 15:13 +1100, Michael Ellerman wrote:
> > > On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> > > > op_model_cell supports native Cell processor. Under LPAR environment,
> > > > it cannot work.
> > > > 
> > > > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> > > > ---
> > > > 
> > > > Index: linux-powerpc-git/arch/powerpc/oprofile/common.c
> > > > diff -u linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1 linux-powerpc-git/arch/powerpc/oprofile/common.c:1.2
> > > > --- linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1	 Wed Dec  6 08:25:43 2006
> > > > +++ linux-powerpc-git/arch/powerpc/oprofile/common.c		 Wed Dec  6 08:43:15 2006
> > > > @@ -149,6 +149,8 @@
> > > >  #ifdef CONFIG_PPC64
> > > >  #ifdef CONFIG_PPC_CELL_NATIVE
> > > >			case PPC_OPROFILE_CELL:
> > > > +			if (firmware_has_feature(FW_FEATURE_LPAR))
> > > > +					return -ENODEV;
> > > >							model = &op_model_cell;
> > > >								break;
> > > >  #endif
> > > 
> > > Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.
> > 
> > For now, it probably is as none of the LPAR env. for cell work with that
> > op_model.
> 
> Sure, there's probably twenty different things we could use at the
> moment, I'm just wondering out loud if LPAR is the best thing to reduce
> the chance we have to change it in the future.

We will implement Cell LPAR support in the future. The code doesn't
exist now, and it tries to use oprofile_timer by returning -ENODEV
here.
				   
Thank you,
Kou Ishizaki
Toshiba

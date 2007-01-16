Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B8C5DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 22:28:34 +1100 (EST)
Date: Tue, 16 Jan 2007 20:28:27 +0900 (JST)
Message-Id: <200701161128.l0GBSSq4014709@toshiba.co.jp>
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
To: anton@samba.org, will_schmidt@vnet.ibm.com
In-Reply-To: <1168877276.11068.14.camel@localhost>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello everyone,

> > Just a few suggestions.

Thank you for your comments.


> > > +#define	   HCALL_MEDIUM	or	2,2,2
> > 
> > Doesnt look like this is used.
> 
> seconded.  that #define is identical to HMT_MEDIUM out of ppc_asm.h.  I
> notice that HMT_MEDIUM is actually used throughout this patch, so most
> of the way there already.

We'll remove it.

<asm/ppc_asm.h> is already included so we don't have to have
HMT_MEDIUM or HCALL_MEDIUM defintion in that file.


> > > +#define		   HVSC	     .long   0x44000022
> > 
> > Could you pick this up from the define in include/asm-powerpc instead?
> 
> "#include <asm/hvcall.h>" should do it.

As Geoff-san said, "sc 1" is not supported in Debian or our own assembler,
so we have to keep it.

We think <asm/hvcall.h> is only for IBM's hypervisor, so we don't want
to include <asm/hvcall.h> only to get HVSC definition in our hvCall.S;
so we will keep HVSC definition here.


> > > +#define	LOAD_CONST64(r, const)					\
> > > +		lis		r, ((const)>>48)&0xFFFF;				\
> > > +		ori		r, r, ((const)>>32)&0xFFFF;						\
> > > +		rldicr		r, r, 32, 31;										  \
> > > +		oris		r, r, ((const)>>16)&0xFFFF;								    \
> > > +		ori		r, r, ((const)>>0)&0xFFFF
> > 
> > It doesnt look like this is used either.

We'll remove it.

Best regards,
Kou Ishizaki

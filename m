Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C79CDDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 19:28:51 +1100 (EST)
Date: Wed, 20 Dec 2006 17:28:44 +0900 (JST)
Message-Id: <200612200828.kBK8SjOt001581@toshiba.co.jp>
To: Geert.Uytterhoeven@sonycom.com
Subject: Re: [PATCH 8/19] powerpc: interfaces to the hypervisor of Celleb
In-Reply-To: <Pine.LNX.4.62.0612140930500.30229@pademelon.sonytel.be> 
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

Geert-san,

> On Thu, 14 Dec 2006, Ishizaki Kou wrote:
> > --- /dev/null      Wed Dec 13 21:32:01 2006
> > +++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall_macro.S	Wed Dec 13 18:37:14 2006
> 
> > +#define	__define_beat_callup_handler_NOOUTS(name, id)		\
> > +_GLOBAL(beat_##name)										\
> > +													HCALL_MEDIUM;	     \
> > +													mflr		     r0;      \
> > +													std		     r0, 16(r1);     \
> > +													HCALL_INST_PRECALL;		       \
> > +													LOAD_CONST64(r11,id);		           \
> > +													HVSC;					         \
> > +													HCALL_INST_POSTCALL;				     \
> > +													ld						     r0, 16(r1);     \
> > +													mtlr						     r0;	         \
> > +													blr
> 
> `id' is always the name prefixed with `HV_'? In that case you can use
> `HV_##name', so you don't have to pass the number.

It's in that case, since `id' is assumed to be a hypervisor-call number,
and defined in celleb/beat_syscall.h.

> > --- /dev/null	Wed Dec 13 21:32:02 2006
> > +++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall.S	Wed Dec 13 18:37:14 2006
> 
> > +__define_beat_callup_handler_OUT2(4, allocate_memory, (0))
>                                                          ^^^
> I.e., these can go away.

I'll modify them so.
These sources are generated from our 'hvcall table', so we have to
modify the generator.

Best Regards,
Kou Ishizaki

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 54B5467C25
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 19:32:42 +1100 (EST)
Date: Thu, 14 Dec 2006 09:32:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 8/19] powerpc: interfaces to the hypervisor of Celleb
In-Reply-To: <200612140234.kBE2Y89L017576@toshiba.co.jp>
Message-ID: <Pine.LNX.4.62.0612140930500.30229@pademelon.sonytel.be>
References: <200612140234.kBE2Y89L017576@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Dec 2006, Ishizaki Kou wrote:
> --- /dev/null	Wed Dec 13 21:32:01 2006
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall_macro.S	Wed Dec 13 18:37:14 2006

> +#define	__define_beat_callup_handler_NOOUTS(name, id)		\
> +_GLOBAL(beat_##name)						\
> +	HCALL_MEDIUM;						\
> +	mflr	r0;						\
> +	std	r0, 16(r1);					\
> +	HCALL_INST_PRECALL;					\
> +	LOAD_CONST64(r11,id);					\
> +	HVSC;							\
> +	HCALL_INST_POSTCALL;					\
> +	ld	r0, 16(r1);					\
> +	mtlr	r0;						\
> +	blr

`id' is always the name prefixed with `HV_'? In that case you can use
`HV_##name', so you don't have to pass the number.

> --- /dev/null	Wed Dec 13 21:32:02 2006
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/hvCall.S	Wed Dec 13 18:37:14 2006

> +__define_beat_callup_handler_OUT2(4, allocate_memory, (0))
                                                         ^^^
I.e., these can go away.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

Date: Thu, 28 Oct 1999 21:24:56 -0600
From: Cort Dougan <cort@ppc.kernel.org>
To: Lou Langholtz <ldl@chpc.utah.edu>
Cc: linuxppc-dev@lists.linuxppc.org, gdt@linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
Message-ID: <19991028212456.B13879@chimaera.ppc.kernel.org>
References: <3818908A.8A6539B6@chpc.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3818908A.8A6539B6@chpc.utah.edu>; from Lou Langholtz on Thu, Oct 28, 1999 at 12:06:02PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The Linus tree is in sync with by the 2.2 and 2.3 right now.  Have you
tried 2.3.24 and/or 2.3.13?

The changes here should only affect the boot since that's the only place
they do anything.  Are you sure this change improved stability and now the
recent changes to PPP from Paul?

} In my quest to figure out how to increase the stability of the kernel
} while it's using network communications over PPP links, so far I've
} found that the best improvement has been from a patch I applied to the
} arch/ppc/kernel/head.S file. I believe this was from changes made by
} Cort Dougan. Bless you Cort for my machine doesn't hang nearly as
} readily anymore. Unfortunately it does still hang but far less often.
} I've attached a diff of the changes I actually applied to my head.S file
} so it's clear what changes I'm talking about. What I'd like to know now
} is what's the 2.2 Linus kernel release that this actually shows up
} in? I think the patch is already in the vger 2.3 branch. It'd sure be
} nice if this improvement makes it to the mainstream kernel though.
} 
} Anyway, thanks for the great work. Hopefully the kernel PPP network
} stability bug can be completely nipped soon. Hopefully the feedback will
} help. Cheers ;-)

} --- arch/ppc/kernel/head.S.orig	Wed Aug 25 18:29:46 1999
} +++ arch/ppc/kernel/head.S	Wed Oct 13 10:23:36 1999
} @@ -1,7 +1,7 @@
}  /*
}   *  arch/ppc/kernel/head.S
}   *
} - *  $Id: head.S,v 1.130.2.3 1999/08/10 21:36:48 cort Exp $
} + *  $Id: head.S,v 1.130.2.6 1999/10/12 21:36:48 cort Exp $
}   *
}   *  PowerPC version 
}   *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
} @@ -112,6 +112,10 @@
}  	
}  /* 601 only have IBAT cr0.eq is set on 601 when using this macro */ 
}  #define LOAD_BAT(n, offset, reg, RA, RB) \
} +	/* see the comment for clear_bats() -- Cort */ \
} +	li	RA,0;			\
} +	mtspr	IBAT##n##U,RA;		\
} +	mtspr	DBAT##n##U,RA;		\
}  	lwz	RA,offset+0(reg);	\
}  	lwz	RB,offset+4(reg);	\
}  	mtspr	IBAT##n##U,RA;		\
} @@ -285,6 +289,14 @@
}  	clrldi	r16,r16,63
}  	mtsdr1	r16
}  #else /* CONFIG_PPC64 */
} +	/*
} +	 * If the MMU is off clear the bats.  See clear_bat() -- Cort
} +	 */
} +	mfmsr	r20
} +	andi.	r20,r20,MSR_DR
} +	bne	100f
} +	bl	clear_bats
} +100:
}  	/* 
}  	 * allow secondary cpus to get at all of ram in early bootup
}  	 * since their init_task may be up there -- Cort
} @@ -1312,7 +1324,6 @@
}  #else
}  	bnelr-
}  #endif
} -
}  	ori	r6,r6,0x100		/* set _PAGE_ACCESSED in pte */
}  	rlwinm	r5,r4,5,24,24		/* _PAGE_RW access -> _PAGE_DIRTY */
}  	rlwimi	r5,r4,7,22,22		/* _PAGE_RW -> _PAGE_HWWRITE */
} @@ -2733,3 +2744,36 @@
}  	.globl	cmd_line
}  cmd_line:
}  	.space	512
} +
} +/* 
} + * An undocumented "feature" of 604e requires that the v bit
} + * be cleared before changing BAT values.
} + *
} + * Also, newer IBM firmware does not clear bat3 and 4 so
} + * this makes sure it's done.
} + *  -- Cort 
} + */
} +clear_bats:
} +	li	r20,0
} +	
} +	mtspr	DBAT0U,r20
} +	mtspr	DBAT0L,r20
} +	mtspr	IBAT0U,r20
} +	mtspr	IBAT0L,r20
} +	
} +	mtspr	DBAT1U,r20
} +	mtspr	DBAT1L,r20
} +	mtspr	IBAT1U,r20
} +	mtspr	IBAT1L,r20
} +	
} +	mtspr	DBAT2U,r20
} +	mtspr	DBAT2L,r20
} +	mtspr	IBAT2U,r20
} +	mtspr	IBAT2L,r20
} +	
} +	mtspr	DBAT3U,r20
} +	mtspr	DBAT3L,r20
} +	mtspr	IBAT3U,r20
} +	mtspr	IBAT3L,r20
} +
} +	blr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

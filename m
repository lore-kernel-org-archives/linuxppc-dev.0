Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B742067B67
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 00:58:35 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1FrFmI-0002Vn-UE
	for linuxppc-dev@ozlabs.org; Fri, 16 Jun 2006 09:58:31 -0500
To: linuxppc-dev@ozlabs.org
Subject: secondary CPU kicking on 86xx
Date: Fri, 16 Jun 2006 09:58:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FrFmI-0002Vn-UE@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ben and folks,

I have a question regarding your comments on our proposed
additions for the mpc86xx secondary CPU release code.
We need a way to bounce the secondary CPUs through the
reset vector at 0x100, and can either statically lay down
an address like GEMINI does today:

    --- a/arch/powerpc/kernel/head_32.S
    +++ b/arch/powerpc/kernel/head_32.S
    @@ -348,6 +348,9 @@ #define EXC_XFER_EE_LITE(n, hdlr)   \
     #if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
	    . = 0x100
	    b       __secondary_start_gemini
    +#elif defined(CONFIG_PPC_86xx) && defined(CONFIG_SMP)
    +       . = 0x100
    +       b       __secondary_hold_mpc86xx
     #else
	    EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
     #endif

Or we can dynamically rewrite a branch instruction into
the reset vector from C code during smp_kick_cpu() time
like the current powermac code does.

I have working code for both; just need opinions
and preferences on correct approach/style voiced!

Thanks,
jdl

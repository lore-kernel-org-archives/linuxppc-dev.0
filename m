Message-ID: <3C04820D.5070904@embeddededge.com>
Date: Wed, 28 Nov 2001 01:19:57 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 PTEs
References: <B164B53F5BD6D511888D009027732E1A02498E@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:


> All I need for kernel debugging is BAT only translation. I cleared it
> according to BDI2000 manual.

Ummm....I think you need more than that for debugging loadable modules.
The BAT translation won't work for loadable modules, you have to find
all of their code and data through page tables.

> I looked at 2.4.14 kernel. It only has BDI2000 support in file
> /arch/ppc/kernel/head_8xx.S

Well hell....I wonder why they were never updated in 2.4.14.  Take
a look at the PowerPC development kernels, then.

> Which lines do I have to add?

Add this right after the 'bl load_up_mmu':


        /* Add helper information for the Abatron bdiGDB debugger.
         * We do this here because we know the mmu is disabled, and
         * will be enabled for real in just a few instructions.
         */
        lis     r5, abatron_pteptrs@h
        ori     r5, r5, abatron_pteptrs@l
        stw     r5, 0xf0(r0)    /* This much match your Abatron config */
        lis     r6, swapper_pg_dir@h
        ori     r6, r6, swapper_pg_dir@l
        tophys(r5, r5)
        stw     r6, 0(r5)


Good Luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id D9B33DDF06
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 23:38:41 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so992126anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 06:38:40 -0700 (PDT)
Message-ID: <3ae3aa420807080638t41e8851bx2ad061dd5a4e0279@mail.gmail.com>
Date: Tue, 8 Jul 2008 08:38:35 -0500
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Mike Mason" <mmlnx@us.ibm.com>
Subject: Re: [PATCH] Restore PERR/SERR bit settings during EEH device recovery
In-Reply-To: <4872DC9C.4000706@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <4872DC9C.4000706@us.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/7/7 Mike Mason <mmlnx@us.ibm.com>:
> The following patch restores the PERR and SERR bits in the PCI
> command register during an EEH device recovery.
> We have found at least one case (an Agilent test card) where the
> PERR/SERR bits are set to 1 by firmware at boot time, but are
> not restored to 1 during EEH recovery.

Any chance they should be zero, and were accidentally set to 1?
In which case, you'd need an else clause, below.

> The patch fixes the
> Agilent card problem.  It has been tested on several other EEH-enabled cards
> with no regressions.
>
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
>
> --- linux-2.6.26-rc9/arch/powerpc/platforms/pseries/eeh.c       2008-07-07
> 16:06:57.000000000 -0700
> +++ linux-2.6.26-rc9-new/arch/powerpc/platforms/pseries/eeh.c   2008-07-07
> 16:11:10.000000000 -0700
> @@ -812,6 +812,7 @@
> static inline void __restore_bars (struct pci_dn *pdn)
> {
>        int i;
> +       u32 cmd;
>
>        if (NULL==pdn->phb) return;
>        for (i=4; i<10; i++) {
> @@ -832,6 +833,15 @@
>
>        /* max latency, min grant, interrupt pin and line */
>        rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
> +
> +       /* Restore PERR & SERR bits, some devices require it,
> +          don't touch the other command bits */
> +       rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
> +       if (pdn->config_space[1] & PCI_COMMAND_PARITY)
> +               cmd |= PCI_COMMAND_PARITY;

else cmd &= ~PCI_COMMAND_PARITY;

> +       if (pdn->config_space[1] & PCI_COMMAND_SERR)
> +               cmd |= PCI_COMMAND_SERR;

else cmd &= ~PCI_COMMAND_SERR;

> +       rtas_write_config(pdn, PCI_COMMAND, 4, cmd);
> }

Other than that, I'll add an

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

--linas

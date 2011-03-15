Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by ozlabs.org (Postfix) with SMTP id 1439DB6FF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 07:09:00 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 15 Mar 2011 21:08:55 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20110315174924.GA24001@z-innov.com>
Message-ID: <20110315200855.240730@gmx.net>
MIME-Version: 1.0
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
	<20110315171448.100300@gmx.net> <20110315174924.GA24001@z-innov.com>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
To: Sven Luther <sven@z-innov.com>
Cc: ppc.addon@gmail.com, linuxppc-dev@lists.ozlabs.org, acrux_it@libero.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 15 Mar 2011 18:49:24 +0100
> Von: Sven Luther <sven@z-innov.com>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: nello martuscielli <ppc.addon@gmail.com>, linuxppc-dev@lists.ozlabs.org, acrux_it@libero.it
> Betreff: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?

> On Tue, Mar 15, 2011 at 06:14:48PM +0100, Gerhard Pircher wrote:
[...]

> > On the other side you mentioned this workaround in
> > arch/ppc/kernel/prom_init.c to me some time ago:
> > 
> > unsigned long __init prom_init(int r3, int r4, prom_entry pp) :
> > >        node = call_prom("finddevice", 1, 1, "/");
> > >        rc = call_prom("getprop", 4, 1, node, "model", model,
> sizeof(model));
> > >        if (rc > 0 && !strncmp (model, "Pegasos", 7)
> > >                && strncmp (model, "Pegasos2", 8)) {
> > >                /* Pegasos 1 has a broken translate method in the OF,
> > >                 * and furthermore the BATs are mapped 1:1 so the phys
> > >                 * address calculated above is correct, so let's use
> > >                 * it directly.
> > >                 */
> > >        } else if (offset == 0) {
> > >                /* If we are already running at 0xc0000000, we assume
> we were
> > >                 * loaded by an OF bootloader which did set a BAT for
> us.
> > >                 * This breaks OF translate so we force phys to be 0.
> > >                 */
> > >                prom_print("(already at 0xc0000000) phys=0\n");
> > >                phys = 0;
> > >        } else if (call_prom("getprop", 4, 1, prom_chosen, "mmu",
> > >                             &prom_mmu, sizeof(prom_mmu)) <= 0) {
> > >                prom_print(" no MMU found\n");
> > >        } else if (call_prom_ret("call-method", 4, 4, result,
> "translate",
> > >                                 prom_mmu, &_stext, 1) != 0) {
> > >                prom_print(" (translate failed)\n");
> > >        } else {
> > >                /* We assume the phys. address size is 3 cells */
> > >                phys = result[2];
> > >        }
> > 
> > Can anybody comment, if this "broken translate method in the OF" would
> > still be needed for arch/powerpc?
> 
> Well, since this is long dead hardware not produced anymore, i don't see
> how the OF could have unbroken itself by moving to powerpc.
> 
> It has been age since i looked into this, but to the best of my knowledge
> (and i wrote the above code or at least the earlier versions) it should
> be still broken.
Any idea then, how the workaround can be ported to arch/powerpc/ or if
there is a better one available?

regards,
Gerhard
-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de

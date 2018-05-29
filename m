Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wGlC3klSzDr6V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:46:46 +1000 (AEST)
Date: Tue, 29 May 2018 16:46:40 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Mauricio Faria
 de Oliveira <mauricfo@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
Message-ID: <20180529164640.02faedcd@kitsune.suse.cz>
In-Reply-To: <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180528131914.32231-1-msuchanek@suse.de>
 <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 May 2018 16:13:49 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 28/05/2018 =C3=A0 15:19, Michal Suchanek a =C3=A9crit=C2=A0:
> > We now have barrier_nospec as mitigation so print it in
> > cpu_show_spectre_v1 when enabled.
> >=20
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/powerpc/kernel/security.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/security.c
> > b/arch/powerpc/kernel/security.c index 0239383c7e4d..a0c32d53980b
> > 100644 --- a/arch/powerpc/kernel/security.c
> > +++ b/arch/powerpc/kernel/security.c
> > @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device
> > *dev, struct device_attribute *attr, c if
> > (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) return
> > sprintf(buf, "Not affected\n");=20
> > -	return sprintf(buf, "Vulnerable\n");
> > +	if (barrier_nospec_enabled) =20
>=20
> > +		return sprintf(buf, "Mitigation: __user pointer
> > sanitization\n");
> > +	else
> > +		return sprintf(buf, "Vulnerable\n"); =20
>=20
> Checkpatch would tell you that an else is unneeded after a return. So=20
> just leave it as it was before.

Where did you get your copy of checkpatch? The one in Linux tree does
not do that.

Thanks

Michal

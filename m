Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSf522HBHzDvkB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 20:53:42 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so8056102pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:53:42 -0800 (PST)
Date: Tue, 29 Nov 2016 20:53:29 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: xmon compile fix
Message-ID: <20161129205329.7ba39d19@roar.ozlabs.ibm.com>
In-Reply-To: <cc525418-2763-6346-0106-325f81e6444c@c-s.fr>
References: <20161129085654.1967-1-npiggin@gmail.com>
 <cc525418-2763-6346-0106-325f81e6444c@c-s.fr>
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

On Tue, 29 Nov 2016 10:06:43 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 29/11/2016 à 09:56, Nicholas Piggin a écrit :
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/xmon/xmon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index 7605455..435f5f5 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> > @@ -1213,10 +1213,13 @@ bpt_cmds(void)
> >  {
> >  	int cmd;
> >  	unsigned long a;
> > -	int mode, i;
> > +	int i;
> >  	struct bpt *bp;
> > +#ifndef CONFIG_8xx  
> 
> CONFIG_8xx is deprecated (ref arch/powerpc/platforms/Kconfig.cputype).
> CONFIG_PPC_8xx should be used instead.

Thanks for picking that up. Michael, can you adjust it if you merge
please?

> 
> > +	int mode;  
> 
> You could also have moved this declaration inside the switch {, 
> something like

I tried that, couldn't decide that it was better (you also need badaddr).

Thanks,
Nick

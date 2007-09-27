Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 7961BDDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 04:23:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3465804wag
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 11:23:13 -0700 (PDT)
Message-ID: <fa686aa40709271123h1abda8fi1ec5bad038dae114@mail.gmail.com>
Date: Thu, 27 Sep 2007 12:23:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v3] Make instruction dumping work in real mode.
In-Reply-To: <46FBF1D6.7010400@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070927180001.GA18185@loki.buserror.net>
	<46FBF1D6.7010400@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/27/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Scott Wood wrote:
>
> > On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happens
> > that leads to a register dump, the kernel currently prints XXXXXXXX because
> > it doesn't realize that PC is a physical address.
>
> > This patch checks the state of the IMMU, and if necessary converts PC into a
> > virtual address.
> >
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > Resent with 40x->44x.
> >
> >  arch/powerpc/kernel/process.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 57c589c..6dbde7f 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -354,6 +354,14 @@ static void show_instructions(struct pt_regs *regs)
> >               if (!(i % 8))
> >                       printk("\n");
> >
> > +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_44x)
>
>      Doesn't CONFIG_44x select CONFIG_BOOKE? Maybe you meant CONFIG_40x?

Heeheehee!  That was the *last* version of the patch.  :-)

40x *does* have real mode, so CONFIG_40x is not appropriate here.  As
Kumar mentioned, only CONFIG_BOOKE is needed.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

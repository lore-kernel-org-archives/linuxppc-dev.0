Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z38z03ph7zF0CT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 00:50:20 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id o13so3783933pgp.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 05:50:20 -0800 (PST)
Date: Fri, 22 Dec 2017 23:50:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 3/8] powerpc/64s: put the per-cpu data_offset in r14
Message-ID: <20171222235002.4c80539e@roar.ozlabs.ibm.com>
In-Reply-To: <20171220175324.uidr5ohzqiwsb6hu@lt-gp.iram.es>
References: <20171220145206.12234-1-npiggin@gmail.com>
 <20171220145206.12234-4-npiggin@gmail.com>
 <20171220175324.uidr5ohzqiwsb6hu@lt-gp.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Dec 2017 18:53:24 +0100
Gabriel Paubert <paubert@iram.es> wrote:

> On Thu, Dec 21, 2017 at 12:52:01AM +1000, Nicholas Piggin wrote:
> > Shifted left by 16 bits, so the low 16 bits of r14 remain available.
> > This allows per-cpu pointers to be dereferenced with a single extra
> > shift whereas previously it was a load and add.
> > ---
> >  arch/powerpc/include/asm/paca.h   |  5 +++++
> >  arch/powerpc/include/asm/percpu.h |  2 +-
> >  arch/powerpc/kernel/entry_64.S    |  5 -----
> >  arch/powerpc/kernel/head_64.S     |  5 +----
> >  arch/powerpc/kernel/setup_64.c    | 11 +++++++++--
> >  5 files changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > index cd6a9a010895..4dd4ac69e84f 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -35,6 +35,11 @@
> >  
> >  register struct paca_struct *local_paca asm("r13");
> >  #ifdef CONFIG_PPC_BOOK3S
> > +/*
> > + * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.  
> 
> Top 32, really? It's 48 in later comments.

Yep, I used 32 to start with but it wasn't enough. Will fix.

Thanks,
Nick

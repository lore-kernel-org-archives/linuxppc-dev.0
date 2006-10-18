Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.orange.fr (smtp1.orange.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id EE80667CB5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 16:11:58 +1000 (EST)
Received: from smtp-msa-out01.orange.fr (mwinf0113 [172.22.132.41])
	by mwinf0105.orange.fr (SMTP Server) with ESMTP id 1E2C048011B6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 08:09:20 +0200 (CEST)
Date: Wed, 18 Oct 2006 08:05:48 +0200
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061018060548.GA6633@powerlinux.fr>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4535C0F8.1070905@bplan-gmbh.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2006 at 07:51:52AM +0200, Nicolas DET wrote:
> Christoph Hellwig wrote:
> >> --- a/arch/powerpc/kernel/rtas-proc.c    2006-10-14 
> 05:34:03.000000000 +0200
> >> +++ b/arch/powerpc/kernel/rtas-proc.c    2006-10-16 
> 10:46:16.000000000 +0200
> >> @@ -253,43 +253,70 @@ static void get_location_code(struct seq
> >>  static void check_location_string(struct seq_file *m, char *c);
> >>  static void check_location(struct seq_file *m, char *c);
> >>
> >> +#ifdef CONFIG_PPC64
> >> +#define PROCRTAS_ROOT "ppc64"
> >> +#else
> >> +#define PROCRTAS_ROOT "ppc"
> >
> > Please don't do any pathname changes.  Even if ppc64 isn't correct it's
> > what applications expect and what we should provide for a coherent user
> > interface.
> 
> Humm, ok.
> However, in this case 'ppc' (could be 32 or 64 as it is not specified) 
> is more generic than 'ppc64'.

Christoph, Nicolas, ...

What about doing the logical thing, and switching it to "powerpc" like the
recent arch change, or more logically, to "power" like the current rebranding
of the whole thing ?

I suppose we can also provide some symlinking or similar for compatibility ?
Or move the whole stuff under /sys/.../power/rtas ? 

Friendly,

Sven Luther

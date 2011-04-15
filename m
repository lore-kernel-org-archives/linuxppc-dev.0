Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0852C1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 18:46:12 +1000 (EST)
In-Reply-To: <201104150922.43093.ml@stefan-roese.de>
References: <201104131632.21350.ml@stefan-roese.de>
	<OF71C64301.E54A0A3C-ONC1257872.005BD121-C1257872.005C754F@transmode.se>
	<OFDD77B7E3.D5C79015-ONC1257872.0069E657-C1257872.006A5415@transmode.se>
	<201104150922.43093.ml@stefan-roese.de>
Subject: Re: FTrace on MPC8xx
To: Stefan Roese <ml@stefan-roese.de>
Message-ID: <OFB0C5E010.756D23BE-ONC1257873.003006DB-C1257873.00302A63@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 15 Apr 2011 10:46:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stefan Roese <ml@stefan-roese.de> wrote on 2011/04/15 09:22:42:
> Hi Joakim,
>
> On Thursday 14 April 2011 21:21:23 Joakim Tjernlund wrote:
> > > hmm, I guess 8xx really maps kernel RO as RO :) Try
> > >
> > > changing in pte-8xx.h:
> > >  - #define _PAGE_KERNEL_RO   (_PAGE_SHARED)
> > >  + #define _PAGE_KERNEL_RO   (_PAGE_RW |_PAGE_SHARED)
> >
> > hmm, I wonder if not this is the problem(in pte-common.h)
> > #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) ||
> > defined(CONFIG_BDI_SWITCH) ||\ defined(CONFIG_KPROBES)
> > #define PAGE_KERNEL_TEXT   PAGE_KERNEL_X
> > #else
> > #define PAGE_KERNEL_TEXT   PAGE_KERNEL_ROX
> > #endif
> >
> > What is PAGE_KERNEL_TEXT for you?
> > I think it must be PAGE_KERNEL_X, otherwise kernel text will be readonly.
>
> Yes, that's it! Its PAGE_KERNEL_ROX right now. We need to add CONFIG_FTRACE or
> at least CONFIG_DYNAMIC_FTRACE to the #if statement above.
>
> Do you want to send a patch (since you detected the real problem)? Or should I
> do this?

Feel free to send it. I am barely managing my mail ATM.

 Jocke

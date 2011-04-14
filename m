Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40A8CB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 02:50:01 +1000 (EST)
In-Reply-To: <201104141759.30446.ml@stefan-roese.de>
References: <201104131632.21350.ml@stefan-roese.de>
	<201104131721.34123.ml@stefan-roese.de>
	<OF832AEAAB.68C38F85-ONC1257871.0055965D-C1257871.0055E1C2@transmode.se>
	<201104141759.30446.ml@stefan-roese.de>
Subject: Re: FTrace on MPC8xx
To: Stefan Roese <ml@stefan-roese.de>
Message-ID: <OF71C64301.E54A0A3C-ONC1257872.005BD121-C1257872.005C754F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 14 Apr 2011 18:49:53 +0200
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

Stefan Roese <ml@stefan-roese.de> wrote on 2011/04/14 17:59:30:
>
> Hi Joakim,
>
> On Wednesday 13 April 2011 17:38:03 Joakim Tjernlund wrote:
> > > > How big was the size to copy_tofrom_user()? Did it mange to copy
> > > > any bytes?
> > >
> > > The size in __copy_tofrom_user is 4. And its the first call in
> > > ftrace_modify_code() that fails directly. This works just fine on a
> > > PPC440EPx board.
> >
> > Since the size is only 4 it would not use dcbX anyway(I think).
> > Then is is probably called with the wrong addresses?
>
> No, addresses seem to be correct. I checked a bit further (I'm quite new to
> the MPC8xx MMU) and it seems that trying to modify the code (that's the
> destination address) via __copy_tofrom_user() fails on MPC8xx. Still not sure
> why this is the case. Perhaps an 8xx guru might chime in here. ;)
>
> BTW: I just noticed that enabling CONFIG_PIN_TLB seems to resolve this issue.
> With this option enabled, the dynamic code modification works just fine.
>
> Joakim, Scott? Any ideas on this?

hmm, I guess 8xx really maps kernel RO as RO :) Try
changing in pte-8xx.h:
 - #define _PAGE_KERNEL_RO	(_PAGE_SHARED)
 + #define _PAGE_KERNEL_RO	(_PAGE_RW |_PAGE_SHARED)

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42837B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 01:38:08 +1000 (EST)
In-Reply-To: <201104131721.34123.ml@stefan-roese.de>
References: <201104131632.21350.ml@stefan-roese.de>
	<OF32A80193.EF3E454E-ONC1257871.005204A6-C1257871.00523F24@transmode.se>
	<201104131721.34123.ml@stefan-roese.de>
Subject: Re: FTrace on MPC8xx
To: Stefan Roese <ml@stefan-roese.de>
Message-ID: <OF832AEAAB.68C38F85-ONC1257871.0055965D-C1257871.0055E1C2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 13 Apr 2011 17:38:03 +0200
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

Stefan Roese <ml@stefan-roese.de> wrote on 2011/04/13 17:21:33:
>
> Hi Joakim,
>
> On Wednesday 13 April 2011 16:58:21 Joakim Tjernlund wrote:
> > > This is on a 2.6.38 kernel (2.6.32 fails too). Debugging shows that
> > > __copy_tofrom_user() fails with return code 4 (called via
> > > ftrace_modify_code()).
> > >
> > > Before digging deeper: Has anybody tried/tested ftrace on MPC8xx? Any
> > > ideas what going wrong here?
> >
> > Just an idea, remove the usage of dcbX insn, these has been problematic
> > before.
>
> I originally tested with 2.6.32. Same problem there. And your 8xx patches with
> the dcbX changes are not included in 2.6.32 yet.

OK

>
> > How big was the size to copy_tofrom_user()? Did it mange to copy
> > any bytes?
>
> The size in __copy_tofrom_user is 4. And its the first call in
> ftrace_modify_code() that fails directly. This works just fine on a PPC440EPx
> board.

Since the size is only 4 it would not use dcbX anyway(I think).
Then is is probably called with the wrong addresses?

 Jocke

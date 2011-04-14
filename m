Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FED0B6FC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 01:59:42 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: FTrace on MPC8xx
Date: Thu, 14 Apr 2011 17:59:30 +0200
References: <201104131632.21350.ml@stefan-roese.de>
	<201104131721.34123.ml@stefan-roese.de>
	<OF832AEAAB.68C38F85-ONC1257871.0055965D-C1257871.0055E1C2@transmode.se>
In-Reply-To: <OF832AEAAB.68C38F85-ONC1257871.0055965D-C1257871.0055E1C2@transmode.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104141759.30446.ml@stefan-roese.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joakim,

On Wednesday 13 April 2011 17:38:03 Joakim Tjernlund wrote:
> > > How big was the size to copy_tofrom_user()? Did it mange to copy
> > > any bytes?
> > 
> > The size in __copy_tofrom_user is 4. And its the first call in
> > ftrace_modify_code() that fails directly. This works just fine on a
> > PPC440EPx board.
> 
> Since the size is only 4 it would not use dcbX anyway(I think).
> Then is is probably called with the wrong addresses?

No, addresses seem to be correct. I checked a bit further (I'm quite new to 
the MPC8xx MMU) and it seems that trying to modify the code (that's the 
destination address) via __copy_tofrom_user() fails on MPC8xx. Still not sure 
why this is the case. Perhaps an 8xx guru might chime in here. ;)

BTW: I just noticed that enabling CONFIG_PIN_TLB seems to resolve this issue. 
With this option enabled, the dynamic code modification works just fine.

Joakim, Scott? Any ideas on this?

Thanks,
Stefan

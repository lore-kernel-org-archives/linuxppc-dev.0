Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EACF4B70D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 01:21:43 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: FTrace on MPC8xx
Date: Wed, 13 Apr 2011 17:21:33 +0200
References: <201104131632.21350.ml@stefan-roese.de>
	<OF32A80193.EF3E454E-ONC1257871.005204A6-C1257871.00523F24@transmode.se>
In-Reply-To: <OF32A80193.EF3E454E-ONC1257871.005204A6-C1257871.00523F24@transmode.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104131721.34123.ml@stefan-roese.de>
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

On Wednesday 13 April 2011 16:58:21 Joakim Tjernlund wrote:
> > This is on a 2.6.38 kernel (2.6.32 fails too). Debugging shows that
> > __copy_tofrom_user() fails with return code 4 (called via
> > ftrace_modify_code()).
> > 
> > Before digging deeper: Has anybody tried/tested ftrace on MPC8xx? Any
> > ideas what going wrong here?
> 
> Just an idea, remove the usage of dcbX insn, these has been problematic
> before.

I originally tested with 2.6.32. Same problem there. And your 8xx patches with 
the dcbX changes are not included in 2.6.32 yet.

> How big was the size to copy_tofrom_user()? Did it mange to copy
> any bytes?

The size in __copy_tofrom_user is 4. And its the first call in 
ftrace_modify_code() that fails directly. This works just fine on a PPC440EPx 
board.

Best regards,
Stefan

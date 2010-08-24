Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A1A9B70A5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Aug 2010 15:47:22 +1000 (EST)
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <27922.1282523025@neuling.org>
Date: Tue, 24 Aug 2010 00:47:05 -0500
Message-Id: <DCE42647-5931-41EF-BBE8-F09FDC700143@kernel.crashing.org>
References: <m2hbinzlon.fsf@igel.home> <27922.1282523025@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andreas Schwab <schwab@linux-m68k.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 22, 2010, at 7:23 PM, Michael Neuling wrote:

>> Neither lfs nor stfs touch the fpscr, so remove the restore/save of =
it
>> around them.
>=20
> Do some 32 bit processors need this?=20
>=20
> In 32 bit before the merge, we use to have code that did:
>=20
>  #if defined(CONFIG_4xx) || defined(CONFIG_E500)
>   #define cvt_fd without save/restore fpscr
>  #else
>   #define cvt_fd with save/restore fpscr
>  #end if
>=20
> Kumar; does this ring any bells?
>=20
> (The addition of this predates even bitkeeper)
>=20
> Mikey

Not really.  However if the ifdef is as you say that seems wrong to me.  =
We should be using CONFIG_PPC_FPU or !CONFIG_PPC_FPU.  As both 4xx and =
E500 have variants w/FPUs.

- k=

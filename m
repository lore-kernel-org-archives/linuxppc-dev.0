Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20589B7B84
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 08:43:22 +1100 (EST)
In-Reply-To: <1254778299.7122.39.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005181233.GA3576@loki.buserror.net>
	<OF44D5E829.2889B774-ONC1257646.00645628-C1257646.006568EE@transmode.se>
	<20091005200941.GD3576@loki.buserror.net>	
	<OFFC147C60.2DA4B63D-ONC1257646.00733843-C1257646.0073CFFD@transmode.se>
	<1254778299.7122.39.camel@pasglop>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF17005BC2.01F7F762-ONC1257646.0076C3C3-C1257646.00772EBF@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 5 Oct 2009 23:41:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/10/2009 23:31:39:

> >
> > Yes, every ld.so uses dcbX and icbi insn when relocatin code.
>
> Even with -msecure-plt ?

hmm, maybe not. Can't remember now. But perhaps LAZY relocs still
need dcbX? Easiest is to check in uClibc. I impl. it, but was to long
time ago for me to remember. Scott are you using uClibc? I don't
think so because of the dynamic check of the cache line size

>
> > Maybe you see some version of the dcbX bug, but my fault.c should
> > fix them up. My bet would be the 32 byte cache line, it will miss
> > out every second line and so the results are unreliable.
>
> Cheers,
> Ben.

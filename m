Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96E9FB7BDC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 22:41:52 +1100 (EST)
In-Reply-To: <1254827186.6035.11.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<1254782248.7122.49.camel@pasglop>	
	<OF2DE63E1A.21EA8BF0-ONC1257646.0082A7F0-C1257646.0082E281@transmode.se>
	<1254793935.1959.1.camel@pasglop>	
	<OFAEE03401.0C51FEE2-ONC1257647.002C29FE-C1257647.002C917A@transmode.se>
	<1254817969.6035.4.camel@pasglop>	
	<OF5058A03E.5D586A94-ONC1257647.003C25B0-C1257647.003C5220@transmode.se>
	<1254827186.6035.11.camel@pasglop>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFEF3D58AF.CADDCCC3-ONC1257647.003F713E-C1257647.004013D6@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 13:39:53 +0200
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



Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 13:06:26:

> From:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> To:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se>
>
> Cc:
>
> "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Rex Feany
> <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
>
> Date:
>
> 06/10/2009 13:06
>
> Subject:
>
> Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
>
> On Tue, 2009-10-06 at 12:58 +0200, Joakim Tjernlund wrote:
>
> > Here I don't care if err. insn will be 0 if it fails and the following
> > if will be false
>
> I'd rather you use get_user() so it does access_ok().

It is only debug code so it will go away
The real access is later.

I need do kernel space separately, is there a better way than:

if (regs->nip & 0xc0000000) /* kernel space ? */
	insn = *((unsigned long *)regs->nip);
else if (get_user(insn, (unsigned long *)regs->nip)) {
	printk(KERN_CRIT "get_user! NIP:%lx\n", regs->nip); /* DEBUG */
	goto bad_area_nosemaphore;
}

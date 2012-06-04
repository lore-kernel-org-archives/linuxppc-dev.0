Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31538B6FA5
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2012 19:06:48 +1000 (EST)
In-Reply-To: <1338672076.7150.2.camel@pasglop>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>	
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com> <1338589800.16119.58.camel@pasglop>	
 <4FC9456B.8090400@freescale.com> <1338593099.16119.60.camel@pasglop>
 <OFF2E739FE.A96EBAF2-ONC1257A11.00655546-C1257A11.0065978F@transmode.se>
 <1338672076.7150.2.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF7810EBD9.B191A242-ONC1257A13.0031E9E3-C1257A13.00320D10@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 4 Jun 2012 11:06:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Bob Cochran <ppc@mindchasers.com>, support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/06/02 23:21:16:
>
> On Sat, 2012-06-02 at 20:29 +0200, Joakim Tjernlund wrote:
> >
> > hmm, where does this go w.r.t the patch? Got the feeling that the
> > best thing is to just turn MSR:DE on and be done with it?
>
> Not unconditionally, we need to have a close look, that might be ok
> specifically for BookE 32-bit, it's certainly not ok for BookE 64-bit at
> this point.
>
> For now, I'm ok with a debug CONFIG_* option.
>
> Also do we know if MSR:DE has any performance impact on any CPU ? I know
> having DACs enabled has a major impact on some for example.

I just sent a new patch, named
  [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
which will only add MSR_DE for booke under CONFIG_BDI_SWITCH

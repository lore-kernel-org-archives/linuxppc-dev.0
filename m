Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E10AB7BD2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 21:21:51 +1000 (EST)
In-Reply-To: <20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
References: <1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 30 Sep 2009 13:18:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 30/09/2009 11:00:02:
>
> Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
>
> > > Ok, I have made some minor tweaks and added debug code in
> > > do_page_fault(). Would be great if you could try on both
> > > .31 and top of tree.
> > >
> > >  Jocke
> >
> > OOPS, found a bug. Use this one instead:
>
> .31 - no change, it worked before your patch and it works after.
> None of your debugging printks show up. I tried removing the tlbil_va()
> from do_dcache_icache_coherency() and userspace goes back to be being
> slow/non functional.

Had a look at linus tree and there is something I don't understand.
Your fix, e0908085fc2391c85b85fb814ae1df377c8e0dcb, fixes a problem
that was introduced by 8d30c14cab30d405a05f2aaceda1e9ad57800f36 but
8d30c14cab30d405a05f2aaceda1e9ad57800f36 was included in .31 and .31
works and top of tree does not, how can that be?

To me it seems more likely that some mm change introduced between .31 and
top of tree is the culprit.
My patch addresses the problem described in the comment:
/* On 8xx, cache control instructions (particularly
 * "dcbst" from flush_dcache_icache) fault as write
 * operation if there is an unpopulated TLB entry
 * for the address in question. To workaround that,
 * we invalidate the TLB here, thus avoiding dcbst
 * misbehaviour.
 */
Now you are using this old fix to paper over some other bug or so I think.

 Jocke

Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 401982C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 19:43:20 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
Date: Thu, 6 Jun 2013 09:42:44 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF453564@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370381959.748.16@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF44EB49@039-SN2MPN1-011.039d.mgd.msft.net>
 <1370450103.26139.0@snotra>
In-Reply-To: <1370450103.26139.0@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > This looks like a bit much for 3.10 (certainly, subject lines like
> > > "refactor" and "enhance" and "add support" aren't going to make
> > Linus
> > > happy given that we're past rc4) so I think we should apply
> > > http://patchwork.ozlabs.org/patch/242896/ for 3.10.  Then for 3.11,
> > > revert it after applying this patchset.
> > >
> >
> > Why not 1/6 plus e6500 removal?
>=20
> 1/6 is not a bugfix.

Not sure I get it. Isn't this a better fix for AltiVec build breakage:

-#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 42
-#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 43
+#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 32
+#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 33

This removes the need for additional kvm_handlers. Obvious this doesn't mak=
e
AltiVec to work so we still need to disable e6500.

-Mike

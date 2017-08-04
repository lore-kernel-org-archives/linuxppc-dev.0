Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP9Y734RGzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 01:18:17 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
CC: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, "paulus@samba.org"
 <paulus@samba.org>, "anton@samba.org" <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v9 14/14] powerpc: rewrite local_t using soft_irq
Date: Fri, 4 Aug 2017 15:18:08 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004B4AD@AcuExch.aculab.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1501732158-19009-15-git-send-email-maddy@linux.vnet.ibm.com>
 <20170804035005.1d462325@roar.ozlabs.ibm.com>
 <1501810843.2664.63.camel@kernel.crashing.org>
 <20170804190429.3383e932@roar.ozlabs.ibm.com>
In-Reply-To: <20170804190429.3383e932@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin
> Sent: 04 August 2017 10:04
> On Fri, 04 Aug 2017 11:40:43 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>=20
> > On Fri, 2017-08-04 at 03:50 +1000, Nicholas Piggin wrote:
> > > Hey, so... why are any of these implemented in asm? We should
> > > just do them all in C, right? I looked a bit harder at code gen
> > > and a couple of them are still emitting larx/stcx.
> >
> > As long as we can guarantee that the C compiler won't play games
> > moving stuff around. But yes, I tend to agree.
>=20
>=20
> I believe so. I mean we already depend on the same pattern for any
> other sequence of local_irq_disable(); c code; local_irq_enable();
> so we'd have other problems if we couldn't.

I'd guess that a "memory" clobber on the irq_disable/enable would be enough=
.
It could be restricted to the memory area being updated.

	David

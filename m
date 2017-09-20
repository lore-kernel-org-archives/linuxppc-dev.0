Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwP029XxzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:05:54 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Simon Guo' <wei.guo.simon@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Naveen
 N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: RE: [PATCH v1 1/3] powerpc: Align bytes before fall back to .Lshort
 in powerpc memcmp
Date: Wed, 20 Sep 2017 10:05:49 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD007B037@AcuExch.aculab.com>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
 <1505815439-18720-2-git-send-email-wei.guo.simon@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0079D63@AcuExch.aculab.com>
 <20170920095635.GA3387@simonLocalRHEL7.x64>
In-Reply-To: <20170920095635.GA3387@simonLocalRHEL7.x64>
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

From: Simon Guo
> Sent: 20 September 2017 10:57
> On Tue, Sep 19, 2017 at 10:12:50AM +0000, David Laight wrote:
> > From: wei.guo.simon@gmail.com
> > > Sent: 19 September 2017 11:04
> > > Currently memcmp() in powerpc will fall back to .Lshort (compare per =
byte
> > > mode) if either src or dst address is not 8 bytes aligned. It can be
> > > opmitized if both addresses are with the same offset with 8 bytes bou=
ndary.
> > >
> > > memcmp() can align the src/dst address with 8 bytes firstly and then
> > > compare with .Llong mode.
> >
> > Why not mask both addresses with ~7 and mask/shift the read value to ig=
nore
> > the unwanted high (BE) or low (LE) bits.
> >
> > The same can be done at the end of the compare with any final, partial =
word.
>=20
> Yes. That will be better. A prototyping shows ~5% improvement on 32 bytes
> size comparison with v1. I will rework on v2.

Clearly you have to be careful to return the correct +1/-1 on mismatch.

For systems that can do misaligned transfers you can compare the first
word, then compare aligned words and finally the last word.
Rather like a memcpy() function I wrote (for NetBDSD) that copied
the last word first, then a whole number of words aligned at the start.
(Hope no one expected anything special for overlapping copies.)

	David

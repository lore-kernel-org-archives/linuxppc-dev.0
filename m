Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 362FD2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 02:48:39 +1000 (EST)
Date: Mon, 8 Jul 2013 11:48:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
References: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com>
 <1372804758.8183.124@snotra>
 <20130703030044.GA25190@pek-khao-d1.corp.ad.wrs.com>
 <1372883907.8183.151@snotra>
 <20130704010818.GA16188@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130704010818.GA16188@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Wed Jul  3 20:08:18 2013)
Message-ID: <1373302105.8183.160@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 08:08:18 PM, Kevin Hao wrote:
> On Wed, Jul 03, 2013 at 03:38:27PM -0500, Scott Wood wrote:
> > On 07/02/2013 10:00:44 PM, Kevin Hao wrote:
> > >On Tue, Jul 02, 2013 at 05:39:18PM -0500, Scott Wood wrote:
> > >> How much overhead (space and time) is this really?
> > >
> > >The following is the additional sections when relocatable is
> > >enabled for
> > >a p2020rdb board.
> > >   section        size
> > >  .dynsym       000007f0
> > >  .dynstr       00000926
> > >  .dynamic      00000080
> > >  .hash         00000388
> > >  .interp       00000011
> > >  .rela.dyn     00215250
> > >
> > >The time for the relocation is about 32ms on a p2020rdb board.
> >
> > Hmm... more relocations than I expected.  What percentage is this of
> > the total image size?
>=20
> The size of vmlinux.bin is about 10M. The percentage of the relocation
> section is about 20%. But look on the bright side of thing, all the =20
> relocation
> stuff are in init section and should be discarded at runtime. :-)

That doesn't reduce the space it takes up in flash...

-Scott=

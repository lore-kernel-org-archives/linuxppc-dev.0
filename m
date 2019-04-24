Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406DBC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:02:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B359A20878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="V3ha/97I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7KwA4yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B359A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prpy5BFgzDqVD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:02:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="V3ha/97I"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="E7KwA4yt"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44prn31P26zDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 17:00:38 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id EAB3345E;
 Wed, 24 Apr 2019 03:00:35 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute6.internal (MEProxy); Wed, 24 Apr 2019 03:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=93IpX
 DcvugQQzamWYmE7n6PwihV80dgPedkCALr/zM8=; b=V3ha/97ICAx0ei1+LML2T
 QlJ/fYXHAr3FRPY8pCvu5y/FIsdTQMnukhyv5IsjXGWJX1YaoOLMJWw3p6mFvopt
 C04abcKrB84ViI8Q9TV98CirxUP0Epwz/urOFHy3EnRtsuaRTnchB8KMLRrkz1xr
 ZHYHwsDd9x/vAHhj/kgLgUM2glwJ04LMj4s+mgjaldUGGOEgRH/wgrK9x+6L68KL
 9ktQ8kUqWBzoOlZI1SBmB/NAi2RHj3iyionmKlHj35PYk649toQy70mZvC7q8bF5
 KtSt2+ImjN704KCnQlArWCNvGWL9W8XoDz9uLyRxD5mSQGbIy2D4+vbnF2n9JALx
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=93IpXDcvugQQzamWYmE7n6PwihV80dgPedkCALr/z
 M8=; b=E7KwA4ytrbfraShrk3bcNFOVocvh/VWL/UEHQGjjUATSmKpGr7swm6A11
 8S+HUMJWQ/4ZTHDZfbiUYCj2kruObpn9odVmSudX3qJ14ccHBohMTBnUSQoKP2pP
 zOqAMdrAze1aARQ207NdRKsWy9ICyku95lqVW1nVKYPeW2GeGvP/Tc4Xnh445UHr
 VbOZFJkQetiabWexrZItUDhD+8QX7h2RiINXu+sKNqHRi1WoZxbdO+LnOGeDEK5g
 46QROrgyLmb0yiwPqeltt+TaT4EmeXGiNon2nCXFOZmhdhyzZiz0+ZFz1yDC92te
 HBe5lNO2lWziBxF0vHTwyzzYBKrXw==
X-ME-Sender: <xms:kgnAXDRLJ8gNp4xEYqOhs-DW7gh-bw6uemioQuP-DBbYrMDREX7WAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeelgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredt
 reerjeenucfhrhhomhepfdftuhhsshgvlhhlucevuhhrrhgvhidfuceorhhushgtuhhrse
 hruhhsshgvlhhlrdgttgeqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhes
 rhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kgnAXNsWOPYAXcRvqs-hhg0pu0xKNEonnymgkUScnBuaKlrvzJUGbg>
 <xmx:kgnAXEbFh4y4oTv_gJNBufdTjVPNGerdz9O0BLtX6fBhfGlmjeYVfw>
 <xmx:kgnAXDEkBVm7CM06ML9ksipu13J43l4hOqj1G5R4TycoND1Wno6geQ>
 <xmx:kwnAXL7zKiAoQsT7wD3akGTCvKqTGrVFxrdoDHuFpYKlBIdO6W-wQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8D44872C4D; Wed, 24 Apr 2019 03:00:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-444-g755619f-fmstable-20190423v1
Mime-Version: 1.0
Message-Id: <e867dde6-ec13-4a3f-aa66-9819066dcb80@www.fastmail.com>
In-Reply-To: <ab20f079-cf9f-f1c6-f3fa-54a842311fd3@c-s.fr>
References: <20190424063958.24559-1-ruscur@russell.cc>
 <ab20f079-cf9f-f1c6-f3fa-54a842311fd3@c-s.fr>
Date: Wed, 24 Apr 2019 03:00:33 -0400
From: "Russell Currey" <ruscur@russell.cc>
To: "Christophe Leroy" <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_powerpc/mm/ptdump:_Wrap_seq=5Fprintf()_to_hand?=
 =?UTF-8?Q?le_NULL_pointers?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Julia.Lawall@lip6.fr, rashmica.g@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

whoops, will fix=20

--=20
  Russell Currey
  ruscur@russell.cc

On Wed, Apr 24, 2019, at 4:56 PM, Christophe Leroy wrote:
>=20
>=20
> Le 24/04/2019 =C3=A0 08:39, Russell Currey a =C3=A9crit=C2=A0:
> > Lovingly borrowed from the arch/arm64 ptdump code.
> >=20
> > This doesn't seem to be an issue in practice, but is necessary for m=
y
> > upcoming commit.
> >=20
> > Converts a putc() into a puts().
> >=20
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> >   arch/powerpc/mm/ptdump/ptdump.c | 32 ++++++++++++++++++++++-------=
---
> >   1 file changed, 22 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdum=
p/ptdump.c
> > index 37138428ab55..c50cb7faa334 100644
> > --- a/arch/powerpc/mm/ptdump/ptdump.c
> > +++ b/arch/powerpc/mm/ptdump/ptdump.c
> > @@ -104,6 +104,18 @@ static struct addr_marker address_markers[] =3D=
 {
> >   	{ -1,	NULL },
> >   };
> >  =20
> > +#define pt_dump_seq_printf(m, fmt, args...)	\
> > +({						\
> > +	if (m)					\
> > +		seq_printf(m, fmt, ##args);	\
> > +})
> > +
> > +#define pt_dump_seq_puts(m, fmt)	\
> > +({					\
> > +	if (m)				\
> > +		seq_printf(m, fmt);	\
>=20
> Why not use seq_puts() here ?
>=20
> Christophe
>=20
> > +})
> > +
> >   static void dump_flag_info(struct pg_state *st, const struct flag_=
info
> >   		*flag, u64 pte, int num)
> >   {
> > @@ -121,19 +133,19 @@ static void dump_flag_info(struct pg_state *st=
, const struct flag_info
> >   			val =3D pte & flag->val;
> >   			if (flag->shift)
> >   				val =3D val >> flag->shift;
> > -			seq_printf(st->seq, "  %s:%llx", flag->set, val);
> > +			pt_dump_seq_printf(st->seq, "  %s:%llx", flag->set, val);
> >   		} else {
> >   			if ((pte & flag->mask) =3D=3D flag->val)
> >   				s =3D flag->set;
> >   			else
> >   				s =3D flag->clear;
> >   			if (s)
> > -				seq_printf(st->seq, "  %s", s);
> > +				pt_dump_seq_printf(st->seq, "  %s", s);
> >   		}
> >   		st->current_flags &=3D ~flag->mask;
> >   	}
> >   	if (st->current_flags !=3D 0)
> > -		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
> > +		pt_dump_seq_printf(st->seq, "  unknown flags:%llx", st->current_f=
lags);
> >   }
> >  =20
> >   static void dump_addr(struct pg_state *st, unsigned long addr)
> > @@ -148,12 +160,12 @@ static void dump_addr(struct pg_state *st, uns=
igned long addr)
> >   #define REG		"0x%08lx"
> >   #endif
> >  =20
> > -	seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);=

> > +	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, ad=
dr - 1);
> >   	if (st->start_pa =3D=3D st->last_pa && st->start_address + PAGE_S=
IZE !=3D addr) {
> > -		seq_printf(st->seq, "[" REG "]", st->start_pa);
> > +		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
> >   		delta =3D PAGE_SIZE >> 10;
> >   	} else {
> > -		seq_printf(st->seq, " " REG " ", st->start_pa);
> > +		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
> >   		delta =3D (addr - st->start_address) >> 10;
> >   	}
> >   	/* Work out what appropriate unit to use */
> > @@ -161,7 +173,7 @@ static void dump_addr(struct pg_state *st, unsig=
ned long addr)
> >   		delta >>=3D 10;
> >   		unit++;
> >   	}
> > -	seq_printf(st->seq, "%9lu%c", delta, *unit);
> > +	pt_dump_seq_printf(st->seq, "%9lu%c", delta, *unit);
> >  =20
> >   }
> >  =20
> > @@ -178,7 +190,7 @@ static void note_page(struct pg_state *st, unsig=
ned long addr,
> >   		st->start_address =3D addr;
> >   		st->start_pa =3D pa;
> >   		st->last_pa =3D pa;
> > -		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> > +		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> >   	/*
> >   	 * Dump the section of virtual memory when:
> >   	 *   - the PTE flags from one entry to the next differs.
> > @@ -202,7 +214,7 @@ static void note_page(struct pg_state *st, unsig=
ned long addr,
> >   					  st->current_flags,
> >   					  pg_level[st->level].num);
> >  =20
> > -			seq_putc(st->seq, '\n');
> > +			pt_dump_seq_puts(st->seq, "\n");
> >   		}
> >  =20
> >   		/*
> > @@ -211,7 +223,7 @@ static void note_page(struct pg_state *st, unsig=
ned long addr,
> >   		 */
> >   		while (addr >=3D st->marker[1].start_address) {
> >   			st->marker++;
> > -			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> > +			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);=

> >   		}
> >   		st->start_address =3D addr;
> >   		st->start_pa =3D pa;
> >=20
>

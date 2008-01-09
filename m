Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A9E54DDF50
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 21:01:40 +1100 (EST)
Date: Wed, 9 Jan 2008 11:01:38 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 2/4 v2] PS3: Add logical performance monitor repository
	routines
In-Reply-To: <20080109181501.334e98c8.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0801091100470.1492@vixen.sonytel.be>
References: <477EF59C.2070809@am.sony.com> <47846B38.7010409@am.sony.com>
	<20080109181501.334e98c8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1247821799-1199872898=:1492"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1247821799-1199872898=:1492
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jan 2008, Stephen Rothwell wrote:
> On Tue, 08 Jan 2008 22:35:36 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> >
> > +int ps3_repository_read_num_pu(unsigned int *num_pu)
> > +{
> > +	int result;
> > +	u64 v1;
> > +
> > +	v1 = 0;
> > +	result = read_node(PS3_LPAR_ID_CURRENT,
> > +			   make_first_field("bi", 0),
> > +			   make_field("pun", 0),
> > +			   0, 0,
> > +			   &v1, NULL);
> > +	*num_pu = v1;
> 
> Why not just pass "num_pu" instead of &v1 to read_node()?

We need a temporary because num_pu and v1 differ in size.
The alternative is to make num_pu u64.

> > +int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id)
> > +{
> > +	int result;
> > +	u64 v1;
> > +
> > +	v1 = 0;
> > +	result = read_node(PS3_LPAR_ID_CURRENT,
> > +		make_first_field("bi", 0),
> > +		make_field("pu", pu_index),
> > +		0, 0,
> > +		&v1, NULL);
> > +	*pu_id = v1;
> 
> Similarly with "pu_id"?

Yep, here we don't need the temporary.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-1247821799-1199872898=:1492--

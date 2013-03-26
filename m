Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9BC42C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:36:16 +1100 (EST)
Received: from mail225-tx2 (localhost [127.0.0.1])	by
 mail225-tx2-R.bigfish.com (Postfix) with ESMTP id 05496A00303	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 17:36:12 +0000 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.234])	by
 mail225-tx2.bigfish.com (Postfix) with ESMTP id F19C4900080	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 17:35:48 +0000 (UTC)
Date: Tue, 26 Mar 2013 12:35:42 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB854F@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363990268.24790.11@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBA9F7@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EBA9F7@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Mon Mar 25 22:27:24 2013)
Message-ID: <1364319342.469.7@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2013 10:27:24 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 23, 2013 6:11 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Zhao Chenhui-B35336; Li Yang-R58472
> > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> >
> > On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, March 21, 2013 5:49 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Zhao Chenhui-B35336; Li Yang-R58472
> > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup =20
> support
> > > >
> > > > On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
> > > > > 	while (*s) {
> > > > > 		if ('0' <=3D *s && *s <=3D '9')
> > > > > 			val =3D *s - '0';
> > > > > 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D =20
> 'f')
> > > > > 			val =3D _tolower(*s) - 'a' + 10;
> > > > > 		else
> > > > > 			break;	//this will break out to =20
> convert.
> > > >
> > > > Really?  How do you know that the next byte after the buffer =20
> isn't a
> > > > valid hex digit?  How do you even know that we won't take a =20
> fault
> > > > accessing it?
> > > >
> > > Under what case is unsafe, please make sense.
> >
> > char buffer[1] =3D { '5' };
> > write(fd, &buffer, 1);
> >
> > What comes after that '5' byte in the pointer you pass to kstrtol?
> >
> The buffer is userspace. It will fall in the kernel space.
> Kernel will get a free page, and copy the buffer to page.
> This page has been cleared before copy to page.
> The page has already have null-terminated.

It doesn't allocate a whole page, it uses kmalloc (not kzalloc!).  Even =20
if kzalloc were used, a larger user buffer could be the exact size of =20
the region that was allocated.

See memdup_user() in mm/util.c

-Scott=

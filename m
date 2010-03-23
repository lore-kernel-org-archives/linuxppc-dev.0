Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.17.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1DD7B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 19:18:05 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id o2N8HxgB031645
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2010 08:17:59 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o2N8HxNo1626310
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2010 09:17:59 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o2N8Hx6m000415
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2010 09:17:59 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: Virtio_console usage of early printk
Date: Tue, 23 Mar 2010 09:17:58 +0100
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
	<20100323021620.GA4088@amit-x200.redhat.com>
In-Reply-To: <20100323021620.GA4088@amit-x200.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201003230917.58142.borntraeger@de.ibm.com>
Cc: =?iso-8859-1?q?Fran=E7ois_Diakhate?= <fdiakh@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag 23 M=E4rz 2010 03:16:20 schrieb Amit Shah:
> On (Mon) Mar 22 2010 [18:45:47], Fran=E7ois Diakhate wrote:
> > the console. Does the attached patch seem valid ? Feedback from s390
> > and powerpc users who use this functionality would be appreciated.
>=20
> Looks OK to me, Christian, others, could you comment on this please?

Looks good and boot tested with kuli on s390.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> > From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
> > From: =3D?utf-8?q?Fran=3DC3=3DA7ois=3D20Diakhat=3DC3=3DA9?=3D <fdiakh@g=
mail.com>
> > Date: Thu, 18 Mar 2010 14:48:20 +0100
> > Subject: virtio: console: Fix early_put_chars usage
> >=20
> > Currently early_put_chars is not used by virtio_console because it can =
only be used once a port has been found, at which point it's too late becau=
se it is no longer needed. This patch should fix it.
> > ---
> >  drivers/char/virtio_console.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_consol=
e.c
> > index f404ccf..691ba21 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -645,13 +645,13 @@ static int put_chars(u32 vtermno, const char *buf=
, int count)
> >  {
> >  	struct port *port;
> > =20
> > +	if (unlikely(early_put_chars))
> > +		return early_put_chars(vtermno, buf, count);
> > +
> >  	port =3D find_port_by_vtermno(vtermno);
> >  	if (!port)
> >  		return 0;
> > =20
> > -	if (unlikely(early_put_chars))
> > -		return early_put_chars(vtermno, buf, count);
> > -
> >  	return send_buf(port, (void *)buf, count);
> >  }

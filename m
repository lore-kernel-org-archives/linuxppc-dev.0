Return-Path: <linuxppc-dev+bounces-19173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B383B10F6FDC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 17:15:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmBTT0HRBz2yjV;
	Thu, 02 Apr 2026 04:15:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775063756;
	cv=none; b=Lo8hZRPiK5Y0UjEoznskj0m1q0Yk6eHWccN5drF0TvCZsz9aYakRkl63NHMawDz1OEUJMAutCP/2PcdoPNgSVK9YmybBrBKiKf9VuXaviI4OBc5Q1roc8iWtKa8+Ri6z/qd5I+2nVOLAnfDFVgsfBiJ1/MCGqyujdCfzsoYIYMKDwWqGNjfRFqG6O9egGKIQAvEHhoFJbhhD3wHTrhmbTcG1Ibrew3sQYr26JCg/wnIT6xlyCc9mB0KXXqvCf5+wZw40sPA4xicJ6q51Y2Xc7DxIfaK93a5fXrjd6enKb2snpuDm8b60K7qcW8x5MLFnHQR9Lajv3H/+Pzxg+UNYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775063756; c=relaxed/relaxed;
	bh=n9US1j1IVCS91e5Cl5sIb3Rl2HF6TolH+vsF4IESVi8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KX+tAUZmw+he8JyHfATUJYCFIMs+7tf7aB1lSUFN862zditlOThybqYU7tIto4aMej3jItdXQNfh0KHDeZwbBR4hPi4K3clu+FnM1S/JyGV7CBCEq02tPKpwtKoxhUdSWwdYTu4Pjh+9aK9Vc/0WwROPgjRuXJs4hAEHpPDHuoxzJX7yyf3Lgzd57vVeKQTvJq2OBX5Mp2yx276iUDB2Fs2yGtdq2Dou9fnmc3WfAayCAMW0u2VcXS0EPwzJ8mB8BNMmBY80a5Lqg5HuCUbzCKYw+tRgYxoX952j6LLCBbUFZPt8eUxM3fKY6K5MhgoZeSld0OZBiMSx1Amfp0j7eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=XylVLZKM; dkim-atps=neutral; spf=pass (client-ip=195.121.94.186; helo=ewsoutbound.kpnmail.nl; envelope-from=jkoolstra@xs4all.nl; receiver=lists.ozlabs.org) smtp.mailfrom=xs4all.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=XylVLZKM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xs4all.nl (client-ip=195.121.94.186; helo=ewsoutbound.kpnmail.nl; envelope-from=jkoolstra@xs4all.nl; receiver=lists.ozlabs.org)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmBTP5XYhz2yj3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 04:15:51 +1100 (AEDT)
X-KPN-MessageId: 366165f0-2dee-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 366165f0-2dee-11f1-89dd-00505699b430;
	Wed, 01 Apr 2026 19:14:16 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 365f816b-2dee-11f1-b5d0-0050569981f5;
	Wed, 01 Apr 2026 19:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=n9US1j1IVCS91e5Cl5sIb3Rl2HF6TolH+vsF4IESVi8=;
	b=XylVLZKMIPnLfWB2TQL/3KZFqNmoB8DxK1kZkBquxMh1gVmu8pPg0RoOq7nuc2L9k5V7zIwI85T9b
	 yG4O5NtzFu78xbNiJ88FDj5d77cXLjzVeEb3ZJmXQpb2n4B85GqkOsHWmgAsxeK2jH6n1rMdIFdm/X
	 idarjagbgWDkezbQ4WUW7Hlx9na+LGVuY4tPurZUqzbyuAe0Z9eJgQTqpcjH6nXfO7ieRpYiZlZEjw
	 wgoO4tKKU0av9EofhxXOeuXzPTrqctUoLSM+djdgnpvOENX1vj2Gt/F18XbKmj32JK2/M/pg5uitIR
	 pVfKms0Ea/+YCFlS1t9BncHD385V5Kg==
X-KPN-MID: 33|AIPn+MI72JeaeDkiPm/RP48qArZ3z1MY4GnBmfAp1JtN5dwVmsrRzoY0WZo+z5j
 yWNPtvknkYXBq6MZphO9Pl6YYcsjKT/7WdTNstd3+UFY=
X-CMASSUN: 33|nynSNPkNZAQIr0GpcmfjY1RjB+vhQ7WInhGboLItIIImqVWytKfRF4ka1TFJF83
 cJyFbJuYZ+9HXlDj26QR5Zw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3653098c-2dee-11f1-94b1-00505699eff2;
	Wed, 01 Apr 2026 19:14:16 +0200 (CEST)
Date: Wed, 1 Apr 2026 19:14:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Haren Myneni <haren@linux.ibm.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Jonathan Greental <yonatan02greental@gmail.com>,
	Kees Cook <kees@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <1967941740.854847.1775063656203@kpc.webmail.kpnmail.nl>
In-Reply-To: <b0a99a20f5f56ad8291d91b209d8ad5f7515bb23.camel@linux.ibm.com>
References: <20260308214634.1215051-1-jkoolstra@xs4all.nl>
 <2026030924-penniless-hermit-ffc0@gregkh>
 <1304966204.915283.1773053337271@kpc.webmail.kpnmail.nl>
 <2026031154-labored-frivolous-154b@gregkh>
 <b0a99a20f5f56ad8291d91b209d8ad5f7515bb23.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc: vas-api: constify dynamic struct class in
 coproc api register
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Originating-IP: 178.227.141.37

Hi Haren,

> Op 12-03-2026 00:27 CET schreef Haren Myneni <haren@linux.ibm.com>:
>=20
> =20
> On Wed, 2026-03-11 at 09:23 +0100, Greg KH wrote:
> > On Mon, Mar 09, 2026 at 11:48:57AM +0100, Jori Koolstra wrote:
> > > My bad, the earlier email went out to soon.
> > >=20
> > > > Op 09-03-2026 07:01 CET schreef Greg KH
> > > > <gregkh@linuxfoundation.org>:
> > > > > =C2=A0arch/powerpc/platforms/book3s/vas-api.c | 34
> > > > > +++++++++++++++++++------
> > > > > =C2=A01 file changed, 26 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/powerpc/platforms/book3s/vas-api.c
> > > > > b/arch/powerpc/platforms/book3s/vas-api.c
> > > > > index ea4ffa63f043..e377981fd533 100644
> > > > > --- a/arch/powerpc/platforms/book3s/vas-api.c
> > > > > +++ b/arch/powerpc/platforms/book3s/vas-api.c
> > > > > @@ -45,7 +45,7 @@ static struct coproc_dev {
> > > > > =C2=A0=09struct device *device;
> > > > > =C2=A0=09char *name;
> > > > > =C2=A0=09dev_t devt;
> > > > > -=09struct class *class;
> > > > > +=09const struct class *class;
> > > > > =C2=A0=09enum vas_cop_type cop_type;
> > > > > =C2=A0=09const struct vas_user_win_ops *vops;
> > > > > =C2=A0} coproc_device;
> > > > > @@ -599,6 +599,21 @@ static struct file_operations coproc_fops
> > > > > =3D {
> > > > > =C2=A0=09.unlocked_ioctl =3D coproc_ioctl,
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > +static const struct class nx_gzip_class =3D {
> > > > > +=09.name=09=09=3D "nx-gzip",
> > > > > +=09.devnode=09=3D coproc_devnode
> > > > > +};
> > > > > +
> > > > > +static const struct class* cop_to_class(enum vas_cop_type cop)
> > > > > +{
> > > > > +=09switch (cop) {
> > > > > +=09case VAS_COP_TYPE_GZIP:=09=09return
> > > > > &nx_gzip_class;
> > > > > +=09default:
> > > > > +=09=09pr_err("No device class defined for cop type
> > > > > %d\n", cop);
> > > > > +=09=09return NULL;
> > > > > +=09}
> > > > > +}
> > > > > +
> > > > > =C2=A0/*
> > > > > =C2=A0 * Supporting only nx-gzip coprocessor type now, but this A=
PI
> > > > > code
> > > > > =C2=A0 * extended to other coprocessor types later.
> > > > > @@ -609,6 +624,10 @@ int vas_register_coproc_api(struct module
> > > > > *mod, enum vas_cop_type cop_type,
> > > > > =C2=A0{
> > > > > =C2=A0=09int rc =3D -EINVAL;
> > > > > =C2=A0=09dev_t devno;
> > > > > +=09const struct class* class =3D cop_to_class(cop_type);
> > > > > +
> > > > > +=09if (!class)
> > > > > +=09=09return rc;
> > > >=20
> > > > How can this happen?
> > > >=20
> > > > This feels odd, are different types of devices being registered
> > > > here?=C2=A0 I
> > > > don't see where VAS_COP_TYPE_GZIP was being tested in the
> > > > original code,
> > > > why add this additional logic?
> > > >=20
> > >=20
> > > My line of thought is this:
> > >=20
> > > There is a function vas_register_coproc_api() that does some kind
> > > of registering
> > > for different coprocessor types. It has the following comment
> > > above:
> > >=20
> > > /*
> > > =C2=A0* Supporting only nx-gzip coprocessor type now, but this API co=
de
> > > =C2=A0* extended to other coprocessor types later.
> > > =C2=A0*/
> >=20
> > I guess "later" never happened :(
>=20
> Yes, VAS is virtual accelerator switchboard which can support multiple
> accelerator types. Hence added vas_register_api* interface for
> different accelerators.=C2=A0But no plans to add other accelerators on
> powerpc right now. So can we use only VAS_COP_TYPE_GZIP class and can
> visit later.=20
>=20

Are you OK with the way

   static const struct class* cop_to_class(enum vas_cop_type cop)

is used to connect the vas_cop_type to the proper device class? Or would yo=
u
prefer a different solution?

Thanks,
Jori.


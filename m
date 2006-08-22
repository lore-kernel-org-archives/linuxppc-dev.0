Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D75967C30
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 00:31:20 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7MEVFvF147430
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 14:31:15 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7MEZGpQ139960
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 16:35:16 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7MEVE8x023544
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 16:31:14 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Tue, 22 Aug 2006 15:51:07 +0200
References: <200608221453.49667.ossthema@de.ibm.com>
	<200608221601.24882.arnd.bergmann@de.ibm.com>
In-Reply-To: <200608221601.24882.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608221551.08406.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tuesday 22 August 2006 16:01, Arnd Bergmann wrote:
> > +=A0=A0=A0=A0=A0=A0=A0u64 rpage =3D 0;
> > +=A0=A0=A0=A0=A0=A0=A0int ret;
> > +=A0=A0=A0=A0=A0=A0=A0int cnt =3D 0;
> > +=A0=A0=A0=A0=A0=A0=A0void *vpage =3D NULL;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0ret =3D hw_queue_ctor(hw_queue, nr_pages, EHEA_PA=
GESIZE, wqe_size);
> > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (cnt =3D 0; cnt < nr_pages; cnt++) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0vpage =3D hw_qpageit_get_=
inc(hw_queue);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!vpage) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
hea_error("hw_qpageit_get_inc failed");
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto qp_alloc_register_exit0;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rpage =3D virt_to_abs(vpa=
ge);
>=20
> As someone mentioned before, the initialization to 0 or NULL
> is pointless here, as the variables are always assigned before
> they are used. There are a number of other places in your
> code that do similar things, you should probably go through
> these and remove the initializers.
>=20
> If you indeed need something to be initialized, it is good practice
> to do the initialization as late as possible, e.g.
>=20
> 	int foo;
> 	...
> 	foo =3D 0;
> 	do_foo(foo);
>=20
> to make it clear that you have a reason to initialize it.
>=20
> 	Arnd <><
>=20

Agreed. We started to remove some but apparrently not all.
We'll go through the code and remove them where possible.

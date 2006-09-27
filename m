Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DFA5F67B61
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 22:02:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k8RCFEJp007084
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 05:15:14 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8RC2IiU027311
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 07:02:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 27 Sep 2006 20:02:56 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Wednesday, September 27, 2006 7:56 PM
> To: Paul Mackerras
> Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
>=20
> On Wed, 27 Sep 2006 16:39:11 +1000
> Paul Mackerras <paulus@samba.org> wrote:
>=20
> > Li Yang writes:
> >
> > > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > > +#define BCSR_SIZE		((uint)(32 * 1024))
> >
> > This sort of thing should really be in the device tree.
> >
> Just a suggestion, but for the similar aim in pq2 I have those stuff
in memory node :
>=20
> +memory {
> +               device_type =3D "memory";
> +               linux,phandle =3D <300>;
> +               reg =3D <00000000 4000000 f4500000 00000020>;
> +       };
> the second pair is about bcsr and its size.
>=20
> Just in case this may help (and wondering if I'm not violating
something :) )

Well, this can make it work.  But I would prefer to use a new node
because the BCSR is by no means a memory type of device.  I have made my
change to use node like this:

        bcsr@f8000000 {
                device_type =3D "board-control";
                reg =3D <f8000000 8000>;
        };

- Leo

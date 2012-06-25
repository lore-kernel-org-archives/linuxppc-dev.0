Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 117B6B6FAF
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 17:06:24 +1000 (EST)
Message-ID: <1340607965.5461.40.camel@thor.local>
Subject: Re: [PATCH] bluetooth: opcode field of sent commands is little endian.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 25 Jun 2012 09:06:05 +0200
In-Reply-To: <1340607113.29898.3.camel@aeonflux>
References: <1340606319-32187-1-git-send-email-michel@daenzer.net>
 <1340607113.29898.3.camel@aeonflux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Son, 2012-06-24 at 23:51 -0700, Marcel Holtmann wrote:=20
> Hi Michel,
>=20
> > Fixes built-in Bluetooth not working on Apple PowerBooks, regression fr=
om
> > commit 75fb0e324daa48ec458fb5c2960eb07b80cfad9d ('Bluetooth: Fix init s=
equence
> > for some CSR based controllers').
> >=20
> > Cc: stable@vger.kernel.org [v3.4]
> > Signed-off-by: Michel D=E4nzer <michel@daenzer.net>
> > ---
> >  net/bluetooth/hci_core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index d6dc44c..e039e3d 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -92,7 +92,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd=
, int result)
> >  		 * command.
> >  		 */
> > =20
> > -		if (cmd !=3D HCI_OP_RESET || sent->opcode =3D=3D HCI_OP_RESET)
> > +		if (cmd !=3D HCI_OP_RESET || sent->opcode =3D=3D cpu_to_le16(HCI_OP_=
RESET))
> >  			return;
>=20
> actually you could use __constant_cpu_to_le16() here.

Yes, but I checked and that's not used anywhere in the bluetooth code
yet, so I thought I'd stay consistent for now.


> That said, this got actually fixed differently upstream. So I prefer if
> that patch gets merged into stable and not this one.
>=20
> commit 1036b89042df96e71c0cb941be212f8053ecccc0
> Author: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Date:   Mon Mar 12 15:59:33 2012 +0200
>=20
>     Bluetooth: Fix opcode access in hci_complete

Fine with me, though FWIW that not only doesn't use
__constant_cpu_to_le16() but actually swaps the non-constant value.

Also, it would have been nice if that fix was promoted to stable, so I
wouldn't have had to spend a good part of the weekend bisecting...


> In general patches need to get into Linus' tree first before you can
> even request them for stable.

I know, that's why I only put the stable tag in commit logs but don't
submit patches there via e-mail.


--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer

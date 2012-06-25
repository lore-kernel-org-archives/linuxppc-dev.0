Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 7017DB6FC3
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 17:33:09 +1000 (EST)
Message-ID: <1340609570.5461.50.camel@thor.local>
Subject: Re: [PATCH] bluetooth: opcode field of sent commands is little endian.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 25 Jun 2012 09:32:50 +0200
In-Reply-To: <1340608972.29898.13.camel@aeonflux>
References: <1340606319-32187-1-git-send-email-michel@daenzer.net>
 <1340607113.29898.3.camel@aeonflux> <1340607965.5461.40.camel@thor.local>
 <1340608972.29898.13.camel@aeonflux>
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

On Mon, 2012-06-25 at 00:22 -0700, Marcel Holtmann wrote:=20
> Hi Michel,
>=20
> > > > Fixes built-in Bluetooth not working on Apple PowerBooks, regressio=
n from
> > > > commit 75fb0e324daa48ec458fb5c2960eb07b80cfad9d ('Bluetooth: Fix in=
it sequence
> > > > for some CSR based controllers').
> > > >=20
> > > > Cc: stable@vger.kernel.org [v3.4]
> > > > Signed-off-by: Michel D=E4nzer <michel@daenzer.net>
> > > > ---
> > > >  net/bluetooth/hci_core.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index d6dc44c..e039e3d 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -92,7 +92,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16=
 cmd, int result)
> > > >  		 * command.
> > > >  		 */
> > > > =20
> > > > -		if (cmd !=3D HCI_OP_RESET || sent->opcode =3D=3D HCI_OP_RESET)
> > > > +		if (cmd !=3D HCI_OP_RESET || sent->opcode =3D=3D cpu_to_le16(HCI=
_OP_RESET))
> > > >  			return;
> > >=20
> > > actually you could use __constant_cpu_to_le16() here.
> >=20
> > Yes, but I checked and that's not used anywhere in the bluetooth code
> > yet, so I thought I'd stay consistent for now.
>=20
> not sure what code you are looking at, but I count 18 occurrences and we
> have been fixing the ones we missed initially.

Okay, good then. As you probably noticed from the rest of my posts, I
only checked up to 3.4.


> > > That said, this got actually fixed differently upstream. So I prefer =
if
> > > that patch gets merged into stable and not this one.
> > >=20
> > > commit 1036b89042df96e71c0cb941be212f8053ecccc0
> > > Author: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > Date:   Mon Mar 12 15:59:33 2012 +0200
> > >=20
> > >     Bluetooth: Fix opcode access in hci_complete
> >=20
> > Fine with me, though FWIW that not only doesn't use
> > __constant_cpu_to_le16() but actually swaps the non-constant value.
>=20
> Don't see what point you are trying to make here. Swapping the value
> from the actual command structure is always fine with me.

The point is that the result of swapping a constant value is just
another constant value, whereas the fix in mainline swaps a value from
memory. Not a big deal.


> > Also, it would have been nice if that fix was promoted to stable, so I
> > wouldn't have had to spend a good part of the weekend bisecting...
>=20
> Thinks like this happen. However after you bisected the issue you could
> have just checked what is in Linus' or bluetooth-next tree.

You're probably right. It just didn't occur to me that someone would
have fixed this but not forwarded the fix to stable, because I generally
do that. :}


Will you submit the fix to stable, or should I?


--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer

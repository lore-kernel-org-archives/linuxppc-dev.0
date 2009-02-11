Return-Path: <michael@ellerman.id.au>
Subject: Re: request_irq return errno 38
From: Michael Ellerman <michael@ellerman.id.au>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
In-Reply-To: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-BypG+0GMlikjZM1Ue0ew"
Date: Wed, 11 Feb 2009 20:15:03 +1100
Message-Id: <1234343703.9778.13.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BypG+0GMlikjZM1Ue0ew
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-02-11 at 14:13 +0530, Vijay Nikam wrote:
> Hello All,
>=20
> I have mpc8313erdb evaluation board and currently I am writing GPIO
> driver. Actually it is just simple test driver.
>=20
> I did the irq_request in the driver init function, as request_irq
> returns zero (0) if successful, otherwise -1 on error and errno
> indicates the error. But when I load or insert the module using insmod
> request_irq return with Return Value -38. I checked in errno.h file in
> asm-generic and 38 means ENOSYS - Function not implemented.
> Following is irq_request code:
> ----------------------
> ret =3D request_irq(74, interrupt_handler, SA_INTERRUPT | SA_SHIRQ ,
> "gpio", &mydev);
> if(ret)
>     printk(KERN_INFO "Error in request_irq, value return =3D %d \n", ret)=
;
> ----------------------
> NOTE: 74 is the Interrupt ID Number for GPIO Interrupt. this
> information is from Processor User Manual.
>=20
> Following is the handler:
> ---------------------
> static int interrupt_handler(int irqn, void *dev_id)
> {
>     printk(KERN_INFO "Enter in interrupt handler\n");
>     return IRQ_HANDLED;
> }
> --------------------
>=20
> Usually request_irq return EBUSY, EINVAL but in my case it returns
> ENOSYS (errno 38). I tried to look information for this errno in
> interrupt context but could not able to find anything useful or
> understable. Could anyone please let me know why this specific errno
> 38 generated in request_irq ? ? ? and what are the possiblities for
> resolving this error ? ?  ?

You don't mention what kernel version you're using. But you might be
hitting the check in __setup_irq():

        if (desc->chip =3D=3D &no_irq_chip)
                return -ENOSYS;


That would make sense because you're trying to map a raw irq number,
which doesn't work. You first need to call irq_create_mapping(), like:

int virq;
virq =3D irq_create_mapping(NULL, 74);
rc =3D request_irq(virq, ...);


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-BypG+0GMlikjZM1Ue0ew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSlxYACgkQdSjSd0sB4dIVRwCgsK8iAuAw+5GSxHPlvPOMdF/o
I9EAoJCrb7H36iZzP2NY3bUREhtCy/tV
=pGTH
-----END PGP SIGNATURE-----

--=-BypG+0GMlikjZM1Ue0ew--

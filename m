Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C0EB2C009C
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 05:03:49 +1000 (EST)
Date: Tue, 1 Oct 2013 21:03:44 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
Message-ID: <20131001190344.GA3006@katana>
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
 <524A7FCB.3020406@linutronix.de> <20131001091115.GB2993@katana>
 <524AF913.6020007@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <524AF913.6020007@linutronix.de>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > So people can compile with -Werror (RT patchset).
>=20
> Why do you mention the RT patch set here? Doesn't the vanila tree gets
> compiled with -Werror as well?

Not for me.

> > irq_chip *irqchip =3D NULL; /* pet old compilers */
>=20
> That would probably work, too. I would drop that comment but then
> someone might clean that up :P

Yup. But I just remembered a better solution:

=46rom: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ppc: mpc52xx: silence false positive from old GCC

So people can compile with -Werror.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platf=
orms/52xx/mpc52xx_pic.c
index b89ef65..2898b73 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, un=
signed int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *irqchip;
+	struct irq_chip *uninitialized_var(irqchip);
 	void *hndlr;
 	int type;
 	u32 reg;


uninitialized_var was created for exactly that purpose IIRC.

> > People not realizing 'default' is a no-op might wonder why unknown=20
> > levels are mapped to critical.
>=20
> I see. And what would you suggest as default in case we would have an
> additional bit?

-Esome or a different error message. But let's postpone that until that
case happens ;)

> Hmmm. I assumed that critical / SDMA / =E2=80=A6 are interrupt numbers bu=
t they
> are seem not be. In that case I guess l2 is more important. l1 kinda
> looks important since it is the value in the switch case which failed
> but since it can only hold one possible value, I guess your info is
> better :)

Thanks,

   Wolfram


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSxyQAAoJEBQN5MwUoCm2LCoP/3PepQIRab9qiaSE/z2bPs+i
38f+rSckoaiiSfRV+58ykwb5wEI4UqBSIl0XJmBgWTE4dNLpiXGAfAgot+vxV3c8
ahnM3j4crursEk3S+riK9CaBkatNO97XNt/Nb0H6k3yJypK/oTeIQNBB/q+QnhPT
i6hQPq9sEZeNgWETPjqBvFjKhPGT6rsXM+MwK2bE2ev/EErUQtwmzAm9e1fSh8lL
I8AtXyzkOdRXyR/3QmVxad/pbNYcjjurXphUAlkBz5uJUjDIfcsr/a9ji6koq9or
TZhHrJaQrvvYMAlUEMe91BqFyxd7Gykp7cQc2vyKO9298tMW+36LwX+M0kNsOV8A
DHdLP4cu/z8EKkk5L6kV+WHB2m3Crz77r844lsdZzx6mgzMap0Zy3QyF7VnVCKal
krTQT8nbDZ0AjebA88URtCIs6/Z7DZKHOhF7Qrju9glEyb8TCR4KQILjLX0saNC6
rGFPv6aeC9m+9sWk9nLEeJVxglLj7TzQPNnTg0+t2mkCtb7MfmDMn55z7eCrWmwn
60XeiYSohXgVs80OWgampzkYJG8ZiL2ruf8bOvADrir+WK8ZBFTyAGc3qek5NAyR
Gy5FHH8R/StDEhlrcvD6UNEyRQNR38yWMy/8yh4V4bNbgtzqkFga7z+qZelLdeYZ
uTQcGtM/Tik4Oa5SZcOq
=T34+
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 00F172C013B
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 19:11:20 +1000 (EST)
Date: Tue, 1 Oct 2013 11:11:15 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
Message-ID: <20131001091115.GB2993@katana>
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
 <524A7FCB.3020406@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
In-Reply-To: <524A7FCB.3020406@linutronix.de>
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


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 01, 2013 at 09:54:51AM +0200, Sebastian Andrzej Siewior wrote:
> On 10/01/2013 09:26 AM, Wolfram Sang wrote:
> > This reverts commit 6391f697d4892a6f233501beea553e13f7745a23. The
> > compiler warning it wants to fix does not appear with my gcc 4.6.2. IMO
> > we don't need superfluous (and here even misleading) code to make old
> > compilers happy. Fixing the printout was bogus, too. We want to know
> > WHICH critical irq failed, not which level it had.
>=20
> According to minimal Doc*/Changes minimal gcc is 3.2. Mine was 4.3.5.

Well, if you insist, I'd prefer the following patch.

=46rom: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ppc: mpc52xx: silence false positive from old GCC

So people can compile with -Werror (RT patchset).

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platf=
orms/52xx/mpc52xx_pic.c
index b89ef65..ad3c9b0 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, un=
signed int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *irqchip;
+	struct irq_chip *irqchip =3D NULL; /* pet old compilers */
 	void *hndlr;
 	int type;
 	u32 reg;

> Why miss leading code? Default here does the same as unhandled and crit
> where it does nothing.

People not realizing 'default' is a no-op might wonder why unknown
levels are mapped to critical.

> Any why do you want to see l2irq since it was
> not in the case statement? l2 holds the number, l1 the level.

We know which level it was, since the printout is only for that level.
We probably want to know which requested IRQ was causing this, so we can
fix the assorted driver. Otherwise we only know that some critical IRQ
was requested somewhere.

> You were but your email bounced. I wasn't aware of this new email
> address you are using now.

Ah, I see, pity.

Thanks,

   Wolfram

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSpGzAAoJEBQN5MwUoCm2hIkP/AyXr+TQmDfJhLSvCCB//fvd
J6/dn1sh0Wi48DHNmFf+/uxpN2PCfBEjYUzCAEGEseBohWqwKA2F+yzQIT5QQdf/
8Aby6sC+EOYNJ01RpO79Cs4uFJfhJwQgxwh1wifx9qjMHylDTh3+G4qVBLOdZblo
FDdMnHie3P1UNqIWfPXsqc1IsxsaGSKVcgrQOC8gyyn1EPnOOdZVnFNE9x6J9mb7
unonID2uIwCVDOrb+M8bkUoYmoVt+GlrRfOgi7JM1v6lL24Y9EtOZip31nzCnzyW
lkkVYscWG039cshkkakwLA5RjSsKaxZFReoQIPAqEVCROJcGmPZ9sdhYgjnxh8WM
mD00BFrbgbBnXE27SVRvO5nPtbpC32S4tJS2+mNCCtvy9AfQABYWW30SCQaO8cYk
rUlCPZpo8EEUqaTGCv3+TMuB2LuxHfFwky3EHsjEOPyg8V1KCB9p/TDJ1KpprFBP
RG4MkXNtbOQSHdqk0mOh4+Snb1zR0PDVGoqHoASh53gMY0wnDTCzUj6V92CdFId5
d+0jIXAlnhZUEQam+y/58EoDHpW5y7cJZwGnQ45XwuItPQik0d3s5+jH5WqzDJ5t
xyI0fCqfLJSlamNoTdhDxWX615nhxJx6urW14B/dg1OjH8AEtjxLUK3LTUjuMS0Y
rdY1472xwaBtko+++0Le
=vW5n
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--

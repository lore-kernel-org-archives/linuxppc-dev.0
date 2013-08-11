Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D85922C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 09:59:47 +1000 (EST)
Date: Mon, 12 Aug 2013 09:59:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] powerpc: put the common parts of the ppc64*defconfigs in
 a Kconfig file
Message-Id: <20130812095941.a90d32046570b365b7ea4084@canb.auug.org.au>
In-Reply-To: <37F6E4C6-0428-4707-A46A-B9DB9A145747@kernel.crashing.org>
References: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
 <37F6E4C6-0428-4707-A46A-B9DB9A145747@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__12_Aug_2013_09_59_41_+1000_KHXCU7IFR.dhpXQu"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__12_Aug_2013_09_59_41_+1000_KHXCU7IFR.dhpXQu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

Thanks for your comments.

On Fri, 9 Aug 2013 09:41:54 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
>=20
> On Aug 9, 2013, at 1:24 AM, Stephen Rothwell wrote:
>=20
> > We cannot put the unsetting of config options in the Kconfig file, nor
> > the integer or string options.
> >=20
> > I checked that after this we get the same .config files generated (exce=
pt
> > for the addition of the new PPC64_DEFCONFIG* config options.
> >=20
> > Any thoughts?
> > ---
> > arch/powerpc/Kconfig                  |   2 +
> > arch/powerpc/configs/Kconfig          | 295 +++++++++++++++++++++++++++=
++++++
> > arch/powerpc/configs/ppc64_defconfig  | 301 +--------------------------=
-------
> > arch/powerpc/configs/ppc64e_defconfig | 297 +--------------------------=
------
> > 4 files changed, 302 insertions(+), 593 deletions(-)
> > create mode 100644 arch/powerpc/configs/Kconfig
>=20
> Am I missing something here, isn't this a bit of a maintenance pain if
> symbol names change?

I don't think it is any worse than what we have, and in fact may be
better.  Currently if someone renames a config option, they usually do
nothing about the defconfigs, this way, at least if the option is in
configs/Kconfig, they may update it.

> Also, how much of a benefit is this?

There has been some discussion about Anton adding 2 new defconfigs that
are very similar to the current defconfigs.   This is an attempt to
reduce the amount of unnecessary repetition and churn.

A similar thing could be done for other sets of similar defconfig files.

There was a plan a few years ago to replace the defconfigs with Kconfig
fragments and this would be a step along that path.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__12_Aug_2013_09_59_41_+1000_KHXCU7IFR.dhpXQu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCCVxAAoJEECxmPOUX5FEERIP+wV7laGyLK8bFqA1/HDAODj0
A/lGF9/ZJ9GoctOC6rmXKVU+v7wOTaD6WH2/TQM31tUPBCDxtpwpvF3A/ym8LOPD
YcPDuftLa95lfA4H52PnwUs3qBJXPZfWcwMVo4kmcVWrbZoUAi/YHxHs20lXazCt
/tKmqPmPS0q+3oMZoj46rizjUkvB4yPMzbjHt++R4tJimk/qhwCkq6qkKmbviUsB
+lCW61cXBL0KVVvytpqVDNVDONrCU8m2FKQEA3Aa+3FeIDEOrmYesHumuV9x9Mdy
HjEEl38SFwtBiJpvx5h54AKFXa2gfXC+HA4zteCLRy+5+seMBa7z748MrfVk81Pz
QrdCxJ0SM9egG+g0CnF30pTuXii/cCIveLWwpbPYe3jJpfIik3+PmA3ci5PIaRKU
eAP761Z6SCIB30ls937RBRNPuWOC0Ov6oQ0jiXR+0SRaGUseIfpSCjkQpZekeotn
qN4mhhs7kBmXNIyH6lf0NmYA8qiwoFupl+pPtNi4SEQWeq7tjWKypAs7fgncD1kK
gDHH3p3lo2gKExi+sGeDJkP09/JrjwVWsnuWcsOH91IVJqOAGIAq+q6I291A8zfr
D+D593wYHNfMyITK6J+v6p13OugLWPSGeP6btj69Xiw9J8lfbmF2CoYqE8/0T4KY
z5iwhr/Z6grhvO54/Nd7
=CXP1
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Aug_2013_09_59_41_+1000_KHXCU7IFR.dhpXQu--

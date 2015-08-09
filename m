Return-Path: <dja@axtens.net>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B84F1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 09:25:45 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so24395183pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2015 16:25:43 -0700 (PDT)
Received: from abhimac.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id fs13sm16156310pdb.29.2015.08.09.16.25.41
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Aug 2015 16:25:42 -0700 (PDT)
Message-ID: <1439162607.24612.9.camel@axtens.net>
Subject: EEH regression: PE <-> device binding lost after reset
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 10 Aug 2015 09:23:27 +1000
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-tKGFKxtrrd6ohQRwZMcX"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-tKGFKxtrrd6ohQRwZMcX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm experiencing a regression in EEH that was introduced somewhere
between 4.0 and 4.1.

I have been reproducing this with a CAPI (CXL) card, but the behaviour
isn't CAPI related and the triggering code hasn't changed. CAPI cards
are reprogrammed by PERSTing the slot they sit in, so CAPI exposes a
'reset' file in sysfs that does "pci_set_pcie_reset_state(dev,
pcie_warm_reset)", and then relies on EEH noticing to properly reset the
card.

In 4.0 and earlier, this worked: the slot would be persted, EEH would
notice and hotplug. You could do this as many times as you liked.

In 4.1 and later, you can do 1 successful reset, but any subsequent
reset causes the following to be printed in dmesg:

[  225.118656] cxl-pci 0006:01:00.0: CXL reset
[  225.118663] pcibios_set_pcie_reset_state: No PE found on PCI device 0006=
:01:00.0
[  225.118672] cxl-pci 0006:01:00.0: cxl: pcie_warm_reset failed

I'm digging through the commits between 4.0 and 4.1 at the moment, but I
thought I'd post it here in hopes someone had an idea what the root
cause was.=20


--=20
Regards,
Daniel

--=-tKGFKxtrrd6ohQRwZMcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVx+DvAAoJEPC3R3P2I92FzqQP/39gry4EJtNfQKK7/kO34R/i
Ms5/Xu1jem7jtcoIqOyPfDXyK+08MyJH+6lTcRZar0avAQJwDfylkn+Esix+ahms
yyN5Uf56reuHcgY0Z9zVuX9z3ejFub3pvEP6RBOO8EIEhWywopt/1chm0OZIeiQD
mFenjEQxdQZ/Y0COY08kfj19UUVxoHVakI98KiO/TxrR13BiXdrPDMXk64YH/99i
ST6mJ3wQb09+kziyyyUmqijOUfvmgjXepGe72IjkILHXyIPxTcBpFBhHtzSJHTN+
B0cIO2UjBoSCjce8qyD8sNazA6Wq801TTRaGeJ6RPD9fNJpGJld18msBmzavvdEB
EU0k/hw7/aUP8Y8zyvVZ/H9rKszoXOnDszHkvjcVckf9tgntUsHgyeyD5mJyg0Nu
1pGC/4Z+ud5GOnJp9B8Zs6J1N0QBHuKuXdBqgTEcpGarW4HX9ETqmmFZ/94yMvzE
AASS+ZmG4VrpqVuoWB9MGR8qv0o/k7TRhd3zkU5iIgn7NedI0ckQKw5fCFGfJUDi
hqmQnOZBzfWtPbF6BXHOk7fWUC8ytNMvykCOTG2Is9EgYGp7XtA//X5BUr5yRsiD
c6rJRSSQKaJ1Rd48ufDH2K8pJo0CjgsC1VCvNvAqSsKrpBZ6g6Es4MUVv/XqLXjG
MeHLcpdDxUvS362ZU4Mc
=tOy6
-----END PGP SIGNATURE-----

--=-tKGFKxtrrd6ohQRwZMcX--

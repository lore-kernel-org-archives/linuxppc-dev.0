Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72C12DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 21:14:08 +1100 (EST)
Subject: relocatable kernel vs. yaboot
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/BqdaQJJ6Abc2qwJTeQe"
Date: Thu, 30 Oct 2008 00:26:51 +0100
Message-Id: <1225322811.5280.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/BqdaQJJ6Abc2qwJTeQe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry if this has been discussed before, but I just found that yaboot
rejects relocatable kernels claiming they are an invalid ELF file.

In the patch adding relocatable kernel support, I found

+# The iseries hypervisor won't take an ET_DYN executable, so this
+# changes the type (byte 17) in the file to ET_EXEC (2).
 $(obj)/zImage.iseries: vmlinux
        $(STRIP) -s -R .comment $< -o $@
+       printf "\x02" | dd of=3D$@ conv=3Dnotrunc bs=3D1 seek=3D17


Modifying the vmlinux in the same way as above makes yaboot take it, and
I can easily make this part of my installation procedure, but I wonder
if it should be done automatically? Or maybe only documented in the
Kconfig help text? I probably wouldn't have enabled it and then wondered
why it doesn't work if it had warned me about breaking yaboot ;)

johannes

--=-/BqdaQJJ6Abc2qwJTeQe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJCPE4AAoJEKVg1VMiehFY1p4QAJEZLGOSeKnnXWHnFUMTijdg
7466has3/1NIfkDZ9VKzIZbWahZWpUmb7dZ3fJFmbeUjPCREfnegN1VSQ6u/lAil
FNNt99dQLSbcuJnzC8Lk+01fe1nXVfeD52qOCEvS0WfkYQCtPWILB2mD8asspfix
ELZvLTBGpHBTzgwez46pa9P2xKgZEPS5Rj61lWC5ax5kq26WmuuAxn+eSeZktqlB
eyWcJN1sE/5ycD/Rs8Pwtn8XhZLXWq667O91ha2ijVQXi8oMOcp0YZ4uoQW51ncq
DkjG0zi34dtLySWFEkB34d2xVKGIgnx7l+qkCDmssxkNynbAkSSFJT/kjey4mFws
hiYoIZwZ5bjhgWLHFbHkYCeoaXtemE5s6WVSqzd7GNbxhghzCOPAv8x2pn25BXod
z7/NAVrPi/66Nfe6LiQ3BZBvX5VcoeGl44knAjSRGCE3ArpuOHA+4/dl5oVbcJVx
jw1qcA09I3wgLFDo+QpYGUxo8tm47hJfK2AQgRD08jTg+WwR5jdcdZuokmM3hU9o
WOBK8wN7Z/xLS1K+nJvcm49Co/yxCSb/x/80G6u59u4jOe8dIxI42xJZODwBNctt
qScdHw4/vH1Cj/5lBcjeIbht3JdDvBCf2e+d4Ymp/RfK+TnGOUEuRAQScri234Ed
LgZUSUp9Pk/vW6+twQK4
=/72S
-----END PGP SIGNATURE-----

--=-/BqdaQJJ6Abc2qwJTeQe--

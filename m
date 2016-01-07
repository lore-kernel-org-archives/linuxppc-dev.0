Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 781251A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 09:52:00 +1100 (AEDT)
Received: by mail-pa0-x22e.google.com with SMTP id cy9so270588232pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 14:52:00 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Brian Norris <computersforpeace@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Michal Marek <mmarek@suse.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
In-Reply-To: <10821353.mAlCTdTQBC@wuerfel>
References: <20160107185406.GA65420@google.com> <10821353.mAlCTdTQBC@wuerfel>
Date: Fri, 08 Jan 2016 09:51:35 +1100
Message-ID: <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Arnd,

Thanks for your patch.
Acked-by: Daniel Axtens <dja@axtens.net>

> Alternatively, remove the -Werror. We occasionally get people that add this
> flag to a Makefile, but it tends to cause more trouble whenever a new
> gcc version arrives.

Speaking up as the person who added -Werror to cxl, I'd really rather
it stayed. There are a number of reasons I think this. Here's the first
three that came to mind.

 - cxl is powerpc specific (and always will be for deep seated hardware
   reasons), and is handled through the powerpc tree. arch/powerpc
   compiles with -Werror, and as part of the powerpc ecosystem, cxl
   should too.

 - It forces cxl developers to a higher standard. cxl has already had
   more than it's fair share of incredibly difficult to debug issues,
   so any way we can reduce the risk of errors going in makes our lives
   (and our end-users lives) better.

 - I am (and I'm quite confident the other cxl people are) quite happy to
   send patches to fix build-breaking issues such as this. Indeed, I
   would have, except you sent it during the Australian night :)

If it's really super-duper important we can consider putting it behind a
config guard, but I'd really rather not.

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWjuv5AAoJEPC3R3P2I92FkEUQAKJlmQyzcyuOit3ezRC5c7iC
dAbOw8D/5Z29bN3GV1IQe5PykF3jKC/u8EVZXTt08xOHyoUW2LxZ2mWpySX/Oc1d
JBzTIJ5lBwMbV1ilwmSfXHFqqeeoPLEjuQKjCZGaPNclUUZWPJmequGIYdtvwqDD
T9Kvv6ly2OMF2Cc41kjbXdiGwjgtbxHjoYFCq+saezlc1dPbWl+JB50Du9rkL6HN
VmU6IHiTA7EIzBHcjTw7FXFfVPCDjKndLymw81WFa6541NEdEej3tYxKeLgHSkd9
9xz89J2hbD4UQ9jQyDLEPA0jJ5XODtI4rJyV//LxL/HEVqXl4hyPtpNoSx7izsHY
zfSbZvtDer/Yx0EIRSSQfbiR2rfzHks1+bbP/Li8kzyhvKVf9VNT5Q+ncmDPdtk6
9RZc/MpDR5qJQ+Joq3tiLTsbJxctObQt/aNTmf0FWZLZiU3eu4KwXEHCDcWLLz4z
YqxztssilW7WumMGf13N3WwB5bxitm4il51UzzdiWSPvVW+1FVbfydgNP/1VUWJm
kuYQHjJy9mA5TZMM5kWev3LEGQXwKYwj5bXd5B7tpz3wcD+HsFy64T/3OQTEupy+
VVf/PNQWztrXZj2qkTCCB+2uY3+ebIq6zMuVCZ2SJrFgWUGgjoMr/RYqTwNIPsbj
aPZpFUeroq+sKwEQ6dPq
=4hn7
-----END PGP SIGNATURE-----
--=-=-=--

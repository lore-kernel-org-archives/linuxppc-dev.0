Return-Path: <danielmicay@gmail.com>
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com
 [IPv6:2607:f8b0:400d:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrj7X1S2XzDr0N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 05:19:51 +1000 (AEST)
Received: by mail-qk0-x22c.google.com with SMTP id x1so25432943qkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 12:19:51 -0700 (PDT)
Message-ID: <1468610363.32683.42.camel@gmail.com>
Subject: Re: [kernel-hardening] Re: [PATCH v2 02/11] mm: Hardened usercopy
From: Daniel Micay <danielmicay@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: Balbir Singh <bsingharora@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>,  Rik van Riel <riel@redhat.com>, Casey
 Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,  Brad
 Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Michael Ellerman
 <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>,  Pekka
 Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,  Mathias
 Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>, Vitaly Wool
 <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Dmitry
 Vyukov <dvyukov@google.com>, Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, sparclinux
 <sparclinux@vger.kernel.org>,  linux-arch <linux-arch@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
Date: Fri, 15 Jul 2016 15:19:23 -0400
In-Reply-To: <CAGXu5jLiD1xEb=dDuf+_2JVzmkH_6O5-m=p=AVvi7qgQ+SV4UA@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
 <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
 <1468609254.32683.34.camel@gmail.com>
 <CAGXu5jLiD1xEb=dDuf+_2JVzmkH_6O5-m=p=AVvi7qgQ+SV4UA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-Y+YBKcxvbURjRYqK+Wc9"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Y+YBKcxvbURjRYqK+Wc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I'd like it to dump stack and be fatal to the process involved, but
> yeah, I guess BUG() would work. Creating an infrastructure for
> handling security-related Oopses can be done separately from this
> (and
> I'd like to see that added, since it's a nice bit of configurable
> reactivity to possible attacks).

In grsecurity, the oops handling also uses do_group_exit instead of
do_exit but both that change (or at least the option to do it) and the
exploit handling could be done separately from this without actually
needing special treatment for USERCOPY. Could expose is as something
like panic_on_oops=3D2 as a balance between the existing options.
--=-Y+YBKcxvbURjRYqK+Wc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIzBAABCAAdBQJXiTc7FhxkYW5pZWxtaWNheUBnbWFpbC5jb20ACgkQ+ecS5Zr1
8ip2TA/+IoxpTaGfA5/9DDfnjr5OainSD/MMP/0obMRVPRnaJlTJT8ahCOtDauQv
jTR+GoJaVkO6ZzOML+79FQOjv91/yPg2RiT6GKzKLb4jCGtJw/rEsMSGk0yJWUjJ
IeazONbF6Swqm/JT/3UoxsJvf0QgUF3lhm3/vcvBoBjY9lCXtDSB0JYd7v+Ob8EU
7D1mxokvg3MQCTVAlJa2IDkHanmIKBBRPXtbQl2KvlJhWF0GWkErplu5ZncVpY1X
TvsiMEpyZDiQc+U1Cpu4Thc8/GUoWthZGgjhw7p+hGgw3XXrRb17WaBqWS5o8dJl
/QbBOjzFopKRnovqTmIqYXgoue/LhZNYYRXAo35CcFDMOH3HvBCKtdNrngLjoxHv
vRrubMLjSxBml8/ulNqXWmrFIvd8aLM8TAkWIvC8bEFMqITDXMXIp9zs1ObEVXD6
m5pF2CtNgxIvx17/hnlp0U0k4ldaekkhHkSYyd7v8yr5CkqLh250YeRxWFf4kKh6
Ii+rXm70hdGvMHOw8TcWW+B82eZiFOhPyeWyibFnO+JzsQyWwIzWpIY1+xQZUBcr
b9rh+kXFS2aOvtj55KSScTEcGyo3aknrkt1kAJY8spQMUOLtog9eifryhpS3Nl6O
hGQ5lDsxJxyZCdpLfv5RU4WC7xoQGdGAzV0Nn7ukkiF2x2R5MFI=
=Wn4X
-----END PGP SIGNATURE-----

--=-Y+YBKcxvbURjRYqK+Wc9--

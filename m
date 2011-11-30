Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 10:30:27 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/boot: Add mfdcrx
Message-ID: <20111130233027.GC15560@thor.bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-6-git-send-email-tony@bakeyournoodle.com>
 <F91E9007-5DA5-4E3A-993E-EA680DE08D79@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
In-Reply-To: <F91E9007-5DA5-4E3A-993E-EA680DE08D79@kernel.crashing.org>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 02:09:20PM +0100, Segher Boessenkool wrote:
> >+#define mfdcrx(rn) \
> >+	({	\
> >+		unsigned long rval; \
> >+		asm volatile("mfdcrx %0,%1" : "=3Dr"(rval) : "g"(rn)); \
> >+		rval; \
> >+	})
>=20
> "g" is never correct on PowerPC, you want "r" here.  You can write
> this as a static inline btw, you only need the #define stuff when
> there is an "i" constraint involved.

Okay I'll change it to "i", mostly I used a #define to match the style
of m[tf]dcr.  To be honnest I didn't know about the issue with "i"
constraints and static inlines.

Yours Tony

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1ryTAAoJEEsCiJRY75GKGVwQAI1XXTJcCM7xwThdTDXXfcAq
alcCj4T/QEp3hyqP2NrlkEai3PMYACLHlP9qKcL1wztPXqpdc6A1OF2wlruM9E9+
ds9WQSLySk5s0mLnu7XfxqqUyWirpKT0WYog3P1qw8PWnelwrSzy/9vZLjuwhOrl
+pUTyvY/TsQwrSumUe5WJlu4go8zNOnmZzRNxjLGxy9XyP1u1u5xZEnKI2pTSBw6
xx2XWbfiX0NR8NpS+hlpdvH3DGItJ677o9zFFNu/fhxAOEnBABYsPndCza1IgD00
EB8M/r7xSeoLTu4qfh/bzdi5ksgX1xmJBYU4YXDM83uMhX9HHoPDkDW8vOG+g5ip
fMqRTppeKClJiTi/xDwbPp8gC9o84XQYDZS2rB4bDLqDxs/YxBRQZdaXbts9y9+k
Pxcl2pMfvfb6Qzz2dq3G2Nmpjgh2+Xckhlq/CKrxBbljgICzqr6wpBKaJhq8sQGO
7d73tCaeb0+u6TZs4a2NGvgrDDIDU97VqNPhyx6yMMMqlwJsJtDtAFkunKWA0uzj
Pze5pSEe3QqdPTyEZwTV/1hKVkSZQr8YnY9ZQQIAOCmWgOCdiMNYZRDaGQg/LhKO
3Pru+JqannUNpm5dUaq6Ul1n904DVyIl/qaOE8k9fhNqTbJM8OYKhekZjUn9gFbW
qVwzg85mq0nWWSfoTviU
=AkHP
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

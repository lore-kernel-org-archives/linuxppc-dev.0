Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A5201A040E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 19:55:40 +1100 (AEDT)
Received: by padda3 with SMTP id da3so20818266pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 01:55:38 -0700 (PDT)
Date: Mon, 26 Oct 2015 16:55:08 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151026085508.GB13641@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021081833.GB2881@worktop.programming.kicks-ass.net>
 <20151021193638.GU5105@linux.vnet.ibm.com>
 <1445826001.27249.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <1445826001.27249.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 11:20:01AM +0900, Michael Ellerman wrote:
>=20
> Sorry guys, these threads are so long I tend not to read them very active=
ly :}
>=20
> Looking at the system call path, the straight line path does not include =
any
> barriers. I can't see any hidden in macros either.
>=20
> We also have an explicit sync in the switch_to() path, which suggests tha=
t we
> know system call is not a full barrier.
>=20
> Also looking at the architecture, section 1.5 which talks about the
> synchronisation that occurs on system calls, defines nothing in terms of
> memory ordering, and includes a programming note which says "Unlike the
> Synchronize instruction, a context synchronizing operation does not affec=
t the
> order in which storage accesses are performed.".
>=20

Thank you, Michael. So IIUC, "sc" and "rfid" just imply an execution
barrier like "isync" rather than a memory barrier. So memory barriers
are needed if a system call need a memory ordering guarantee.

Regards,
Boqun

> Whether that's actually how it's implemented I don't know, I'll see if I =
can
> find out.
>=20
> cheers
>=20

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLeppAAoJEEl56MO1B/q4wvUH/RVFanq9RGXXpq/SgZCFoZ9D
d3u2HOEXvb5VP6GL4MPhia7nP8lP1tWdw3pj6Ide7wUbT1xQqAtev4WbnuKPGgI7
6X0N0NtQfemLiWX5MENcvB2odlBwJSbH2GsmNOjclB/aLVu/y+z+bP5rUL/u10wh
cXYN6X0zp6rcW4aHFj0V0aKa/SgyynNMEwpehEdQQW8s5STMYVj7pC4kfmvwMqBg
aZITtmtqP4sVJPvh7JNPxT1vcdryJVIRfa3La/ZXJXv8sJiALVOamgT0Zg/vOREI
0fsgeIXVqCeCliYGsKPTM4vG2KHDdlxjQzdDvZQ4jmercVO5/gwwI6G4Ejes1r0=
=1LYJ
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262A41A056E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 12:58:32 +1100 (AEDT)
Received: by padhy16 with SMTP id hy16so101436779pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2015 18:58:30 -0700 (PDT)
Date: Sat, 10 Oct 2015 09:58:06 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151010015805.GA946@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Sorry for replying late.

On Thu, Oct 01, 2015 at 02:27:16PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the cmp part
> > fails, so we need to implement these using assembly.
>=20
> I think that is actually expected and documented. That is, a cmpxchg
> only implies barriers on success. See:
>=20
>   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory o=
rdering semantics")

I probably didn't make myself clear here, my point is that if we use
__atomic_op_acquire() to built *_cmpchg_acquire(For ARM and PowerPC),
the barrier will be implied _unconditionally_, meaning no matter cmp
fails or not, there will be a barrier after the cmpxchg operation.
Therefore we have to use assembly to implement the operations right now.

Regards,
Boqun

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWGHCmAAoJEEl56MO1B/q4GkMH+wWVfgleFLzIDrURMWc9eHK0
NfCFabgZeeqgiVJqeqGHSkPqMVzfm5RVSshGrsrT7fynUOfzT2vVmDbSsei/nkSm
ADkJr8e6MKiN2PDOfCQoGHWyocOZXHyGo6rKBR5YmAJmf1r/OeYI5ewK9PcWcohV
TtAxdChzrob+moKronElXc7kS0jMAqh7M98o6FxDP3HzQeQFZ4bnauD/yoHlu2sB
9yp8Ael105/LclTIM/9Z9hwHEPI949ASbkYa+BGDvDlJLN49e8wEhouCk5howqzD
WwBP+OwFXbUkOt1mDrCUvsoVeNnRzbTA9Wm01lNXs1F405sDktNF5UczYEo3IyU=
=d3yF
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

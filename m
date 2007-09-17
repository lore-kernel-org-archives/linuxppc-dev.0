Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 539E1DDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 16:28:47 +1000 (EST)
Date: Mon, 17 Sep 2007 16:28:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: travis@sgi.com
Subject: Re: [PATCH 09/10] ppc64: Convert cpu_sibling_map to a per_cpu data
	array (v3)
Message-Id: <20070917162831.b2a9d675.sfr@canb.auug.org.au>
In-Reply-To: <20070912015647.486500682@sgi.com>
References: <20070912015644.927677070@sgi.com>
	<20070912015647.486500682@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__17_Sep_2007_16_28_31_+1000_tjewKN/mkN4kGaNl"
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__17_Sep_2007_16_28_31_+1000_tjewKN/mkN4kGaNl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Sep 2007 18:56:53 -0700 travis@sgi.com wrote:
>
> Convert cpu_sibling_map to a per_cpu cpumask_t array for the ppc64
> architecture.  This fixes build errors in block/blktrace.c and
> kernel/sched.c when CONFIG_SCHED_SMT is defined.
>=20
> Note: these changes have not been built nor tested.

After applying all 10 patches, the ppc64_defconfig builds but:

	vmlinux is larger:

   text    data     bss     dec     hex filename
7705776 1756984  504624 9967384  981718 ppc64/vmlinux
7706228 1757120  504624 9967972  981964 trav.bld/vmlinux

	the topology (on my POWERPC5+ box) is not correct:

cpu0/topology/thread_siblings:0000000f
cpu1/topology/thread_siblings:0000000f
cpu2/topology/thread_siblings:0000000f
cpu3/topology/thread_siblings:0000000f

it used to be:

cpu0/topology/thread_siblings:00000003
cpu1/topology/thread_siblings:00000003
cpu2/topology/thread_siblings:0000000c
cpu3/topology/thread_siblings:0000000c

Similarly on my iSeries box, the topology is displayed as above
while it used to be:

cpu0/topology/thread_siblings:00000001
cpu1/topology/thread_siblings:00000002
cpu2/topology/thread_siblings:00000004
cpu3/topology/thread_siblings:00000008

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__17_Sep_2007_16_28_31_+1000_tjewKN/mkN4kGaNl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7h6VTgG2atn1QN8RAmB+AJ9HOw5MvcVaJSHu/pECUTF9I4l5VACgj//+
2tXfkc5WNeX4tppxSpnOXis=
=XiPX
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Sep_2007_16_28_31_+1000_tjewKN/mkN4kGaNl--

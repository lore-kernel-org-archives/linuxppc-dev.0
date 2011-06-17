Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A38EFB6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:38:18 +1000 (EST)
Date: Fri, 17 Jun 2011 15:38:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: linux-next: build failure after merge of the final tree (Linus'
	tree related)
Message-Id: <20110617153809.471769a1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__17_Jun_2011_15_38_09_+1000_LUBYqUY+MpBguNXH"
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__17_Jun_2011_15_38_09_+1000_LUBYqUY+MpBguNXH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

mm/page_cgroup.c: In function 'page_cgroup_init':
mm/page_cgroup.c:309:13: error: 'pg_data_t' has no member named 'node_end_p=
fn'

Caused by commit 37573e8c7182 ("memcg: fix init_page_cgroup nid with
sparsemem").  On powerpc, node_end_pfn() is defined to be (NODE_DATA
(nid)->node_end_pfn) where NODE_DATA(nid) is (node_data[nid]) and
node_data is struct pglist_data *node_data[].  As far as I can see,
struct pglist_data has never had a member called node_end_pfn.

This commit introduces the only use of node_end_pfn() in the generic
kernel code.  Presumably the powerpc definition needs to be fixed (to
maybe something like the x86 version).  It looks like the sparc version
is broken as well.

I have left the powerpc allyesconfig build broken for today (as it is
also broken by other changes).
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Jun_2011_15_38_09_+1000_LUBYqUY+MpBguNXH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN+uhBAAoJEDMEi1NhKgbscpcH/j4f0JrOUkpqEdXpHXbx/Ojb
h9UI2DbI28RPfbPG4Rs/z6EhXeuHADwjdIDW7qRSzKcj3c8Gx1cgjxXiTSkjiHjW
OSywnYjjGWfQNjD3C0qHfRydWrqaKIbOZKGGnC9Bfg681l1PmDVIheVTh+1AfiLv
sFVKtuTY7PX8ZHa1ynxx4uFSRN8hHLGWi7MsLkqa5nfnz7WsaGCppQSiUEykHh6+
ZgSrspZ+xBsyhl0+rdRvB19UNqqzeqZu2ziBkXPgqMSdQ5wt/YfxjOHOcRi8ERpS
q2+yJuPRI9Na4aNRX/PlLdIgn0GHGTDTo7aYY7AwUUXXJmEd72Zl1apg8QS9yN0=
=UVTC
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Jun_2011_15_38_09_+1000_LUBYqUY+MpBguNXH--

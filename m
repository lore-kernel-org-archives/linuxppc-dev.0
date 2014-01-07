Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 7C23E2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 20:51:03 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15090-02 for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  7 Jan 2014 09:44:19 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anton Blanchard' <anton@samba.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "cl@linux-foundation.org" <cl@linux-foundation.org>, "penberg@kernel.org"
 <penberg@kernel.org>, "mpm@selenic.com" <mpm@selenic.com>,
 "nacc@linux.vnet.ibm.com" <nacc@linux.vnet.ibm.com>
Subject: RE: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Date: Tue, 7 Jan 2014 09:42:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D453A4E@AcuExch.aculab.com>
References: <20140107132100.5b5ad198@kryten>
In-Reply-To: <20140107132100.5b5ad198@kryten>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Anton Blanchard
> We noticed a huge amount of slab memory consumed on a large ppc64 box:
>=20
> Slab:            2094336 kB
>=20
> Almost 2GB. This box is not balanced and some nodes do not have local
> memory, causing slub to be very inefficient in its slab usage.
>=20
> Each time we call kmem_cache_alloc_node slub checks the per cpu slab,
> sees it isn't node local, deactivates it and tries to allocate a new
> slab. ...
...
>  	if (unlikely(!node_match(page, node))) {
>  		stat(s, ALLOC_NODE_MISMATCH);
> 		deactivate_slab(s, page, c->freelist);
> 		c->page =3D NULL;
> 		c->freelist =3D NULL;
> 		goto new_slab;
>  	}

Why not just delete the entire test?
Presumably some time a little earlier no local memory was available.
Even if there is some available now, it is very likely that some won't
be available again in the near future.

	David.

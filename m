Return-Path: <yosefe@voltaire.com>
Received: from exil.voltaire.com (fwil.voltaire.com [193.47.165.2])
	by ozlabs.org (Postfix) with ESMTP id C044B1007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 16:21:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: possible bug in ppc_vm_region_alloc()
Date: Tue, 3 Aug 2010 09:21:12 +0300
Message-ID: <7E95F01E94AB484F83061FCFA35B39F889F230@exil.voltaire.com>
In-Reply-To: <7E95F01E94AB484F83061FCFA35B39F801322D@exil.voltaire.com>
References: <7E95F01E94AB484F83061FCFA35B39F801322D@exil.voltaire.com>
From: "Yossi Etigin" <yosefe@voltaire.com>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: Alex Netes <alexne@voltaire.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

(I repost this because looks like the previous was filtered because I
was not subscribed to the list)

We are looking at dma_alloc_coherent(), which uses ppc_vm_region_alloc()
on the coherent region "consistent_head".
It seems to us there is a bug in the function ppc_vm_region_alloc().
The check "if (addr > end)" should be "if (addr >=3D end)"

If for example it is called once when the size is the entire coherent
region, the second time it will allocate a region outside the valid
memory.
It will happen because the list will contain one element (besides the
head) which is equal to the head, and neither condition will cause a
"goto nospc". Then the list iteration will end and the new region will
be allocated right after the valid region.

	list_for_each_entry(c, &head->vm_list, vm_list) {
		if ((addr + size) < addr)
			goto nospc;
		if ((addr + size) <=3D c->vm_start)
			goto found;
		addr =3D c->vm_end;
		if (addr > end)                    <=3D=3D=3D here
			goto nospc;
	}

--Yossi

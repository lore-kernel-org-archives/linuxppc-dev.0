Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08D68DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 23:59:41 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l64Dxbo2388608
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 13:59:37 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l64DxbB41777698
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 15:59:37 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l64DxaTV022133
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 15:59:37 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: jim.houston@ccur.com
Subject: Re: idr_get_new_above() limitation?
Date: Wed, 4 Jul 2007 16:11:29 +0200
References: <200707021919.27251.hnguyen@linux.vnet.ibm.com>
	<1183422700.3130.27.camel@localhost.localdomain>
In-Reply-To: <1183422700.3130.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707041611.30056.hnguyen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 July 2007 02:31, Jim Houston wrote:
> The problem is in idr_get_new_above_int() in the loop which
> adds new layers to the top of the radix tree.  It is failing
> the "layers < (MAX_LEVEL - 1)" test.  It doesn't allocate the
> new layer but still calls sub_alloc() which relies on having
> the new layer properly constructed.  I believe that it is
> allocating the slot which corresponds to id = 0.
Hi Jim,
Thanks for your quick reply.
Yes, I realized that while condition too and have tried with a tiny
change like (layers < MAX_LEVEL), but without success with idr_find(), 
even though 6 layers were created and the object was added at proper
location. After several debug cycles I think to find the root cause 
in the if-condition in idr_find():
void *idr_find(struct idr *idp, int id)
{
	int n;
	struct idr_layer *p;

	n = idp->layers * IDR_BITS;
	p = idp->top;

	/* Mask off upper bits we don't use for the search. */
	id &= MAX_ID_MASK;

	if (id >= (1 << n))
		return NULL;
...
}
Since idp->layers is now 6, n is equal 36, ie out of 32-bit-range,
and therefore
	(1 << n) = (1 << 36) = 0
causing that if-cond to be true ie idr_find() fails.
Replacing that if-line by
	if ((long)id >= (1L << n))
makes idr_find() working properly until MAX_ID_MASK.
Since there are other places to be changed like above as well eg.
idr_replace() and because you're creating a patch too, I'm waiting
first for your comment. Let me know if you prefer me to send a
patch.
Regards
Nam

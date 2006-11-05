Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7BC5D67CC5
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 10:47:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
Date: Mon, 6 Nov 2006 00:45:58 +0100
References: <200611052140.38445.hnguyen@de.ibm.com>
In-Reply-To: <200611052140.38445.hnguyen@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611060045.59074.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, raisch@de.ibm.com, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 05 November 2006 21:40, Hoang-Nam Nguyen wrote:

> +/* constructor ctblk_cache */
> +void ehca_ctblk_ctor(void *ptr, kmem_cache_t *cache, unsigned long flags)
> +{
> + memset(ptr, 0, EHCA_PAGESIZE);
> +}
> +
> +void *ehca_alloc_fw_ctrlblock(void)
> +{
> + void *ret =3D kmem_cache_alloc(ctblk_cache, SLAB_KERNEL);
> + if (!ret)
> + =A0ehca_gen_err("Out of memory for ctblk");
> + return ret;
> +}
> +
> +void ehca_free_fw_ctrlblock(void *ptr)
> +{
> + if (ptr)
> + =A0kmem_cache_free(ctblk_cache, ptr);
> +

This seems broken. You have a constructor for newly allocated objects, but
there is no destructor and it seems that objects passed to
ehca_free_fw_ctrlblock are not guaranteed to be initialized either.

I'd simply move the memset into the alloc function and get rid of the
constructor here.

	Arnd <><

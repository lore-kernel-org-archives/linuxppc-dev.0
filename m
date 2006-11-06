Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6998D67C94
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 20:57:20 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA69vDL3188244
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 09:57:13 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA6A0FAf3129522
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 11:00:15 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA69v6uM032456
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 10:57:06 +0100
In-Reply-To: <200611060045.59074.arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <OF478DD9AF.FCA98729-ONC125721E.0031F840-C125721E.0036A811@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 11:00:00 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,
> This seems broken. You have a constructor for newly allocated objects,
but
> there is no destructor and it seems that objects passed to
> ehca_free_fw_ctrlblock are not guaranteed to be initialized either.
> I'd simply move the memset into the alloc function and get rid of the
> constructor here.
Yep, I was not aware that ctor is not called for every
kmem_cache_alloc(). Thx for pointing this out.
Nam

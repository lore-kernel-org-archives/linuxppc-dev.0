Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E08F67CFC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 02:00:17 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA6F09ot016574
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 15:00:09 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA6F3BkB1802276
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 16:03:11 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA6ExZWq006227
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 14:59:36 GMT
Date: Mon, 6 Nov 2006 15:58:39 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
Message-ID: <20061106145839.GA9387@osiris.boeblingen.de.ibm.com>
References: <200611052140.38445.hnguyen@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611052140.38445.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#ifdef CONFIG_PPC_64K_PAGES
> +void *ehca_alloc_fw_ctrlblock(void);
> +void ehca_free_fw_ctrlblock(void *ptr);
> +#else
> +#define ehca_alloc_fw_ctrlblock() get_zeroed_page(GFP_KERNEL)
> +#define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
> +#endif

Maybe you want to make sure that ehca_alloc_fw_ctrlblock() always returns a
void pointer, so you can avoid all the casts in your code?

static inline void *ehca_alloc_fw_ctrlblock(void)
{
	return (void *)get_zeroed_page(GFP_KERNEL);
}

Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E40D367C70
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:25:35 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA6GPQNf373408
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 16:25:26 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA6GSSaX3068034
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:28:28 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA6GPIXo023892
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:25:19 +0100
In-Reply-To: <20061106145839.GA9387@osiris.boeblingen.de.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
To: heicars2@de.ibm.com
Message-ID: <OF04898E66.3051E8D8-ONC125721E.0058993B-C125721E.0058DF2C@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 17:13:44 +0100
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

heicars2@de.ltcfwd.linux.ibm.com wrote on 06.11.2006 15:58:39:
> Maybe you want to make sure that ehca_alloc_fw_ctrlblock() always returns
a
> void pointer, so you can avoid all the casts in your code?
> static inline void *ehca_alloc_fw_ctrlblock(void)
> {
>    return (void *)get_zeroed_page(GFP_KERNEL);
> }
Yes, good point. That helps to avoid different warnings between
4k and 64k page modes.
Thx
Nam

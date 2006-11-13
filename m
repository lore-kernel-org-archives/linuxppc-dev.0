Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8917167D77
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 03:37:46 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id kADGbfSW275014
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 16:37:41 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kADGesBh3170526
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:40:54 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kADGbeYT029928
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:37:40 +0100
In-Reply-To: <17748.15442.906060.210242@cargo.ozlabs.ibm.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
	mapping in 64k page mode
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 13 Nov 2006 17:40:52 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, openib-general-bounces@openib.org,
	linux-kernel@vger.kernel.org, openib-general@openib.org,
	Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> Christoph Raisch writes:
>
> > The patch is needed. We've seen it on the real system. We did fix it on
the
> > real system.
>
> I disagree that the ioremap change is needed.
>
> > ...and it conforms to theory... although theory is a bit confusing
here.
> >
> > let me try to summarize:
> > ioremap checks for 64k boundary (actually page boundary)
>
> Actually, ioremap itself already does the calculations that your patch
> adds - that is, it generates the offset within the page and the
> physical address of the start of the page, does the mapping using the
> latter, then adds on the offset to the virtual address of the page and
> returns that.

Paul,
you are right. The calculation is done in your code already.
We can't reproduce the problem anymore on latest kernel.
Was this calculation there in ioremap right from the start with 64k on
POWER or added later on?

So Roland, feel free to ignore that line where we do the calculation.

>
> Paul.

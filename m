Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2385F67FE1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:46:46 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id kAA7kg2T016486
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 07:46:42 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kAA7noZt3289322
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:49:50 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kAA7kfPr019677
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:46:41 +0100
In-Reply-To: <adaodrgb7uq.fsf@cisco.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
	mapping in 64k page mode
To: "Roland Dreier" <rdreier@cisco.com>
Message-ID: <OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 10 Nov 2006 08:49:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, openib-general-bounces@openib.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Umm, so is this patch really needed?  Where did the patch come from --
> is it needed to fix something actually seen, or was it written just
> based on some theoretical understanding?
>
> I'm confused...
>
>  - R.
The patch is needed. We've seen it on the real system. We did fix it on the
real system.
...and it conforms to theory... although theory is a bit confusing here.

let me try to summarize:
ioremap checks for 64k boundary (actually page boundary)
nopage does H_ENTER in 4k granularity if it's configured like that for a
certain type of POWER processor.

so you have to adjust the ioremap to page boundary, and THEN access at the
offset within the 64k.

Took quite a while until we understood that code path.... ;-)

Christoph R.

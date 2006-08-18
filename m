Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B94867B5D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 01:32:06 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IFW1VY038300
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:32:01 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IFZtPr154482
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:35:55 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IFW0HH011439
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:32:00 +0200
In-Reply-To: <200608180144.19149.arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 02/13] IB/ehca: includes
To: abergman@de.ibm.com
Message-ID: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 17:35:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


abergman

> > +#define EDEB_P_GENERIC(level,idstring,format,args...) \
>
> These macros are responsible for 61% of the object code size of your
module.
> ...Please get rid of that crap entirely and replace
> it with dev_info/dev_dbg/dev_warn calls where appropriate!
>
>    Arnd <><

we'll change these EDEBs to a wrapper around dev_err, dev_dbg and dev_warn
as it's done in the mthca driver.
All EDEB_EN and EDEB_EX will be removed, that type of tracing can be done
if needed by kprobes.
There are a few cases where we won't get to a dev, for these few places
we'll use a simple wrapper around printk, as done in ipoib.

Hope that's the "official" way how to implement it in ib drivers.


Gruss / Regards . . . Christoph R

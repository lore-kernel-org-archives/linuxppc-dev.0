Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26FD1679F4
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 20:17:04 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k3T78Ti6170436
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 07:08:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3T79bGg107516
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:09:37 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3T78SR7024266
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:08:28 +0200
Date: Sat, 29 Apr 2006 09:08:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Message-ID: <20060429070826.GA9463@osiris.boeblingen.de.ibm.com>
References: <4450A176.9000008@de.ibm.com>
	<20060427114355.GB32127@wohnheim.fh-wedel.de>
	<1146177388.19236.1.camel@localhost.localdomain>
	<6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
	<84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
	<4044CACC-FB5A-415E-8974-27136269B5C1@schihei.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4044CACC-FB5A-415E-8974-27136269B5C1@schihei.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >>The problem I see with pr_debug() is that it could only activated via
> >>a compile flag. To use the debug outputs you have to re-compile /
> >>compile your own kernel.
> >
> >Do you really need this heavy debug logging in the first place? You
> >can use kprobes for arbitrary run-time inspection anyway, so logging
> >everything seems wasteful.
> 
> The problem I see with kprobes is that you have to set several kernel
> configuration options (e.g. CONFIG_KPROBES, CONFIG_DEBUG_INFO, etc.)
> on compile time to use it. Same problem with pr_debug().

It might be worth to move the s390 debug feature to common code. At least
it has proven many times to be very useful in device driver debugging...
See Documentation/s390/s390dbf.txt and arch/s390/kernel/debug.c.

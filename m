Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF8FF67CBF
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 21:15:21 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id k9RBFGWo186084
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 11:15:16 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k9RBI24m2367740
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 13:18:02 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k9RBFFP7031330
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 13:15:15 +0200
In-Reply-To: <20061026201313.9c831fc9.akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
To: Andrew Morton <akpm@osdl.org>
Message-ID: <OF9B06F6DE.7191F185-ONC1257214.003DB403-C1257214.003DD10C@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 27 Oct 2006 13:17:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew Morton <akpm@osdl.org> wrote on 27.10.2006 05:13:13:

> On Wed, 25 Oct 2006 13:11:42 +0200
> Jan-Bernd Themann <ossthema@de.ibm.com> wrote:
>
> > This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)
>
> why?


these few kcallocs run in atomic context in some situations.
therefore GFP_KERNEL is no good idea.

Christoph R.

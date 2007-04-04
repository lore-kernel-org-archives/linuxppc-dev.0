Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3873DDED0
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:22:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l34GNLAe013323
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 12:23:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l34GMaAp313658
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 12:22:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l34GMZ0N014354
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 12:22:35 -0400
Date: Wed, 4 Apr 2007 11:22:34 -0500
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404162234.GS4922@austin.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403230908.GA13471@cynthia.pants.nu>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 04:09:08PM -0700, Brad Boyer wrote:
> The issue is that the naming should be consistent. I
> shouldn't need to know what the hardware is to use what is fundamentally
> an abstraction of "serial port" as far as the user is concerned. On
> Solaris, I can say "/dev/term/a" and know that I will get the first
> serial port if it is available without needing to care if it is the
> zs, se or asy driver talking to the hardware.

I presume that a correctly structured set of rules for udev should
accomplish the same thing; when udev runs, it could create links to
/dev/serial0 or /dev/serial/0 etc. as you wish. Applications
"should" use the udev-created links, not the raw, underlying device
nodes.

The biggest problem would seem to be that the assignment would
depend on the detection order; there don't seem to be unique 
id's that would help udev consistently assign device names in 
consistent order.

--linas

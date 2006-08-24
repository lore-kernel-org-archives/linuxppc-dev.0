Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A26C967C47
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 15:56:38 +1000 (EST)
Subject: RE: [PATCH 1/3] Adapt ipic driver to new host_ops interface,
	addset_irq_type to set IRQ sense
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC2F3@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0FC2F3@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 15:56:22 +1000
Message-Id: <1156398982.8433.200.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But for IRQ with a specified type, set_irq_type() will be called two
> times continuously.  Why not call the set_irq_type() in any case in
> irq_create_of_mapping()?

well... it would still not be called by irq_create_mapping() (the non-OF
one). You need to make sure your stuff is properly initialized in the
case there it's not called. That is that you have a proper default irq
type, handler, and HW setup after host_map() returns.

It's not terribly harmful to have set_irq_type() called twice. Another
option is to have host_map re-do what your set_type() does, or move the
common code into a low level __set_type() that gets called by both
set_irq_type() and your host_map ...

Ben.

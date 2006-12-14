Return-Path: <mostrows@watson.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E46667C03
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 23:46:27 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBECkJOE014658
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 07:46:19 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBECkJW8208982
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 07:46:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBECkJjn030280
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 07:46:19 -0500
Subject: Re: [PATCH] Avoid calling get_irq_server() with a real, not
	virtual irq.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1166074809.11914.315.camel@localhost.localdomain>
References: <1166070941.5438.53.camel@kdsk1.austin.ibm.com>
	<1166074809.11914.315.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 06:46:16 -0600
Message-Id: <1166100376.5438.59.camel@kdsk1.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you set the priority level to 0xff, you've disabled the interrupt:
the XICS model prohibits it from being delivered.  


On the other hand, calling get_irq_server() is obviously wrong.
xics_remap_irq() calls xics_mask_real_irq() in the case that it was not
able to convert real->virt.  That being the case, how can we expect
xics_mask_real_irq to be able to do so in order to call
get_irq_server()?


-- 
Michal Ostrowski <mostrows@watson.ibm.com>


On Thu, 2006-12-14 at 16:40 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-12-13 at 22:35 -0600, Michal Ostrowski wrote:
> 
> > We can use default_server when masking an interrupt vector.
> 
> Is that guaranteed by PAPR ?
> 
> Ben.
> 
> 

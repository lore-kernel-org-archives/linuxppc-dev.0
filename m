Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E5DFDDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 21:37:49 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2BAZ7iX010752
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:35:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2BAbbrf192828
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:37:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2BAbajn007740
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:37:37 -0400
Date: Wed, 11 Mar 2009 06:37:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Message-ID: <20090311103716.GE26415@zod.rchland.ibm.com>
References: <49B58779.9040905@lebon.org.ua>
	<20090310195013.GA27835@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090310195013.GA27835@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 10:50:13PM +0300, Valentine Barshak wrote:
>I was just going to submit a patch for that too.
>Indeed, the denali_fixup_memsize() miscalculated a couple of address
>field widths. We were lucky to eventually get the right result,
>because the effect of the first error was killed by the other one.
>According to the AMCC 440EPX/GRX user manual,
>the Chip Select width is always fixed at 1 bit no matter
>what is actually read from register DDR_10.
>The workaround is to use a predefined chipselect value for 440EPx/GRx.
>Also, setting the REDUC bit (REDUC = 1) enables 32-bit data path.
>If REDUC = 0, full data path of 64 bits is used.
>
>Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>

I've been looking over this one a bit more.  At the moment, I'm inclined
to queue this up in my -next branch.  I would like to see if Mikhail
could test it though, and have Valentine answer the question in the hard
wired part.

josh

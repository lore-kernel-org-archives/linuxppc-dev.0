Return-Path: <lukebr@linux.vnet.ibm.com>
Received: from igw1.br.ibm.com (igw1.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw1.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29A5ADDF63
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 02:41:23 +1100 (EST)
Received: from mailhub1.br.ibm.com (mailhub1 [9.18.232.109])
	by igw1.br.ibm.com (Postfix) with ESMTP id 6A6AD32C202
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 13:35:47 -0200 (BRDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAQFfFBv2879612
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 13:41:15 -0200
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAQFfFiX023495
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 13:41:15 -0200
Subject: Re: [PATCH] ehea: Add kdump support
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1196064988.19855.15.camel@concordia>
References: <200711091433.51259.osstklei@de.ibm.com>
	<1196064988.19855.15.camel@concordia>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 13:41:37 -0200
Message-Id: <1196091697.7513.30.camel@luke-laptop.br.ibm.com>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-11-26 at 19:16 +1100, Michael Ellerman wrote:

> 
> Hi Thomas,
> 
> I'm sorry, but this patch is all wrong IMHO.
> 
> For kdump we have to assume that the kernel is fundamentally broken,
> we've panicked, so something bad has happened - every line of kernel
> code that is run decreases the chance that we'll successfully make it
> into the kdump kernel.

I agree with Michael.

> Solutions that might be better:
> 
>  a) if there are a finite number of handles and we can predict their 
>     values, just delete them all in the kdump kernel before the driver
>     loads.

This is a good solution if handles are predefined.

>  b) if there are a small & finite number of handles, save their values 
>     in a device tree property and have the kdump kernel read them and 
>     delete them before the driver loads.

Also good but is more complicated.  

>  c) if neither of those work, provide a minimal routine that _only_
>     deletes the handles in the crashed kernel.
>  d) <something else>

Can the driver or configuration method for the driver query PHYP to
determine if there are any pre-existing mappings... 

Regards, Luke

Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA5ACDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:21:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9LILtEj019311
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:21:55 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9LILtXN135796
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:21:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9LILsu5004565
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:21:55 -0400
Message-ID: <48FE1DBC.7030202@in.ibm.com>
Date: Tue, 21 Oct 2008 23:51:48 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Support for relocatable kdump kernel
References: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
	<1224485038.9055.34.camel@localhost> <48FC5097.5090908@in.ibm.com>
	<1224569019.8228.29.camel@localhost>
In-Reply-To: <1224569019.8228.29.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	kexec <kexec@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

> Does it? I see CONFIG_CRASH_DUMP depending on PPC64, so there is no
> 32-bit kdump possible. Or is someone working on it out-of-tree?
> 

IIUC Anton Vorontsov is working on the 32-bit kdump kernel support.

>> Do you expect a function to do the checking in iommu.c?
> 
> You'd use the function in iommu.c, but it should be defined in some
> header.
> 
Yeah, I will do that.

> OK. Does old purgatory ensure that the register is 0? Otherwise I think
> it's possible that a new kernel could get confused by cruft left in that
> register by an old purgatory - causing the 2nd kernel to think it's a
> kdump kernel when it shouldn't be.

__kdump_flag is by default is 0 and old purgatory code even won't know 
that it need to modify __kdump_flag. So unless __kdump_flag is 1, the 
kernel will behave as a normal one.

Regards,
Mohan.

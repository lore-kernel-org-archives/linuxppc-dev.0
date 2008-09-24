Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBCF4DE070
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 22:33:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8OCXfh1018834
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Sep 2008 08:33:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8OCXfcf121268
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Sep 2008 08:33:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8OCXf9n026395
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Sep 2008 08:33:41 -0400
Date: Wed, 24 Sep 2008 08:33:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Ayman El-Khashab" <AymanE@tanisys.com>
Subject: Re: How to use mtdcr from userland code
Message-ID: <20080924083339.4762c9eb@zod.rchland.ibm.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F7CC@tanisys-ex2.Tanisys.Local>
References: <5c9cd53b0809231156o3c24c053y26861d8f1cf24a93@mail.gmail.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F7CC@tanisys-ex2.Tanisys.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 23 Sep 2008 16:41:49 -0500
"Ayman El-Khashab" <AymanE@tanisys.com> wrote:

> Greetings,
> 
> I am developing an app that needs to map pci address space to the PLB on
> the ppc460ex.  From what I gather I need to use the mtcdr
> instruction/macro to configure the PIM0 space.  However, I cannot figure
> out how to use that from userland code.  Is it possible? 

Normally, no.  The mtdcr/mfdcr instructions are privileged
instructions.  On that particular core though, there are userspace dcr
instructions.  They are mtdcrux/mfdcrux instructions documented in the
CPU manual.

You will have to hard code them, as there are no versions of binutils
that I know of that will emit the userspace dcr instructions.

> Can I change the PIM some other way?

Yes, write a proper driver.

josh

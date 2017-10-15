Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFZtK1W8czDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 08:52:08 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9FLpwsa080299
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 17:52:06 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dme8aahtc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 17:52:06 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Sun, 15 Oct 2017 17:52:05 -0400
Subject: Re: [PATCH] powerpc/powernv: Enable reset_devices parameter to issue
 a PHB reset
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, maurosr@linux.vnet.ibm.com
References: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
 <87fuantpdk.fsf@concordia.ellerman.id.au>
 <1507972420.25065.270.camel@kernel.crashing.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Sun, 15 Oct 2017 19:51:59 -0200
MIME-Version: 1.0
In-Reply-To: <1507972420.25065.270.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <98200d15-41f9-e376-b870-472f78971735@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/14/2017 06:13 AM, Benjamin Herrenschmidt wrote:
> No, he's saying this is useful for the developers when debugging the
> kernel driver (or for asking users to "test" something as part of
> debugging a driver problem).
> 
> It's common to have various command line options affecting PCIe
> behaviour. I don't see a fundamental problem with this one.

Thanks Ben, very well explained.

> 
> One could argue in fact that we should always PERST everything, the
> main reason for not doing so is that on "normal" boot, OPAL has already
> done it and it would slow the boot process down.
> 
> My only objection here is the actual name of the argument. We've had a
> number of pci options so far, it makes sense to make sure we still have
> "pci" in the name.

I just wanted to take advantage of the already existing argument,
reset_devices. And..in fact, the PERST is a reset right?
But if you prefer, we can change it - pci_force_reset?
Suggestions are welcome.

> 
> Also having the driver do a "reset" is not always simple, we don't
> always have full control of PERST on a per-device basis. The patch
> proposed will PERST top level PHBs which will propagate as hot reset
> down switches, not 100% PERST but still useful.
> 

Exactly, this reset happens on early arch stage of PCI initialization,
not trivial to drivers perform it.

Anyway, let me know if you want a V2 with improvements or to drop it..I
still see use cases for this.

Thanks,


Guilherme

> Cheers,
> Ben.
> 

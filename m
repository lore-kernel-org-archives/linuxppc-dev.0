Return-Path: <wayneb@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BEECAB71D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:23:26 +1000 (EST)
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2BDA0DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:23:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5B3HNd5008894
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 23:17:23 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5B3NLGX150830
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 23:23:21 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5B3NL5W032155
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 23:23:21 -0400
Message-ID: <4A3078A7.20406@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2009 20:23:19 -0700
From: Wayne Boyer <wayneb@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: ipr boot failure caused by MSI (2.6.30-rc1+)
References: <1242926159.3007.5.camel@localhost.localdomain>
	<4A15A1B2.8060609@linux.vnet.ibm.com>
	<1242935515.3007.10.camel@localhost.localdomain>
	<1243009395.2873.18.camel@localhost.localdomain>
	<4A205B40.30306@linux.vnet.ibm.com>
In-Reply-To: <4A205B40.30306@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Brian King wrote:
> James Bottomley wrote:
>> On Thu, 2009-05-21 at 14:51 -0500, James Bottomley wrote:
>> I saw the quirk fix for this go by:
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072436.html
>>
>> Is there an easy way to trigger an interrupt on this device?  Preferably
>> in ipr_probe_ioa() so we can at least print out if the interrupts are
>> misrouted and fall back from MSI to normal using the PCI infrastructure?
> 
> I just talked with one of the adapter firmware developers and it sounds like
> this might be possible. I'll work with Wayne on coding something up to try.
> 
> -Brian
> 

I've put together some code to trigger the test MSI and either fall back to
LSI if it isn't detected, or continue on using MSI.  In the routine that
does the setup and test I have this call to request_irq:

rc = request_irq(pdev->irq, ipr_test_intr, 0, IPR_NAME, ioa_cfg);

Note that the flags value is '0'.  The question came up as to whether or
not this value should really be IRQF_SHARED.  Given that this is for an MSI
interrupt and MSI interrupts are not shared by definition, IRQF_SHARED did
not seem correct.

What should the flags value be in this case?


-- 
Wayne Boyer
IBM - Beaverton, Oregon
LTC S/W Development - eServerIO
(503) 578-5236, T/L 775-5236

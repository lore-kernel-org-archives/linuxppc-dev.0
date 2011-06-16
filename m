Return-Path: <brking@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6F8DB6FB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 23:28:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5GCvu9X004813
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 08:57:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5GDSejF141592
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 09:28:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5GDSeMo004981
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2011 10:28:40 -0300
Message-ID: <4DFA0507.3090609@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2011 08:28:39 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: libata/ipr/powerpc: regression between 2.6.39-rc4 and 2.6.39-rc5
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
In-Reply-To: <20110616075114.GH8141@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jgarzik@pobox.com, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, mbizon@freebox.fr,
	Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2011 02:51 AM, Tejun Heo wrote:
> On Wed, Jun 15, 2011 at 04:34:17PM -0700, Nishanth Aravamudan wrote:
>>> That looks like the right thing to do. For ipr's usage of
>>> libata, we don't have the concept of a port frozen state, so this flag
>>> should really never get set. The alternate way to fix this would be to
>>> only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
>>> is not NULL.
>>
>> It seemed like ipr is as you say, but I wasn't sure if it was
>> appropriate to make the change above in the common libata-scis code or
>> not. I don't want to break some other device on accident.
>>
>> Also, I tried your suggestion, but I don't think that can happen in
>> ata_port_alloc? ata_port_alloc is allocated ap itself, and it seems like
>> ap->ops typically gets set only after ata_port_alloc returns?
> 
> Maybe we can test error_handler in ata_sas_port_start()?

Good point. Since libsas is converted to the new eh now, we would need to have
this test.

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

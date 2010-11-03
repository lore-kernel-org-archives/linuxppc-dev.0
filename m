Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3B96B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 23:49:40 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA3CWTYU022941
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Nov 2010 08:32:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA3CnalZ392726
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Nov 2010 08:49:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oA3CnZu6021847
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Nov 2010 10:49:36 -0200
Date: Wed, 3 Nov 2010 08:48:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATHC v1] PPC4xx: Adding PCI(E) MSI support
Message-ID: <20101103124840.GA25950@zod.rchland.ibm.com>
References: <1288306514-9769-1-git-send-email-tmarri@apm.com>
	<1288786293.989.65.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288786293.989.65.camel@concordia>
Cc: tmarri@apm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 03, 2010 at 11:11:33PM +1100, Michael Ellerman wrote:
>> +	struct device_node *msi_dev = NULL;
>> +	const u32 *count;
>> +
>> +	msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
>> +	if (msi_dev)
>> +		return -ENODEV;
>> +

You also leak a reference to the node here, as there is never a call to
of_node_put.

josh

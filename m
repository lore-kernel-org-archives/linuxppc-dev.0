Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkn3S2R9hzDqvK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 13:55:48 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u663sUdN141226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 23:55:45 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nf1qa37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 23:55:45 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 6 Jul 2016 13:55:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 077BB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 13:55:41 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u663tfct10027336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 13:55:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u663teKT029833
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 13:55:40 +1000
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 6 Jul 2016 13:55:39 +1000
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <df2f8c9f-94dd-44a2-fa89-e3fc7f35449b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 23:22, Ian Munsie wrote:
> +static int setup_cxl_protocol_area(struct pci_dev *dev)
> +{
> +	u8 val;
> +	int rc;
> +	int vsec = find_cxl_vsec(dev);
> +
> +	if (!vsec) {
> +		dev_info(&dev->dev, "CXL VSEC not found\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = CXL_READ_VSEC_MODE_CONTROL(dev, vsec, &val);
> +	if (rc) {
> +		dev_err(&dev->dev, "Failed to read current mode control: %i\n", rc);
> +		return rc;
> +	}
> +
> +	if (!(val & CXL_VSEC_PROTOCOL_ENABLE)) {
> +		dev_err(&dev->dev, "Card not in CAPI mode!\n");
> +		return -EIO;
> +	}
> +
> +	/* Still configure the protocol area for single mode cards */

This comment is extraneous and will be dropped in V2.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

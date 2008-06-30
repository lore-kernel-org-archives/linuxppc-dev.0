Return-Path: <brking@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67403DDFCA
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 08:05:09 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5UM0E0h018014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 18:00:15 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5ULv4dl022284
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 17:57:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5ULv0XR034192
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 15:57:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5ULux5r020382
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 15:57:00 -0600
Message-ID: <486956A6.2070806@linux.vnet.ibm.com>
Date: Mon, 30 Jun 2008 16:56:54 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 08/18 v2] powerpc: Do not probe PCI buses or eBus devices
	if CMO is enabled
References: <20080625201202.GB17020@linux.vnet.ibm.com>
	<20080625201721.GJ17020@linux.vnet.ibm.com>
	<18536.25052.228270.743669@cargo.ozlabs.ibm.com>
In-Reply-To: <18536.25052.228270.743669@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Robert Jennings writes:
> 
>> From: Brian King <brking@linux.vnet.ibm.com>
>>
>> The Cooperative Memory Overcommit (CMO) on System p does not currently
>> support native PCI devices or eBus devices when enabled.
> 
> Then why would we get any native PCI or eBus devices in the device
> tree?

We shouldn't. The reason the patch exists is so that *if* firmware were to
add support for physical PCI/eBus devices in CMO mode in the future, then
we could get into a scenario where there are such devices in the device
tree and we would want to prevent them from getting initialized
on a kernel without the code needed to support such a feature.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

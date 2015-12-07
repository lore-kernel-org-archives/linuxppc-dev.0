Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EEED1A0D9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 05:50:08 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Mon, 7 Dec 2015 11:50:05 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0785F19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 11:38:09 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB7Io3NI19726502
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 11:50:03 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB7Io2UH032104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2015 11:50:03 -0700
Subject: Re: [PATCH net-next] Driver for IBM System i/p VNIC protocol
To: David Miller <davem@davemloft.net>
References: <1449251386-13476-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20151205.222551.512793392902323297.davem@davemloft.net>
Cc: netdev@vger.kernel.org, nguyendo@us.ibm.com, jallen@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Message-ID: <5665D4D8.7010206@linux.vnet.ibm.com>
Date: Mon, 7 Dec 2015 12:50:00 -0600
MIME-Version: 1.0
In-Reply-To: <20151205.222551.512793392902323297.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2015 09:25 PM, David Miller wrote:
> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Date: Fri,  4 Dec 2015 11:49:46 -0600
>
>> +static int ibmvnic_buffs_per_pool = IBMVNIC_BUFFS_PER_POOL;
>> +module_param(ibmvnic_buffs_per_pool, int, S_IRUGO);
>> +MODULE_PARM_DESC(ibmvnic_buffs_per_pool,
>> +		 "IBMVNIC number of buffers per rx pool");
> Please do not use module parameters for settings that effect
> the basic operation of the driver.

Hi. Thanks for you feedback.  Could you clarify on what constitutes basic operation?  I just want to be sure if we should remove the other module parameters or just this one in particular?

>
> Instead use facilities that are generic and provide the same
> user interface for all networking drivers, such as ethtool.

Is it possible to change driver settings like this with ethtool? Would adding an interface in sysfs to change this setting be acceptable?

>
> Otherwise users would need to learn a different way to configure the
> same thing on different devices, which is not acceptable.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

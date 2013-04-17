Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 054142C0151
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 15:19:39 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 17 Apr 2013 15:10:24 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D13592BB0056
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 15:19:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3H5JOfG6029730
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 15:19:25 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3H5JTs4022415
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 15:19:29 +1000
Message-ID: <516E30DC.5070601@linux.vnet.ibm.com>
Date: Wed, 17 Apr 2013 10:49:24 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/8] Read/Write oops nvram partition via pstore
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072303.20150.61382.stgit@aruna-ThinkPad-T420>
 <20130415075555.GE30156@concordia> <516CEDB4.9090005@linux.vnet.ibm.com>
In-Reply-To: <516CEDB4.9090005@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 16 April 2013 11:50 AM, Aruna Balakrishnaiah wrote:
>
> Currently with this patchset, pstore is not supporting compression of 
> oops-messages
> since it involves some changes in the pstore framework.
>
> big_oops_buf will hold the large part of oops data which will be compressed 
> and put
> to oops_buf.
>
> big_oops_buf: (1.45 of oops_partition_size)

Sorry, big_oops_buf is (2.22 of oops_data_sz)

where oops_data_sz is oops_partition_size - sizeof(oops_log_info).

where oops_log_info is oops header.

> _________________________
> |  header |   oops-text |
> |_________|_____________|
>
> <header> is added by the pstore.
>
> So in case compression fails:
>
> we would need to log the header + last few bytes of big_oops_buf to oops_buf.
> oops_buf: (this is of oops_partition_size)
>

We would need to log the header + last oops_data_sz bytes of big_oops_buf to 
oops_buf.
So that we can have the header while throwing away the data that immediately
follows it.

> we need last few bytes of big_oops_buf as we need to log the recent messages of
> printk buffer. For which we need to know the header size and it involves some
> changes in the pstore framework.
>

Just communicating the header size from pstore would do the job for us.

> I have the compression patches ready, will be posting it soon as a separate set.
>
>> cheers
>>
>

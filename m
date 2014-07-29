Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27B4C1A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 03:55:57 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 13:55:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 41708C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 13:55:45 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6THtqpt8519988
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 17:55:52 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6THsmUA018135
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 13:54:48 -0400
Message-ID: <53D7DFE7.8000304@linux.vnet.ibm.com>
Date: Tue, 29 Jul 2014 10:54:47 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pci: reorder pci bus/bridge unregistration during
 PHB removal
References: <1406594911-7097-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1406598256.11977.1.camel@concordia>
In-Reply-To: <1406598256.11977.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2014 06:44 PM, Michael Ellerman wrote:
> On Mon, 2014-07-28 at 20:48 -0400, Tyrel Datwyler wrote:
>> Commit bcdde7e made __sysfs_remove_dir() recursive and introduced a BUG_ON
>> during PHB removal while attempting to delete the power managment attribute
>> group of the bus. This is a result of tearing the bridge and bus devices down
>> out of order in remove_phb_dynamic. Since, the the bus resides below the bridge
>> in the sysfs device tree it should be torn down first.
>>
>> This patch simply moves the device_unregister call for the PHB bridge device
>> after the device_unregister call for the PHB bus.
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> 
> That commit went into 3.13, so shouldn't this be CC to stable?

Darn it. Yes, it should.

> 
> And also:
> 
>   Fixes: bcdde7e221a8 ("sysfs: make __sysfs_remove_dir() recursive")
> 
> cheers
> 
> 

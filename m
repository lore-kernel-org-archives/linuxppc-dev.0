Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYWW63N6jzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:14:10 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2Dv3G069512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:14:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2fyg6v1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:14:07 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 20:14:07 -0600
Subject: Re: [PATCH] powerpc/pseries: Auto online hotplugged memory
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <5767F4D0.7070504@linux.vnet.ibm.com>
 <1466470648.9938.0.camel@ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 21:14:03 -0500
MIME-Version: 1.0
In-Reply-To: <1466470648.9938.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5768A2EB.5030808@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2016 07:57 PM, Michael Ellerman wrote:
> On Mon, 2016-06-20 at 08:51 -0500, Nathan Fontenot wrote:
> 
>> Auto online hotplugged memory
>>
>> A recent update (commit id 31bc3858ea3) to the core mm hotplug code
>> introduced the memhp_auto_online variable to allow for automatically
>> onlining memory that is added.
>>
>> This patch update the pseries memory hotplug code to enable this so that
>> any memory DLPAR added to the system is automatically onlined. The code
>> to add the memory block for memory added from add_memory() is removed as
>> this is not needed, the memory_add code does this.
> 
> Is this a bug fix, or just a cleanup?
> 

Hmmm.. some cleanup and some new feature. The removal of the memblock_add()
call is a cleanup and the setting of the memhp_auto_online variable is
taking advantage of a feature I was not previously aware of.

None of this is a bug fix.

-Nathan

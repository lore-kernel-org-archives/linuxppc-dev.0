Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0b-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNNcf6qQfzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 15:32:18 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u565TNk9048951
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 01:32:17 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23br4sqxer-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 01:32:16 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 6 Jun 2016 15:32:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 725202CE8062
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 15:32:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u565Vu9E45547670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 15:31:56 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u565VofN002473
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 15:31:50 +1000
Date: Mon, 06 Jun 2016 13:31:30 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, tglx@linutronix.de,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: powerpc/nvram: Fix an incorrect partition merge
References: <3rLj4P6Swcz9t6B@ozlabs.org>
In-Reply-To: <3rLj4P6Swcz9t6B@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <57550AB2.8090500@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月03日 19:47, Michael Ellerman wrote:
> On Thu, 2015-10-12 at 07:30:02 UTC, xinhui wrote:
>> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>
>> When we merge two contiguous partitions whose signatures are marked
>> NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
>> to nvram, not cur's. So lets fix this mistake now.
>>
>> Also use memset instead of strncpy to set the partition's name. It's
>> more readable if we want to fill up with duplicate chars .
>
> Does this ever happen in practice? ie. should we backport the fix to stable
> kernels?
>

I did not see that nvram warning in practice. BUT I suggest to backport it to stable kernel. :)

Let me recall the story. :)
In past days, I was using pstore to keep some kernel logs. and sometimes I found my own logs and the panic logs did not show.
pstore use a fixed-address reserved memory In x86 while nvram instead in ppc.

Then I spent some days to review the nvram codes.
And worked out three patches to fix all issues that I found in nvram. BUT looks like I only sent out two of them. :)
I lost the third patch maybe...

> Has it always been broken?
>

no. after nvram partition corruption hit, all nvram partitions will be erased and re-alloc after the second machine reboot.
I don't know who does it but i guess it is the firmware. :)

thanks
xinhui
> cheers
>

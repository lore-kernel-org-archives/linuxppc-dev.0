Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DB011A021C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 14:00:59 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 22 Jul 2014 09:30:56 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F19F3E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 09:32:32 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6M41Fdm11665914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 09:31:15 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6M40pah026584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 09:30:52 +0530
Message-ID: <53CDE1EC.4040202@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 12:00:44 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
References: <53A91819.1010900@linux.vnet.ibm.com>
 <1403591761.4587.161.camel@pasglop> <53A9216C.8050904@linux.vnet.ibm.com>
 <1403593252.4587.163.camel@pasglop> <20140625000305.GA5742@shangw>
 <53AA3C5C.4080807@linux.vnet.ibm.com> <1403666349.4587.196.camel@pasglop>
 <53CCCA09.1060404@linux.vnet.ibm.com> <1405982949.5289.217.camel@pasglop>
 <53CDD632.1050908@linux.vnet.ibm.com> <20140722032605.GA31107@shangw>
In-Reply-To: <20140722032605.GA31107@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2014 11:26 AM, Gavin Shan wrote:
> On Tue, Jul 22, 2014 at 11:10:42AM +0800, Mike Qiu wrote:
>> On 07/22/2014 06:49 AM, Benjamin Herrenschmidt wrote:
>>> On Mon, 2014-07-21 at 16:06 +0800, Mike Qiu wrote:
>>>>> I don't like this. I much prefer have dedicated error injection files
>>>>> in their respective locations, something for PCI under the corresponding
>>>>> PCI bridge etc...
>>>> So PowerNV error injection will be designed rely on debugfs been
>>>> configured, right?
>>> Not necessarily. If we create a better debugfs layout for our PHBs, then
>>> yes. It might be useful to provide more info in there for example access
>>> to some of the counters ...
>>>
>>> But on the other hand, for error injection in general, I wonder if we should
>>> be under sysfs instead... something to study a bit.
>> In pHyp, general error injection use syscall:
>>
>>     #define __NR_rtas        255
>>
>> I don't know if it is a good idea to reuse this syscall for PowerNV.
>>
>> At least, it is another choice without sysfs rely.
>>
> We won't use syscall for routing the error injection on PowerNV any more.
> Generally speaking, we will use ioctl commands or subcode of EEH ioctl
> command, which was invented for EEH support for VFIO devices to suport
> QEMU. For the utility (errinjct) running on PowerNV, we will use debugfs
> entries. I have premature code for that, but don't have chance to polish
> it yet. Let me send you that so that you can start working from there.

OK, thanks
> Thanks,
> Gavin
>
>
>

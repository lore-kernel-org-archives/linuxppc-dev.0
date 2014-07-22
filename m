Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDB111A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 13:26:04 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 22 Jul 2014 13:26:04 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3EA0B2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 13:26:03 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6M3Pkr63539372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 13:25:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6M3Q2o9009519
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 13:26:02 +1000
Date: Tue, 22 Jul 2014 13:26:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
Message-ID: <20140722032605.GA31107@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <53A91819.1010900@linux.vnet.ibm.com>
 <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com>
 <1403593252.4587.163.camel@pasglop> <20140625000305.GA5742@shangw>
 <53AA3C5C.4080807@linux.vnet.ibm.com>
 <1403666349.4587.196.camel@pasglop>
 <53CCCA09.1060404@linux.vnet.ibm.com>
 <1405982949.5289.217.camel@pasglop>
 <53CDD632.1050908@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53CDD632.1050908@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2014 at 11:10:42AM +0800, Mike Qiu wrote:
>On 07/22/2014 06:49 AM, Benjamin Herrenschmidt wrote:
>>On Mon, 2014-07-21 at 16:06 +0800, Mike Qiu wrote:
>>>>I don't like this. I much prefer have dedicated error injection files
>>>>in their respective locations, something for PCI under the corresponding
>>>>PCI bridge etc...
>>>So PowerNV error injection will be designed rely on debugfs been
>>>configured, right?
>>Not necessarily. If we create a better debugfs layout for our PHBs, then
>>yes. It might be useful to provide more info in there for example access
>>to some of the counters ...
>>
>>But on the other hand, for error injection in general, I wonder if we should
>>be under sysfs instead... something to study a bit.
>
>In pHyp, general error injection use syscall:
>
>    #define __NR_rtas        255
>
>I don't know if it is a good idea to reuse this syscall for PowerNV.
>
>At least, it is another choice without sysfs rely.
>

We won't use syscall for routing the error injection on PowerNV any more.
Generally speaking, we will use ioctl commands or subcode of EEH ioctl
command, which was invented for EEH support for VFIO devices to suport
QEMU. For the utility (errinjct) running on PowerNV, we will use debugfs
entries. I have premature code for that, but don't have chance to polish
it yet. Let me send you that so that you can start working from there.

Thanks,
Gavin 

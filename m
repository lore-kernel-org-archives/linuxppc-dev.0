Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A69C1A0983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 13:10:52 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 22 Jul 2014 08:40:48 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0B1A23940048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:40:45 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6M3B6Kk1900820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:41:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6M3Aim0008255
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:40:44 +0530
Message-ID: <53CDD632.1050908@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 11:10:42 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com> <1403593252.4587.163.camel@pasglop>
 <20140625000305.GA5742@shangw> <53AA3C5C.4080807@linux.vnet.ibm.com>
 <1403666349.4587.196.camel@pasglop> <53CCCA09.1060404@linux.vnet.ibm.com>
 <1405982949.5289.217.camel@pasglop>
In-Reply-To: <1405982949.5289.217.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2014 06:49 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-07-21 at 16:06 +0800, Mike Qiu wrote:
>>> I don't like this. I much prefer have dedicated error injection files
>>> in their respective locations, something for PCI under the corresponding
>>> PCI bridge etc...
>> So PowerNV error injection will be designed rely on debugfs been
>> configured, right?
> Not necessarily. If we create a better debugfs layout for our PHBs, then
> yes. It might be useful to provide more info in there for example access
> to some of the counters ...
>
> But on the other hand, for error injection in general, I wonder if we should
> be under sysfs instead... something to study a bit.

In pHyp, general error injection use syscall:

     #define __NR_rtas        255

I don't know if it is a good idea to reuse this syscall for PowerNV.

At least, it is another choice without sysfs rely.

Thanks,
Mike

>
> Cheers,
> Ben.
>
>
>

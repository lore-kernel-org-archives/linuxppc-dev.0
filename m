Return-Path: <srs0=mv+f=ab=linux.vnet.ibm.com=brking@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjmYR592pzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 01:31:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xjmYR4jdFz8t2N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 01:31:07 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xjmYR18W9z9sD5
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2017 01:31:06 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7VFOxwk114267
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2017 11:31:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cpjw8rucs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2017 11:31:04 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 09:31:04 -0600
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill@us.ibm.com" <dougmill@us.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 10:31:00 -0500
MIME-Version: 1.0
In-Reply-To: <877exjud52.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/31/2017 07:37 AM, Michael Ellerman wrote:
> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
> 
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
>>> flip it back to being a module.
>>
>> Yeah. We tend to keep all RAID adapters as modules because they almost
>> all uniquely try to undo all boot time optimization done by anybody,
>> anywhere, ever.
> 
> Yes I know what you mean. I am thinking of one In ParticulaR.

Ouch. In all fairness over the life of ipr I've done a couple things to
improve initialization time.

1. On a PowerVM machine, the ipr boot device should not get reset between
   the FCODE driver and the Linux driver, so init is extremely fast. If its
   a non-boot device, then you'll have to wait for the firmware to initialize
   on those adapters.
2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
   kernel, then we should also avoid resetting the ipr adapter, so ipr
   init on the kernel being kexec booted from skiboot should be extremely fast. 

As to improving ipr init time in the skiboot kernel, that becomes more
difficult to do safely. The firmware stack still needs to boot, do device
discovery, potentially spin up disks, etc, which all takes time.

Additionally, we put in changes in the firmware and driver to address
complaints largely from Anton about it taking too long for ipr to timeout on
bad adapters.

If you've got cases where ipr init is taking a long time, I'd be
interested to know what scenarios are the most annoying to see if there
is any opportunity to improve.

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

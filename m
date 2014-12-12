Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4A71A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:07:17 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0ED6D14009B
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 15:07:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 14:07:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 535502CE807F
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 15:07:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBC479gT19136754
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 15:07:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBC478NT031647
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2014 15:07:09 +1100
Message-ID: <548A69E0.3090802@linux.vnet.ibm.com>
Date: Fri, 12 Dec 2014 09:36:56 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: powerpc/kdump: skip enabling big endian exception during crash
References: <20141211224016.86E111400F1@ozlabs.org>
In-Reply-To: <20141211224016.86E111400F1@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2014 04:10 AM, Michael Ellerman wrote:
> On Thu, 2014-11-12 at 16:44:54 UTC, Hari Bathini wrote:
>> In LE kernel, we currently have a hack for kexec that resets the exception endian
>> before starting a new kernel as the kernel that is loaded could be a big endian
>> or a little endian kernel. In kdump case, resetting exception endian fails when
>> one or more cpus is disabled. But in case of kdump, we can conveniently ignore
>> resetting endianess as crashkernel is always of same endianess as primary kernel.
> 
> No, it's not guaranteed to be the same endianess.
> 
> That tends to be what people do in practice, but it's not an assumption you can
> hard code.

Agree. The other solution could be to wakeup offline CPUs in crash path
as we do it in normal kexec path. PHYP expects all partitions processors
MSR[EE] = 0 while we call pseries_big_endian_exceptions(). Waking up
offline CPUs will help to achieve that. But since we are already in
crashed kernel context I am not sure how safe is to call
wake_offline_cpus().

Thanks,
-Mahesh.

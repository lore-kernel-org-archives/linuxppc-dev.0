Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 125611A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 02:02:50 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5990140321
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 02:02:49 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 01:02:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 625D03578052
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 02:02:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12F28Oq35717358
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 02:02:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12F279M000384
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 02:02:08 +1100
Subject: Re: [PATCH] ppc64 boot: Wait for boot cpu to show up if nr_cpus limit
 is about to hit.
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <20160201171444.3781.86591.stgit@mars.in.ibm.com>
 <CAOJe8K2OpwYwVaG5nT-H8wCw8HbTEyE1zejZCO-MDh70+8J+xg@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Milton Miller <miltonm@us.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Message-ID: <56B0C4DC.7070909@linux.vnet.ibm.com>
Date: Tue, 2 Feb 2016 20:31:48 +0530
MIME-Version: 1.0
In-Reply-To: <CAOJe8K2OpwYwVaG5nT-H8wCw8HbTEyE1zejZCO-MDh70+8J+xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 07:28 PM, Denis Kirjanov wrote:
> On 2/1/16, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The kernel boot parameter 'nr_cpus=' allows one to specify number of
>> possible cpus in the system. In the normal scenario the first cpu (cpu0)
>> that shows up is the boot cpu and hence it gets covered under nr_cpus
>> limit.
>>
>> But this assumption will be broken in kdump scenario where kdump kenrel
>> after a crash can boot up on an non-zero boot cpu. The paca structure
>> allocation depends on value of nr_cpus and is indexed using logical cpu
>> ids. This definetly will be an issue if boot cpu id > nr_cpus
> And what happend in this case? Have you tried it out?

Yes I have. It results into memory corruption when
set_hard_smp_processor_id(boot_cpu_id,..) is called from
early_init_dt_scan_cpus() and then kernel fails to boot. Nothing shows
up in console and system hangs forever.

You can easily reproduce this by configuring kdump service to use
'nr_cpus=1' instead of 'maxcpus=1' and then trigger system crash from
any cpu other than 0

e.g.  $ taskset -c 10 echo c > /proc/sysrq-trigger

Thanks,
-Mahesh.

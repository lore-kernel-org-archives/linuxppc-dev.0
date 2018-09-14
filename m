Return-Path: <srs0=15fs=l4=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BfnZ0PxHzF3XY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:38:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42BfnY6pByz8tPq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:38:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42BfnY2Nvtz9s9N
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2018 01:38:57 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8EFZMTf127561
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2018 11:38:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mge3552c5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2018 11:38:54 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 14 Sep 2018 16:38:53 +0100
Subject: Re: [PATCH] powerpc/fadump: re-register firmware-assisted dump if
 already registered
To: Petr Tesarik <ptesarik@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
 <20180914162822.6b489d57@ezekiel.suse.cz>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 14 Sep 2018 21:08:46 +0530
MIME-Version: 1.0
In-Reply-To: <20180914162822.6b489d57@ezekiel.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <299e24c7-28a1-9e82-4c9f-e830766b0573@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 14 September 2018 07:58 PM, Petr Tesarik wrote:
> On Fri, 14 Sep 2018 19:36:02 +0530
> Hari Bathini <hbathini@linux.ibm.com> wrote:
>
>> Firmware-Assisted Dump (FADump) needs to be registered again after any
>> memory hot add/remove operation to update the crash memory ranges. But
>> currently, the kernel returns '-EEXIST' if we try to register without
>> uregistering it first. This could expose the system to racing issues
>> while unregistering and registering FADump from userspace during udev
>> events. Spare the userspace of this and let it be taken care of in the
>> kernel space for a simpler interface.
>>
>> Since this change, running 'echo 1 > /sys/kernel/fadump_registered'
>> would result in re-regisering (unregistering and registering) FADump,
>> if it was already registered.
> Great improvement to the API!
>
> Any suggestions what should be done in a client which tries to be
> compatible with kernels before this change and after this change?

If `echo 1 > /sys/kernel/fadump_registered` fails, check for the output
of  `cat /sys/kernel/fadump_registered` and if it is still `1`, that 
indicates
old kernel and we are already registered. Treat it as success if being
registered is what we care about or unregister/register (if re-register
is the intention)..

Hope that helps..

Thanks
Hari

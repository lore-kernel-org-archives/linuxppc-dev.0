Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjYDf0yJnzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 02:00:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v57Fx2Hj080789
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 12:00:31 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2axkg0m363-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 12:00:31 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 8 Jun 2017 02:00:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v57G0P7S1048938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 02:00:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v57G0Ikm018130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 02:00:18 +1000
Date: Wed, 7 Jun 2017 21:30:15 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: ?????????? <1363017608@qq.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: power server power consumption problem
Reply-To: svaidy@linux.vnet.ibm.com
References: <tencent_14A522610506039258ACD095@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <tencent_14A522610506039258ACD095@qq.com>
Message-Id: <20170607160015.GA13031@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* ?????????? <1363017608@qq.com> [2017-06-06 19:59:24]:

> I use ipmitool measuring power server power consumption, getting the following results without total power consumption as the following picture, do I add all power values as total power consumption? I am eager to receive someone's replay??Thanks?

The total system power is already aggregates as provided under ipmi
dcmi command.

You can read it like:

Inband: (within system)

root@ubuntu:~# ipmitool dcmi power reading

    Instantaneous power reading:                   485 Watts
    Minimum during sampling period:                485 Watts
    Maximum during sampling period:                486 Watts
    Average power reading over sample period:      485 Watts
    IPMI timestamp:                           Wed Jun  7 15:53:08 2017
    Sampling period:                          00000010 Seconds.
    Power reading state is:                   activated

Out-of-band: (Over BMC network)

[sv@drishya] ~ % ipmitool -I lanplus -H bmc -U bmc-user -P bmc-pw  dcmi power reading

    Instantaneous power reading:                   486 Watts
    Minimum during sampling period:                483 Watts
    Maximum during sampling period:                486 Watts
    Average power reading over sample period:      484 Watts
    IPMI timestamp:                           Wed Jun  7 15:54:11 2017
    Sampling period:                          00000010 Seconds.
    Power reading state is:                   activated


You do get component power consumption from IPMI SDR, you can get
those from inband or out-of-band. But you need not manually add it up.
On-Chip-Controller (OCC) does the power aggregation already and
exports it through DCMI power reading.

--Vaidy

Return-Path: <srs0=8qo8=4l=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKDrc0ZcQzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 00:32:48 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wKDrb6t75z8tBf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 00:32:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wKDrb2qLyz9s7f
 for <linuxppc-dev@ozlabs.org>; Sat,  6 May 2017 00:32:47 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v45ET24T087306
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 10:32:41 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a8tphhqe4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 May 2017 10:32:40 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 6 May 2017 00:32:34 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v45EWNGt4456724
 for <linuxppc-dev@ozlabs.org>; Sat, 6 May 2017 00:32:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v45EVwVP015492
 for <linuxppc-dev@ozlabs.org>; Sat, 6 May 2017 00:31:58 +1000
Subject: Re: [PATCH 2/2] powerpc/fadump: avoid holes in boot memory area when
 fadump is registered
To: Pingfan Liu <piliu@redhat.com>
References: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
 <149392044508.10802.11008391107873058533.stgit@hbathini.in.ibm.com>
 <935304973.5269011.1493984598730.JavaMail.zimbra@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 20:01:27 +0530
MIME-Version: 1.0
In-Reply-To: <935304973.5269011.1493984598730.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f196024d-a78c-c30f-fb51-02d9cffa16c2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 05 May 2017 05:13 PM, Pingfan Liu wrote:
>
>
>
> ----- Original Message -----
>> From: "Hari Bathini" <hbathini@linux.vnet.ibm.com>
>> To: "Michael Ellerman" <mpe@ellerman.id.au>
>> Cc: "linuxppc-dev" <linuxppc-dev@ozlabs.org>, "Pingfan Liu" <piliu@redhat.com>, "Mahesh J Salgaonkar"
>> <mahesh@linux.vnet.ibm.com>
>> Sent: Friday, May 5, 2017 1:54:05 AM
>> Subject: [PATCH 2/2] powerpc/fadump: avoid holes in boot memory area when fadump is registered
>>
>> To register fadump, boot memory area - the size of low memory chunk that
>> is required for a kernel to boot successfully when booted with restricted
>> memory, is assumed to have no holes. But this memory area is currently
> The continuous is required by fadump code, not by the firmware itself, right?
>

Hmmm... Firmware takes a memory region,what we are calling boot memory
area, as input to be backed up at the time of crash. The same memory
region is used by kernel to boot after the crash. Firmware doesn't allow
holes in this memory region at the time of registering...

Thanks
Hari

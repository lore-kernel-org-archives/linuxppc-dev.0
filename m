Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnsPr1xzSzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 14:22:24 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6B4IiGj027516
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 00:22:22 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242t5eg0xu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 00:22:22 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 11 Jul 2016 14:22:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A96C62CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 14:22:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6B4M4iM22741224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 14:22:04 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6B4M48B020507
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 14:22:04 +1000
Subject: Re: [PATCH] powerpc/crash: Rearrange loop condition to avoid out of
 bounds array access
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1468210651-4199-1-git-send-email-sjitindarsingh@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 11 Jul 2016 14:22:02 +1000
MIME-Version: 1.0
In-Reply-To: <1468210651-4199-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fbc15551-6594-9744-54e1-ac99313b431b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 14:17, Suraj Jitindar Singh wrote:
> The array crash_shutdown_handles[] has size CRASH_HANDLER_MAX, thus when
> we loop over the elements of the list we check crash_shutdown_handles[i]
> && i < CRASH_HANDLER_MAX. However this means that when we increment i to
> CRASH_HANDLER_MAX we will perform an out of bound array access checking
> the first condition before exiting on the second condition.
>
> To avoid the out of bounds access, simply reorder the loop conditions.
>
> Fixes Coverity bug #128232
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Fixes: 1d1451655bad ("powerpc: Add array bounds checking to 
crash_shutdown_handlers")
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

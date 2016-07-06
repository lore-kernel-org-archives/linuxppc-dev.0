Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkp5816bvzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:42:19 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u664chlw077258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 00:42:17 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240ndngbfg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 00:42:17 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 6 Jul 2016 14:42:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C0C73578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:42:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u664gBUt66322490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:42:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u664gAcs004717
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:42:11 +1000
Subject: Re: [PATCH 11/14] cxl: Workaround PE=0 hardware limitation in
 Mellanox CX4
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-12-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 6 Jul 2016 14:42:10 +1000
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-12-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0d931e16-5160-1d0a-c42b-af13be323a77@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 23:22, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The CX4 card cannot cope with a context with PE=0 due to a hardware
> limitation, resulting in:
>
> [   34.166577] command failed, status limits exceeded(0x8), syndrome 0x5a7939
> [   34.166580] mlx5_core 0000:01:00.1: Failed allocating uar, aborting
>
> Since the kernel API allocates a default context very early during
> device init that will almost certainly get Process Element ID 0 there is
> no easy way for us to extend the API to allow the Mellanox to inform us
> of this limitation ahead of time.
>
> Instead, work around the issue by extending the XSL structure to include
> a minimum PE to allocate. Although the bug is not in the XSL, it is the
> easiest place to work around this limitation given that the CX4 is
> currently the only card that uses an XSL.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

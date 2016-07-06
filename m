Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl8ks1swXzDr31
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 04:42:44 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Iderq118222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:42:43 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkbndw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 14:42:42 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 19:42:40 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16BAA17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:44:02 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66Igc2110027284
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:42:38 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66Igbqr029407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:42:38 -0600
Subject: Re: [PATCH 11/14] cxl: Workaround PE=0 hardware limitation in
 Mellanox CX4
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-12-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 20:42:36 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-12-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D511C.9050601@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:22, Ian Munsie a écrit :
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

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

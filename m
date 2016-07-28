Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0QS05w8SzDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 18:45:52 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6S8i1Jg043977
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 04:45:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24fcm4wcmx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 04:45:50 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 28 Jul 2016 09:45:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 801EA2190068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 09:45:12 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6S8jjYw39583786
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 08:45:45 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6S8jjMf001360
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 02:45:45 -0600
Subject: Re: [PATCH] cxl: fix NULL dereference in cxl_context_init() on
 PowerVM guests
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
Cc: imunsie@au1.ibm.com, huyn@mellanox.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 28 Jul 2016 10:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4835de25-fb85-35b2-8ccb-6ddc6a4704e6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/07/2016 à 07:39, Andrew Donnellan a écrit :
> Commit f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox
> CX4") added a "min_pe" field to struct cxl_service_layer_ops, to allow us
> to work around a Mellanox CX-4 hardware limitation.
>
> When allocating the PE number in cxl_context_init(), we read from
> ctx->afu->adapter->native->sl_ops->min_pe to get the minimum PE number.
> Unsurprisingly, in a PowerVM guest ctx->afu->adapter->native is NULL, and
> guests don't have a cxl_service_layer_ops struct anywhere.
>
> Move min_pe from struct cxl_service_layer_ops to struct cxl so it's
> accessible in both native and PowerVM environments. For the Mellanox CX-4,
> set the min_pe value in set_sl_ops().
>
> Fixes: f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox CX4")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

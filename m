Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0FC80Qw7zDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:49:07 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6S1medm083990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:49:05 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24e1h9xam0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:49:05 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 28 Jul 2016 11:49:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 06F9A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:49:01 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6S1n0A229556758
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:49:00 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6S1n0Ro022846
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:49:00 +1000
Subject: Re: [PATCH 12/15] cxl: Workaround PE=0 hardware limitation in
 Mellanox CX4
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
 <1468444634-1866-13-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 28 Jul 2016 11:48:29 +1000
MIME-Version: 1.0
In-Reply-To: <1468444634-1866-13-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fe95e17a-908c-b7f8-2b07-d1d1d227bdab@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 07:17, Ian Munsie wrote:
>  	mutex_lock(&afu->contexts_lock);
>  	idr_preload(GFP_KERNEL);
> -	i = idr_alloc(&ctx->afu->contexts_idr, ctx, 0,
> +	i = idr_alloc(&ctx->afu->contexts_idr, ctx,
> +		      ctx->afu->adapter->native->sl_ops->min_pe,

As it turns out, dereferencing ctx->afu->adapter->native doesn't exactly 
work on PowerVM...

Working on a fix.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLBhz5YxDzF0d0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 12:00:19 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0G10Hka053792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 20:00:17 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fh6rus5fp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 19:59:58 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 15 Jan 2018 17:59:57 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] powerpc: Reduce log level of "OPAL detected !" message
In-Reply-To: <20180112022849.30899-3-benh@kernel.crashing.org>
References: <20180112022849.30899-1-benh@kernel.crashing.org>
 <20180112022849.30899-3-benh@kernel.crashing.org>
Date: Tue, 16 Jan 2018 11:59:49 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2qq39fe.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> This message isn't terribly useful.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -127,7 +127,7 @@ int __init early_init_dt_scan_opal(unsigned long node,
>
>  	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
>  		powerpc_firmware_features |= FW_FEATURE_OPAL;
> -		pr_info("OPAL detected !\n");
> +		pr_debug("OPAL detected !\n");

I've been meaning to add in a thing to grab the version from the device
tree and print that too.

-- 
Stewart Smith
OPAL Architect, IBM.

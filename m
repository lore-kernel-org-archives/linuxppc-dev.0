Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPCcY2P39zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 02:51:25 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74Gn04C115059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 12:51:23 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c4v6d1utm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 12:51:22 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 10:51:22 -0600
Subject: Re: [PATCH 4/4] axonram: Delete an unnecessary variable
 initialisation in axon_ram_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@fb.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
 <d833a646-8345-4cd1-0701-4450615b7a65@users.sourceforge.net>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 09:51:15 -0700
MIME-Version: 1.0
In-Reply-To: <d833a646-8345-4cd1-0701-4450615b7a65@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <70701740-b1cd-d2b6-8334-6dcd727a53f3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2017 12:17 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 3 Aug 2017 20:34:00 +0200
> 
> The local variable "rc" will eventually be set only to an error code.
> Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/sysdev/axonram.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
> index 93cc902350db..5677f3371e30 100644
> --- a/arch/powerpc/sysdev/axonram.c
> +++ b/arch/powerpc/sysdev/axonram.c
> @@ -184,7 +184,6 @@ static int axon_ram_probe(struct platform_device *device)
>  	static int axon_ram_bank_id = -1;
>  	struct axon_ram_bank *bank;
>  	struct resource resource;
> -	int rc = 0;

You've completely removed the decleration of "rc" instead of removing the "= 0"
initialization. I would expect a compilation test to have turned up an undeclared use
error for "rc".

-Tyrel

> 
>  	axon_ram_bank_id++;
> 

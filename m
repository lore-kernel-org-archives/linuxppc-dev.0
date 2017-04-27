Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDPzt6b41zDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 04:07:22 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3RI3UM6120312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:07:11 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a3jbd1jtf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 14:07:11 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 28 Apr 2017 04:07:08 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3RI6vAj49152074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 04:07:05 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3RI6WLO025899
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 04:06:33 +1000
Subject: Re: [PATCH] powerpc/pseries hotplug: prevent the reserved mem from
 removing
To: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org
References: <1493278988-26169-1-git-send-email-piliu@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kernelfans@gmail.com
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 23:36:08 +0530
MIME-Version: 1.0
In-Reply-To: <1493278988-26169-1-git-send-email-piliu@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e07eb5d7-2c8f-1eb5-8ba5-109bb6262f12@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pingfan,


On Thursday 27 April 2017 01:13 PM, Pingfan Liu wrote:
> E.g after fadump reserves mem regions, these regions should not be removed
> before fadump explicitly free them.
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
>   arch/powerpc/platforms/pseries/hotplug-memory.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index e104c71..201be23 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -346,6 +346,8 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
>
>   	if (!pfn_valid(start_pfn))
>   		goto out;
> +	if (memblock_is_reserved(base))
> +		return -EINVAL;

I think memblock reserved regions are not hot removed even without this 
patch.
So, can you elaborate on when/why this patch is needed?

Thanks
Hari

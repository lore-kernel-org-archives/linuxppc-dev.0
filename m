Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC6641A028D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:40:31 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 13 Jan 2016 16:40:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6F00E2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:40:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D6dwln37552312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:40:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D6duEI014156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:39:56 +1100
Subject: Re: [PATCH] powerpc/powernv: Remove support for p5ioc2
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <1452665431-7880-1-git-send-email-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <5695F123.4070602@au1.ibm.com>
Date: Wed, 13 Jan 2016 17:39:31 +1100
MIME-Version: 1.0
In-Reply-To: <1452665431-7880-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/01/16 17:10, Russell Currey wrote:
> "p5ioc2 is used by approximately 2 machines in the world, and has never
> ever been a supported configuration."
>
> The code for p5ioc2 is essentially unused and complicates what is already
> a very complicated codebase.  Its removal is essentially a "free win" in
> the effort to simplify the powernv PCI code.
>
> In addition, support for p5ioc2 has been dropped from skiboot.  There's no
> reason to keep it around in the kernel.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Doesn't apply cleanly on next, but that's minor.

> @@ -117,11 +115,6 @@ struct pnv_phb {
>
>   	union {
>   		struct {
> -			struct iommu_table iommu_table;
> -			struct iommu_table_group table_group;
> -		} p5ioc2;
> -
> -		struct {
>   			/* Global bridge info */
>   			unsigned int		total_pe;
>   			unsigned int		reserved_pe;

Given this leaves struct ioda as the only member of the union, do we 
want to get rid of the union?

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

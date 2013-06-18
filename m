Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D2712C02E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 23:02:32 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 18:26:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21A1DE004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:31:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5ID2WW18519832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:32:32 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5ID2M1m026986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 13:02:23 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, scottwood@freescale.com
Subject: Re: [PATCH] powerpc: Fix bad pmd error with book3E config
In-Reply-To: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 18 Jun 2013 18:32:22 +0530
Message-ID: <878v27inc1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Book3E uses the hugepd at PMD level and don't encode pte directly
> at the pmd level. So it will find the lower bits of pmd set
> and the pmd_bad check throws error. Infact the current code
> will never take the free_hugepd_range call at all because it will
> clear the pmd if it find a hugepd pointer.
>
> Reported-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Ben,

This is regression introduced by
e2b3d202d1dba8f3546ed28224ce485bc50010be 
"powerpc: Switch 16GB and 16MB explicit hugepages to a different page table format"

and should go upstream in 3.10

$git describe  --contains e2b3d202d1dba8f3546ed28224ce485bc50010be
v3.10-rc1~121^2~15

Without this path, we leak hugepd with all subarchs using old huge page
directory format.

-aneesh

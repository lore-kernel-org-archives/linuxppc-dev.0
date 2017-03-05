Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbzH05YC5zDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:13:00 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25N8VPF004895
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 18:12:44 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28yuy15whr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 18:12:44 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 09:12:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2FAA22CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:12:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25NCXgC53280850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:12:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25NC7Yj027716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:12:08 +1100
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: pc@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Mar 2017 10:11:41 +1100
In-Reply-To: <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
 <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
 <87fuivhuub.fsf@concordia.ellerman.id.au>
 <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488755501.2870.119.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-03 at 07:51 -0600, Paul Clarke wrote:
> > On P9 it all comes from the device tree so if that's wrong the AUX
> > vectors will definitely be wrong.
> 
> mambo-p9 is still falling victim to the device-tree, but "working":
> --
> getauxval(AT_L1I_CACHEGEOMETRY) = 0x0000000000000080
> AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
> getauxval(AT_L1D_CACHEGEOMETRY) = 0x0000000000000080
> AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
> getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000000
> getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000000
> --

The mambo device-tree comes from the mambo own internals afaik.

On real HW, the values come from HDAT. If they are wrong we need
the HostBoot guys to fix them.

Cheers,
Ben.

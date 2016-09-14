Return-Path: <cseo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ3NS3zXmzDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 00:10:32 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8EE9Emx032410
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 10:10:29 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25eyhatpxs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 10:10:29 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cseo@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 11:10:25 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C20AF352006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 10:09:59 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8EEAMQc38207730
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 11:10:22 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8EEAMLs021119
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 11:10:22 -0300
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
To: Nicholas Piggin <npiggin@gmail.com>, Cyril Bur <cyrilbur@gmail.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 wei.guo.simon@gmail.com, anton@samba.org
From: Carlos Eduardo Seo <cseo@linux.vnet.ibm.com>
Date: Wed, 14 Sep 2016 11:10:22 -0300
MIME-Version: 1.0
In-Reply-To: <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <cdf17bd0-d421-7cb6-527d-ab9e916edafa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 9/14/16 8:28 AM, Nicholas Piggin wrote:
>
> How common it is for glibc to be built with elision?
>

Not that common. We have it built with TLE support in Ubuntu (starting 
in 15.04), SLES 12 (since SP2) and AT 9.0-0.

However, it is only enabled by default in Ubuntu. For SLES and AT 9.0, 
the user has to set an env var to enable it (it's a hack).

There is some work upstream to add a tunables framework to glibc. That 
will allow us to properly provide a way to users enable/disable TLE as 
they wish. That patch is almost in, and as soon as it's committed, we'll 
start working on the tunable for TLE.

-- 
Carlos Eduardo Seo
Software Engineer - Linux on Power Toolchain
cseo@linux.vnet.ibm.com

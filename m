Return-Path: <srs0=4elm=h4=linux.ibm.com=ravi.bangoria@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gs2X2J04zF2MG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 19:47:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40gs2X1ck8z8svQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 19:47:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40gs2W40lDz9s3D
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2018 19:46:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w499kk5b111119
 for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2018 05:46:57 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2huusc0g0p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 09 May 2018 05:46:54 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Wed, 9 May 2018 10:46:12 +0100
Subject: Re: [PATCH] powerpc/pseries: hcall_exit tracepoint retval should be
 signed
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
References: <20180507130355.25115-1-mpe@ellerman.id.au>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Wed, 9 May 2018 15:16:09 +0530
MIME-Version: 1.0
In-Reply-To: <20180507130355.25115-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <ae859b3b-6de9-dcc0-7976-deaec9f23bdd@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/07/2018 06:33 PM, Michael Ellerman wrote:
> The hcall_exit() tracepoint has retval defined as unsigned long. That
> leads to humours results like:
>
>   bash-3686  [009] d..2   854.134094: hcall_entry: opcode=24
>   bash-3686  [009] d..2   854.134095: hcall_exit: opcode=24 retval=18446744073709551609
>
> It's normal for some hcalls to return negative values, displaying them
> as unsigned isn't very helpful. So change it to signed.
>
>   bash-3711  [001] d..2   471.691008: hcall_entry: opcode=24
>   bash-3711  [001] d..2   471.691008: hcall_exit: opcode=24 retval=-7
>
> Which can be more easily compared to H_NOT_FOUND in hvcall.h

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thank,
Ravi

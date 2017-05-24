Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXtj81FXlzDqdW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 23:36:43 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4ODXkdu110591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 09:36:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2an16amax9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 09:36:39 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Wed, 24 May 2017 09:36:38 -0400
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH] powerpc/lib: Split xor_vmx file to guarantee instruction
 ordering
References: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
From: Paul Clarke <pc@us.ibm.com>
Date: Wed, 24 May 2017 08:36:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <0a79517a-c9eb-6eca-4048-de20d4543114@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/23/2017 06:45 PM, Matt Brown wrote:
> The xor_vmx.c file is used for the RAID5 xor operations. In these functions
> altivec is enabled to run the operation and then disabled. However due to
> compiler instruction reordering, altivec instructions are being run before
> enable_altivec() and after disable_altivec().

If altivec instructions can be reordered after disable_altivec(), then disable_altivec() is broken, I'd think.

Could it be because the isync in mtmsr_isync() is after the mtmsr?

disable_kernel_altivec
- msr_check_and_clear
  - __msr_check_and_clear
    - mtmsr_isync

PC

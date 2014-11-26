Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449881A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 21:26:29 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79030140168
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 21:26:27 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 15:56:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E94F2E005C
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 15:56:41 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQAQCnW65470568
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 15:56:13 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQAQHho012566
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 15:56:17 +0530
Message-ID: <5475AAC8.7040105@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 15:56:16 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/powernv: Fix the hmi event version check.
References: <20141126034419.0917A1401B1@ozlabs.org>
In-Reply-To: <20141126034419.0917A1401B1@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2014 09:14 AM, Michael Ellerman wrote:
> On Thu, 2014-20-11 at 04:14:36 UTC, Mahesh Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The current HMI event structure is an ABI and carries a version field to
>> accommodate future changes without affecting/rearranging current structure
>> members that are valid for previous versions. The current version check
>> "if (hmi_evt->version != OpalHMIEvt_V1)" seems to consider that version
>> will always be V1 which may not be true in future. If we start supporting
>> HMI event > V1, this check would fail without printing anything on older
>> kernels. This patch fixes this issue.
> 
> It's not clear what you mean when you say "this check would fail without
> printing anything". The check will fail, and it will print something, ie. the
> error message.
> 
> What you mean is "the check will fail, and the HMI info will not be printed".

My Bad, Yes. I meant 'HMI info will not be printed'. Do you want me to
re spin the patch with correction.

> 
> I'll CC this to stable unless you disagree.

Yes. This patch needs to go to stable.

Thanks,
-Mahesh.

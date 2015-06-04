Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 023C41A0F81
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:46:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:46:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 32583357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:46:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546jsQr15728838
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:46:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546jV7U017723
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:45:31 +1000
Message-ID: <556FF3F8.1070507@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 12:15:12 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Make doorbell check preemption safe
References: <1432062014-9115-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1432083608.20823.19.camel@neuling.org>
In-Reply-To: <1432083608.20823.19.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 20 May 2015 06:30 AM, Michael Neuling wrote:
> On Wed, 2015-05-20 at 00:30 +0530, Shreyas B. Prabhu wrote:
>> Doorbell can be used to cause ipi on cpus which are sibling threads on
>> the same core. So icp_native_cause_ipi checks if the destination cpu
>> is a sibling thread of the current cpu and uses doorbell in such cases.
>>
>> But while running with CONFIG_PREEMPT=y, since this section is
>> preemtible, we can run into issues if after we check if the destination
>> cpu is a sibling cpu, the task gets migrated from a sibling cpu to a
>> cpu on another core.
>>
>> Fix this by using get_cpu()/ put_cpu()
> 
> Thanks.  Looks good and it's boots for me.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
mikey, Thanks!


mpe, if this looks ok, can you please pick it up?

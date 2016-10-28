Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t52S80NSLzDvSt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 23:02:16 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id n85so1136561pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 05:02:15 -0700 (PDT)
Subject: Re: powerpc/64s: relocation, register save fixes for system reset
 interrupt
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <3t4Pzf6KdDz9rxw@ozlabs.org>
Cc: "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <423538a8-421e-8790-4fc7-8740a4e80a86@gmail.com>
Date: Fri, 28 Oct 2016 23:01:58 +1100
MIME-Version: 1.0
In-Reply-To: <3t4Pzf6KdDz9rxw@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/10/16 22:38, Michael Ellerman wrote:
> On Thu, 2016-13-10 at 02:17:14 UTC, Nicholas Piggin wrote:
>> This patch does a couple of things. First of all, powernv immediately
>> explodes when running a relocated kernel, because the system reset
>> exception for handling sleeps does not do correct relocated branches.
>>
>> Secondly, the sleep handling code trashes the condition and cfar
>> registers, which we would like to preserve for debugging purposes (for
>> non-sleep case exception).
>>
>> This patch changes the exception to use the standard format that saves
>> registers before any tests or branches are made. It adds the test for
>> idle-wakeup as an "extra" to break out of the normal exception path.
>> Then it branches to a relocated idle handler that calls the various
>> idle handling functions.
>>
>> After this patch, POWER8 CPU simulator now boots powernv kernel that is
>> running at non-zero.
>>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 
> Applied to powerpc fixes, thanks.
> 
> https://git.kernel.org/powerpc/c/fb479e44a9e240a23c2d208c2ace23
> 
BTW, this cannot be directly marked back to stable
(ref: http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=fb479e44a9e240a23c2d208c2ace23542a47f41c)

For stable, we might need

https://marc.info/?l=linuxppc-embedded&m=146967183624811&w=4

Balbir Singh

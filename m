Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0WF00kxlzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 07:21:23 +1000 (AEST)
Subject: Re: [RFC 1/5] powerpc: Rename context.vdso_base to context.vdso
To: Balbir Singh <bsingharora@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <1461856737-17071-2-git-send-email-cov@codeaurora.org>
 <5726A7D5.7030305@gmail.com>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <572A67CE.4010109@codeaurora.org>
Date: Wed, 4 May 2016 17:21:18 -0400
MIME-Version: 1.0
In-Reply-To: <5726A7D5.7030305@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On 05/01/2016 09:05 PM, Balbir Singh wrote:
> On 29/04/16 01:18, Christopher Covington wrote:
>> In order to share remap and unmap support for the VDSO with other
>> architectures without duplicating the code, we need a common name and type
>> for the address of the VDSO. An informal survey of the architectures
>> indicates unsigned long vdso is popular. Change the variable name in
>> powerpc from mm->context.vdso_base to simply mm->context.vdso.
> 
> Could you please provide additional details on why the remap/unmap operations are required?

The goal is to make checkpointing and restoring processes work on
several different architectures and ABIs, in the face of Address Space
Layout Randomization (ASLR) and other factors that might change the VDSO
virtual address from one exec() to the next.

Here's the patch adding PowerPC support:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=83d3f0e90c6c8f833e3da91917c243a916fda69e

> This patch does rename, but should it abstract via a function acesss
> to vmap field using arch_* operations? Not sure

I'm sorry, but I don't understand this question. Are you saying ARM,
Power etc. need VDSO unmap and remap log that behave differently? So far
I've found the differences to be stylistic rather than really affecting
generated code behavior.

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

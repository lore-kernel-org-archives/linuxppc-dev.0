Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptQy1gyCzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:12:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cxl: Flush PSL cache before resetting the adapter
In-Reply-To: <112f8f8f-3117-4905-d422-01355cb374a4@au1.ibm.com>
References: <1475578804-13073-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <112f8f8f-3117-4905-d422-01355cb374a4@au1.ibm.com>
Date: Wed, 05 Oct 2016 22:12:08 +1100
Message-ID: <87eg3vdp87.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 04/10/16 22:00, Frederic Barrat wrote:
>> If the capi link is going down while the PSL owns a dirty cache line,
>> any access from the host for that data could lead to an Uncorrectable
>> Error.
>> So when resetting the capi adapter through sysfs, make sure the PSL
>> cache is flushed. It won't help if there are any active Process
>> Elements on the card, as the cache would likely get new dirty cache
>> lines immediately, but if resetting an idle adapter, it should avoid
>> any bad surprises from data left over from terminated Process Elements.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ...but not that it matters because V1 of this just got merged...

Yep. Send me an incremental if it's important.

cheers

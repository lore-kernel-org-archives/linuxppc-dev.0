Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19D861A00C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 23:41:08 +1000 (EST)
Message-ID: <53ECBC6B.5030507@suse.de>
Date: Thu, 14 Aug 2014 15:40:59 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PC, KVM,
 CMA: Fix regression caused by wrong get_order() use
References: <1407992587-9164-1-git-send-email-aik@ozlabs.ru>
 <87egwj64bz.fsf@linux.vnet.ibm.com>
In-Reply-To: <87egwj64bz.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.08.14 07:13, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>
>> fc95ca7284bc54953165cba76c3228bd2cdb9591 claims that there is no
>> functional change but this is not true as it calls get_order() (which
>> takes bytes) where it should have called ilog2() and the kernel stops
>> on VM_BUG_ON().
>>
>> This replaces get_order() with order_base_2() (round-up version of ilog2).
>>
>> Suggested-by: Paul Mackerras <paulus@samba.org>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

So this affects 3.17?


Alex

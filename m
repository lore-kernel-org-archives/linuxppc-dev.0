Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DQNz6PTJzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 22:27:15 +1000 (AEST)
Subject: Re: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Xin Long <lucien.xin@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, jishi@redhat.com, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>
References: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
 <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <76289d79-0e7e-7b22-2364-0b5777f42c8b@c-s.fr>
Date: Mon, 17 Sep 2018 14:27:11 +0200
MIME-Version: 1.0
In-Reply-To: <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Le 10/09/2018 à 16:28, Xin Long a écrit :
> On Mon, Sep 10, 2018 at 2:09 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> On little endian platforms, csum_ipv6_magic() keeps len and proto in
>> CPU byte order. This generates a bad results leading to ICMPv6 packets
>> from other hosts being dropped by powerpc64le platforms.
>>
>> In order to fix this, len and proto should be converted to network
>> byte order ie bigendian byte order. However checksumming 0x12345678
>> and 0x56341278 provide the exact same result so it is enough to
>> rotate the sum of len and proto by 1 byte.
>>
>> PPC32 only support bigendian so the fix is needed for PPC64 only
>>
>> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
>> Reported-by: Jianlin Shi <jishi@redhat.com>
>> Reported-by: Xin Long <lucien.xin@gmail.com>
>> Cc: <stable@vger.kernel.org> # 4.18+
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/lib/checksum_64.S | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
>> index 886ed94b9c13..2a68c43e13f5 100644
>> --- a/arch/powerpc/lib/checksum_64.S
>> +++ b/arch/powerpc/lib/checksum_64.S
>> @@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
>>          addc    r0, r8, r9
>>          ld      r10, 0(r4)
>>          ld      r11, 8(r4)
>> +#ifndef CONFIG_CPU_BIG_ENDIAN
>> +       rotldi  r5, r5, 8
>> +#endif
>>          adde    r0, r0, r10
>>          add     r5, r5, r7
>>          adde    r0, r0, r11
>> --
>> 2.13.3
>>
> Tested-by: Xin Long <lucien.xin@gmail.com>
> 

Could you take this fix for 4.19 ?

Unless someone takes it through the netdev tree ?

Thanks
Christophe

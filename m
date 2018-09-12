Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429BfJ07LgzF37N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:27:35 +1000 (AEST)
Subject: Re: [PATCH net] powerpc: use big endian to hash len and proto in
 csum_ipv6_magic
To: David Miller <davem@davemloft.net>, lucien.xin@gmail.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, roopa@cumulusnetworks.com
References: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
 <20180911.230105.563027666901362955.davem@davemloft.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <bcf093d7-6754-7f6e-891d-7cbf2a4c0a29@c-s.fr>
Date: Wed, 12 Sep 2018 08:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180911.230105.563027666901362955.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 12/09/2018 à 08:01, David Miller a écrit :
> From: Xin Long <lucien.xin@gmail.com>
> Date: Sat,  8 Sep 2018 18:15:12 +0800
> 
>> The function csum_ipv6_magic doesn't convert len and proto to big
>> endian before doing ipv6 csum hash, which is not consistent with
>> RFC and other arches.
>>
>> Jianlin found it when ICMPv6 packets from other hosts were dropped
>> in the powerpc64 system.
>>
>> This patch is to fix it by using instruction 'lwbrx' to do this
>> conversion in powerpc32/64 csum_ipv6_magic.
>>
>> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
>> Reported-by: Jianlin Shi <jishi@redhat.com>
>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> 
> Xin, please address the feedback you were given.

I submitted an alternative fix, and Lucien Xin gave its Tested-by:

See https://patchwork.ozlabs.org/patch/967868/

Christophe

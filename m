Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Q0j6VwQzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 03:49:57 +1000 (AEST)
Subject: Re: [PATCH v13 3/6] CPM/QE: use genalloc to manage CPM/QE muram
To: Qiang Zhao <qiang.zhao@nxp.com>, Zhao Qiang <qiang.zhao@freescale.com>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
 <1448851737-33125-3-git-send-email-qiang.zhao@freescale.com>
 <7730792c-db7f-c644-55dc-0cea5ee65c0b@c-s.fr>
 <AM3PR04MB1185E3251A9323801BBF97AD911B0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <oss@buserror.net>, "olof@lixom.net" <olof@lixom.net>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "X.xie@freescale.com" <X.xie@freescale.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <6724af54-92ef-8d8f-8c2b-c2b4ebfc240c@c-s.fr>
Date: Mon, 8 Aug 2016 19:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1185E3251A9323801BBF97AD911B0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 08/08/2016 à 05:00, Qiang Zhao a écrit :
> On 6/8/2016 03:48AM,  Christophe Leroy <christophe.leroy@c-s.fr> wrote :
>
>> -----Original Message-----
>> From: Christophe Leroy [mailto:christophe.leroy@c-s.fr]
>> Sent: Saturday, August 06, 2016 12:59 AM
>> To: Zhao Qiang <qiang.zhao@freescale.com>; lauraa@codeaurora.org
>> Cc: catalin.marinas@arm.com; linux-kernel@vger.kernel.org; Scott Wood
>> <oss@buserror.net>; olof@lixom.net; akpm@linux-foundation.org; linuxppc-
>> dev@lists.ozlabs.org; X.xie@freescale.com
>> Subject: Re: [PATCH v13 3/6] CPM/QE: use genalloc to manage CPM/QE muram
>>
>>
>>
>> Le 30/11/2015 à 03:48, Zhao Qiang a écrit :
>>> Use genalloc to manage CPM/QE muram instead of rheap.
>>>
>>> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
>>> ---
>>> Changes for v9:
>>> 	- splitted from patch 3/5, modify cpm muram management functions.
>>> Changes for v10:
>>> 	- modify cpm muram first, then move to qe_common
>>> 	- modify commit.
>>> Changes for v11:
>>> 	- factor out the common alloc code
>>> 	- modify min_alloc_order to zero for cpm_muram_alloc_fixed.
>>> Changes for v12:
>>> 	- Nil
>>> Changes for v13:
>>> 	- rebase
>>>
>>>  arch/powerpc/include/asm/cpm.h   |   3 +
>>>  arch/powerpc/platforms/Kconfig   |   4 +-
>>>  arch/powerpc/sysdev/cpm_common.c | 126
>> +++++++++++++++++++++++++++------------
>>>  lib/genalloc.c                   |   2 +-
>>>  4 files changed, 94 insertions(+), 41 deletions(-)
>>>
>>
>> With that patch applied, I get the following Oops on a 8xx (Which has a CPM1).
>>
>> cpm_muram_init() is called from setup_arch()
>>
>> It seems that gen_pool_add() tries to kmalloc() memory but the SLAB is not
>> available yet.
>>
>
> Thank you for your comments, I can't find a 8xx board, would you like to test the patch
> Attached on your board?

Thanks for your support (indeed I only received your mail a few minutes, 
that is after I proposed another patch).

Your patch will not work, because initcalls are called too late. The 8xx 
needs the SMCs from the CPM for console, that is long before initcalls 
are called.

I sent a proposed patch approximatly 2 hours ago, it is called "[PATCH] 
soc: fsl/qe: fix Oops on CPM1 (and likely CPM2)"
That one works. Could you have a look ?

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

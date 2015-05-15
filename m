Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 116131A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 03:58:35 +1000 (AEST)
Message-ID: <555633C3.9000308@c-s.fr>
Date: Fri, 15 May 2015 19:58:27 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] Partially revert "powerpc: Remove duplicate
 cacheable_memcpy/memzero functions"
References: <cover.1431436210.git.christophe.leroy@c-s.fr>	
 <b87a9787efc35a8bd6cd7f73185e9959b84ff84a.1431436210.git.christophe.leroy@c-s.fr>
 <1431564565.3868.157.camel@freescale.com>
In-Reply-To: <1431564565.3868.157.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 14/05/2015 02:49, Scott Wood a écrit :
> On Tue, 2015-05-12 at 15:32 +0200, Christophe Leroy wrote:
>> This partially reverts
>> commit 'powerpc: Remove duplicate cacheable_memcpy/memzero functions
>> ("f909a35bdfb7cb350d078a2cf888162eeb20381c")'
> I don't have that SHA.  Do you mean
> b05ae4ee602b7dc90771408ccf0972e1b3801a35?
Right, took it from the wrong tree sorry.
>
>> Functions cacheable_memcpy/memzero are more efficient than
>> memcpy/memset as they use the dcbz instruction which avoids refill
>> of the cacheline with the data that we will overwrite.
> I don't see anything in this patchset that addresses the "NOTE: The old
> routines are just flat buggy on kernels that support hardware with
> different cacheline sizes" comment.
I believe the NOTE means that if a kernel is compiled for several CPUs 
having different cache line size,
then it will not work. But it is also the case of other functions using 
dcbz instruction, like copy_page() clear_page() copy_tofrom_user().

And indeed, this seems only possible in three cases:
1/ With CONFIG_44x as 47x has different size than 44x and 46x. However 
it is explicitly stated in arch/powerpc/platforms/44x/Kconfig : "config 
PPC_47x This option enables support for the 47x family of processors and 
is not currently compatible with other 44x or 46x varients"
2/ With CONFIG_PPC_85xx, as PPC_E500MC has different size than other 
E500. However it is explicitly stated in 
arch/powerpc/platforms/Kconfig.cputype : "config PPC_E500MC This must be 
enabled for running on e500mc (and derivatives such as e5500/e6500), and 
must be disabled for running on e500v1 or e500v2."
3/ With CONFIG_403GCX as 403GCX has different size than other 40x. 
However it seems to be no way to select CONFIG_403GCX from 
arch/powerpc/platforms/40x/Kconfig

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
http://www.avast.com

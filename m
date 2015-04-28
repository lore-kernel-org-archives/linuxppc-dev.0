Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 68BDA1A0BF8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 05:09:02 +1000 (AEST)
Message-ID: <553FDAC9.3050902@c-s.fr>
Date: Tue, 28 Apr 2015 21:08:57 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc32: put csum_tcpudp_magic inline
References: <20150203113927.52DA41A5F13@localhost.localdomain>
 <1427249404.22867.86.camel@freescale.com>
In-Reply-To: <1427249404.22867.86.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/03/2015 03:10, Scott Wood a écrit :
> On Tue, 2015-02-03 at 12:39 +0100, Christophe Leroy wrote:
>> csum_tcpudp_magic() is only a few instructions, and does not modifies any other
>> register than the returned result. So it is not worth having it as a separate
>> function and suffer function branching and saving of volatile registers.
>> This patch makes it inline by use of the already existing csum_tcpudp_nofold()
>> function.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> v2: no change
>>
>>   arch/powerpc/include/asm/checksum.h | 15 +++++++++++++++
>>   arch/powerpc/lib/checksum_32.S      | 16 ----------------
>>   2 files changed, 15 insertions(+), 16 deletions(-)
> The 64-bit version is pretty similar to the 32-bit -- why only use
> csum_tcpudp_nofold() on 32-bit?
>
>
I did it only on 32-bit because I have no way to test it on 64-bits, but 
I can do it for 64 bits as well, no problem.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
http://www.avast.com

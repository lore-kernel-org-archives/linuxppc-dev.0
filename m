Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 004771A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 01:35:49 +1100 (AEDT)
Subject: Re: [PATCH v2 15/25] powerpc/8xx: move 8xx SPRN defines into
 reg_8xx.h and add some missing ones
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <a8718136980080a9b8ec7b76e6786a434b50e447.1442939410.git.christophe.leroy@c-s.fr>
 <20150929000346.GH6161@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5613DC41.2000100@c-s.fr>
Date: Tue, 6 Oct 2015 16:35:45 +0200
MIME-Version: 1.0
In-Reply-To: <20150929000346.GH6161@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/09/2015 02:03, Scott Wood a écrit :
> On Tue, Sep 22, 2015 at 06:50:58PM +0200, Christophe Leroy wrote:
>> Move 8xx SPRN defines into reg_8xx.h and add some missing ones
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> No change in v2
> Why are they being moved?  Why are they being separated from the bit
> definitions?
>
>
It was to keep asm/reg_8xx.h self sufficient for the following patch.

Also because including asm/mmu-8xx.h creates circular inclusion issue 
(mmu-8xx.h needs page.h which includes page-32.h, page-32.h includes 
cache.h, cache.h include reg.h which includes reg_8xx). The circle 
starts with an inclusion of asm/cache.h by linux/cache.h, himself 
included by linux/printk.h, and I end up with 'implicit declaration' issues.

How can I fix that ?

Christophe

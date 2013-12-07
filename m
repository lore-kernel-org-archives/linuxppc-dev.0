Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 524B72C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 21:03:59 +1100 (EST)
Message-ID: <52A2ECE4.3050407@c-s.fr>
Date: Sat, 07 Dec 2013 10:39:48 +0100
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
References: <20131127110406.6DC8E1A504F@localhost.localdomain>
 <1386356996.7375.120.camel@snotra.buserror.net>
In-Reply-To: <1386356996.7375.120.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Le 06/12/2013 20:09, Scott Wood a écrit :
> On Wed, 2013-11-27 at 12:04 +0100, Christophe Leroy wrote:
>> Today, the only way to load kernels whose size is greater than 8Mbytes is to
>> activate CONFIG_PIN_TLB. Otherwise, the physical memory initially mapped is
>> limited to 8Mbytes. This patch sets up 24 Mbytes of initial memory regardless
>> of whether CONFIG_PIN_TLB is active or not. It allows to load "big" kernels
>> (for instance when activating CONFIG_LOCKDEP_SUPPORT) without having
>> to activate CONFIG_PIN_TLB.
> So, what happens on boards with less than 24M memory present?  Even if
> you avoid explicitly referencing those addresses, what if there is a
> speculative access -- or does 8xx not do that?
>
> -Scott
>

Function setup_initial_memory_limit() in mm/init_32.c defines the limits 
based on the parameters given by the bootloader.
As far as I know, the 8xx doesn't do speculative access just because an 
area is loaded in a TLB Entry.

Christophe

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com

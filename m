Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 0A6B71A027B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 04:01:05 +1000 (AEST)
Subject: Re: [PATCH] powerpc/book3s32: Only select PPC_HAVE_PMU on e600
To: Scott Wood <scottwood@freescale.com>
References: <20150903092704.2F4881A241D@localhost.localdomain>
 <20150904164349.GA10337@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <55E9DC5B.4090506@c-s.fr>
Date: Fri, 4 Sep 2015 20:00:59 +0200
MIME-Version: 1.0
In-Reply-To: <20150904164349.GA10337@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/09/2015 18:43, Scott Wood a écrit :
> On Thu, Sep 03, 2015 at 11:27:03AM +0200, Christophe Leroy wrote:
>> On PPC832x, perf record/report reports martian addresses
>>
>>       2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
>>       2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
>>       1.62%  perf_reseau4  [kernel.kallsyms]   [k] __ip_append_data.isra.39
>>       1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
>>       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
>>       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
>>       1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
>>       1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
>>       1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
>>       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
>>       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
>>       [.....]
>>
>> This is due to function perf_instruction_pointer() reading SPR SIAR
>> which doesn't exist on e300 core. The perf_instruction_pointer() is
>> redefined in arch/powerpc/perf/core-book3s.c when CONFIG_PPC_PERF_CTRS
>> is selected.
>>
>> This patch moves the selection of CONFIG_PPC_HAVE_PMU in 86xx section
>> so that CONFIG_PPC_PERF_CTRS won't be selected for other 6xx powerpc
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> So, what happens when a kernel is built that supports both 83xx and 86xx?
Right, so should we define a processor feature for it ?
> Plus, it's e300, not e600, that is the exception among 6xx-style cores.
Is it ? I've been looking for special register SIAR (spr 955) in several 
6xx reference manuals.
82xx doesn't have it, 52xx and 512x don't have it.
I found it only in the 86xx
Which other family has it ?

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

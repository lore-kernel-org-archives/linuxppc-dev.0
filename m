Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdWmM4VvjzDvHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 07:40:03 +1100 (AEDT)
Subject: Re: [RFC 1/2] powerpc/32: Unset MSR RI in exception epilogs
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
 <e6292c23163fac0865def3a385ff01d1497b005b.1481652710.git.christophe.leroy@c-s.fr>
 <20161213191514.GJ30845@gate.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <1fbdc292-df1c-f6a8-efc4-019350209536@c-s.fr>
Date: Tue, 13 Dec 2016 21:39:55 +0100
MIME-Version: 1.0
In-Reply-To: <20161213191514.GJ30845@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 13/12/2016 à 20:15, Segher Boessenkool a écrit :
> On Tue, Dec 13, 2016 at 07:19:41PM +0100, Christophe Leroy wrote:
>> At exception prologs, once SRR0 and SRR1 have been saved, MSR RI is
>> set to mark the interrupt as recoverable.
>>
>> MSR RI has to be unset before writing into SRR0 and SRR1 at exception
>> epilogs.
>
> Why?  What goes wrong without this?  Etc.
>
>

The following patch implements perf instruction counting using the 8xx 
debug counters. When the counter reaches 0, it fires a debug exception.
If that exception happens between the setting of srr0/srr1 and the rfi, 
values set to srr0/srr1 are lost and we end up with an Oops.

To avoid that, MSR RI has to be unset. That way, because the debug 
counters mode is set to masked mode in register LCTRL2, no debug 
interrupt will happen during that critical phase.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 413KQK4bf8zDr30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 12:11:37 +1000 (AEST)
Date: Sun, 10 Jun 2018 12:11:36 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Andreas Schwab <schwab@linux-m68k.org>,
 "Joshua M. Thompson" <funaho@jurai.org>
cc: Michael Schmitz <schmitzmic@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
In-Reply-To: <87a7s4854x.fsf@igel.home>
Message-ID: <alpine.LNX.2.21.1806101139130.29@nippy.intranet>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet> <87a7s4854x.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 9 Jun 2018, Andreas Schwab wrote:

> On Jun 09 2018, Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > There is no ABI issue AFAIK. The value of pmu_kind is visible to userland 
> > only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k.
> 
> Then why are PMU_68K_V1 and PMU_68K_V2 defined in the first place?
> 

I think your question is academic. Mistakes were made, and dead code 
appears in the kernel headers.

The author of via-pmu68k.c (apparently Joshua M. Thompson) may have a 
better answer, but if you want my guess, it is simply that pmu_kind was 
cut and pasted from via-pmu.c, and then given values corresponding to 
internal kernel system controller type values. See via-pmu68k.c:

        case MAC_ADB_PB1:
                pmu_kind = PMU_68K_V1;
                break;
        case MAC_ADB_PB2:
                pmu_kind = PMU_68K_V2;
                break;

Note that the MAC_ADB_PB1 and MAC_ADB_PB2 categories are quite artificial 
and were never useful to userland and were never visible to userland. The 
same applies to PMU_68K_V1 and PMU_68K_V2.

The MAC_ADB_PB1 and MAC_ADB_PB2 categories are used internally by the 
kernel to distinguish the M50753 devices which have no built-in RTC 
(MAC_ADB_PB1) from the M68HC05 devices which do have a built-in RTC 
(MAC_ADB_PB2). This distinction is completely hidden by the kernel behind 
the RTC UAPIs. It is not useful to userland.

With this patch series, MAC_ADB_PB1/PMU_68K_V1 models will have no PMU 
driver loaded at all, while MAC_ADB_PB2/PMU_68K_V2 models will have 
pmu_kind set to PMU_UNKNOWN, and this will become visible to userland for 
the first time.

Can please you explain why this change is problematic? You seem to be 
worried about breaking code which doesn't exist, and which, if it did 
exist, is already broken for other reasons.

-- 

> Andreas.
> 
> 

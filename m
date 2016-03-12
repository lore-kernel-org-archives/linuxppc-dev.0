Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qMfXR3RybzDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2016 20:55:50 +1100 (AEDT)
Subject: Re: [v8, 08/23] powerpc/8xx: Map IMMR area with 512k page at a fixed
 address
To: Scott Wood <oss@buserror.net>
References: <469ed145e21be6720c186686039b569e30ca1ed4.1455032446.git.christophe.leroy@c-s.fr>
 <20160311231539.GB30872@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <56E3E7A1.4000908@c-s.fr>
Date: Sat, 12 Mar 2016 10:55:45 +0100
MIME-Version: 1.0
In-Reply-To: <20160311231539.GB30872@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/03/2016 00:15, Scott Wood a écrit :
> On Tue, Feb 09, 2016 at 05:08:02PM +0100, Christophe Leroy wrote:
>> Once the linear memory space has been mapped with 8Mb pages, as
>> seen in the related commit, we get 11 millions DTLB missed during
>> the reference 600s period. 77% of the misses are on user addresses
>> and 23% are on kernel addresses (1 fourth for linear address space
>> and 3 fourth for virtual address space)
>>
>> Traditionaly, each driver manages one computer board which has its
>> own components with its own memory maps.
>> But on embedded chips like the MPC8xx, the SOC has all registers
>> located in the same IO area.
>>
>> When looking at ioremaps done during startup, we see that
>> many drivers are re-mapping small parts of the IMMR for their own use
>> and all those small pieces gets their own 4k page, amplifying the
>> number of TLB misses: in our system we get 0xff000000 mapped 31 times
>> and 0xff003000 mapped 9 times.
>>
>> Even if each part of IMMR was mapped only once with 4k pages, it would
>> still be several small mappings towards linear area.
>>
>> With the patch, on the same principle as what was done for the RAM,
>> the IMMR gets mapped by a 512k page.
> "the patch" -- this one, that below says it maps IMMR with other sizes?
No, the physical mapping is done using one 512k page. And this is done 
in 4k pages mode only, for the reason explained below.
>
>> In 4k pages mode, we reserve a 4Mb area for mapping IMMR. The TLB
>> miss handler checks that we are within the first 512k and bail out
>> with page not marked valid if we are outside
>>
>> In 16k pages mode, it is not realistic to reserve a 64Mb area, so
>> we do a standard mapping of the 512k area using 32 pages of 16k.
>> The CPM will be mapped via the first two pages, and the SEC engine
>> will be mapped via the 16th and 17th pages. As the pages are marked
>> guarded, there will be no speculative accesses.
> If IMMR is 512k, why do you need to reserve 4M/64M for it?
The principle here, as for the 8M pages used for the mapping of RAM, is 
to have the PTE in the PGD (level 1 table) and no level 2 table 
associated with that PGD entry.
Each PGD entry maps a 4M area in 4k pages mode and a 64M area in 16k 
pages mode. That's the reason.
We can afford "loosing" 4M virtual memory but I felt like "loosing" 64M 
of virtual memory is not worth it taking into account that 2 16k pages 
are enough to map the CPM internal memory and 2 other 16k pages are 
enough to map the SEC engine internal memory.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 68A3C1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 13:25:02 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 13 Dec 2011 07:54:57 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBD2OQ193850468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 07:54:26 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBD2OPWq020331
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 07:54:26 +0530
Message-ID: <4EE6B758.9070902@in.ibm.com>
Date: Tue, 13 Dec 2011 07:54:24 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [UPDATED] [PATCH v4 3/7] [ppc] Process dynamic relocations for
 kernel
References: <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
 <20111210023646.19516.1453.stgit@suzukikp.in.ibm.com>
 <485863B3-91BC-4488-9CA8-4F902D85D8F6@kernel.crashing.org>
In-Reply-To: <485863B3-91BC-4488-9CA8-4F902D85D8F6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/11/11 01:32, Segher Boessenkool wrote:
> Hi Suzuki,
>
> Looks quite good, a few comments...
>
>> +get_type:
>> + /* r4 holds the relocation type */
>> + extrwi r4, r4, 8, 24 /* r4 = ((char*)r4)[3] */
>
> This comment is confusing (only makes sense together with the
> lwz a long way up).

Agree, will fix them.
>
>> +nxtrela:
>> + /*
>> + * We have to flush the modified instructions to the
>> + * main storage from the d-cache. And also, invalidate the
>> + * cached instructions in i-cache which has been modified.
>> + *
>> + * We delay the msync / isync operation till the end, since
>> + * we won't be executing the modified instructions until
>> + * we return from here.
>> + */
>> + dcbst r4,r7
>> + icbi r4,r7
>
> You still need a sync between these two. Without it, the icbi can
> complete before the dcbst for the same address does, which leaves
> room for an instruction fetch from that address to get old data.
>
Ok.
>> + cmpwi r8, 0 /* relasz = 0 ? */
>> + ble done
>> + add r9, r9, r6 /* move to next entry in the .rela table */
>> + subf r8, r6, r8 /* relasz -= relaent */
>> + b applyrela
>> +
>> +done:
>> + msync /* Wait for the flush to finish */
>
> The instruction is called "sync". msync is a BookE thing.
>
>> next if (/R_PPC64_RELATIVE/ or /R_PPC64_NONE/ or
>> /R_PPC64_ADDR64\s+mach_/);
>> + next if (/R_PPC_ADDR16_LO/ or /R_PPC_ADDR16_HI/ or
>> + /R_PPC_ADDR16_HA/ or /R_PPC_RELATIVE/);
>
> Nothing new, but these should probably have \b or \s or just
> a space on each side.
Will fix this too. Also will include the R_PPC_NONE to the list
of valid relocations.

Thanks
Suzuki


>
>
> Segher
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40BC1DBF.6050108@intracom.gr>
Date: Tue, 01 Jun 2004 09:10:07 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] fix TLB handling for 8xx on linuxppc-2.5
References: <40BB42EF.10805@intracom.gr> <1086040829.1930.66.camel@gaston>
In-Reply-To: <1086040829.1930.66.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>On Tue, 2004-06-01 at 00:36, Pantelis Antoniou wrote:
>
>>Hi
>>
>>The following patch fixes the problems of 8xx with the latest
>>linuxppc-2.5 tree.
>>
>>With it user space progresses properly.
>>Lots of gray areas remain and MM handling for 8xx is
>>mighty inefficient IMO.
>>
>>Dan could you please take a look?
>>
>
>Ok, looks a bit weird on the edges.
>
>
I agree :)

>>Pantelis
>>
>>
>>______________________________________________________________________
>>diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linuxppc_2.5/arch/ppc/kernel/head_8xx.S linuxppc_2.5-intracom/arch/ppc/kernel/head_8xx.S
>>--- linuxppc_2.5/arch/ppc/kernel/head_8xx.S	Mon May 31 10:52:29 2004
>>+++ linuxppc_2.5-intracom/arch/ppc/kernel/head_8xx.S	Mon May 31 17:24:05 2004
>>@@ -157,6 +157,24 @@
>> 	SAVE_2GPRS(7, r11)
>>
>> /*
>>+if ((val & (_PAGE_HWWRITE | _PAGE_RW | _PAGE_DIRTY)) == (_PAGE_RW | _PAGE_DIRTY))
>>+	val |= _PAGE_HWWRITE;
>>+else if ((val & (_PAGE_HWWRITE | _PAGE_RW | _PAGE_DIRTY)) == _PAGE_HWWRITE)
>>+	val &= ~_PAGE_HWWRITE;
>>+*/
>>
>
>I don't like the above. Things should be dealt with differently.
>
>The TLB handler itself should only care about _setting_ _PAGE_HWWRITE I
>think when it's missing (oh, and dirty of course). The clearing should
>be done on a per-PTE basis in ptep_get_and_clear_*, ptep_clear_*, etc...
>along with the necessary TLB invalidate (hrm... can we invalidate
>selectively instead of the whole thing ?)
>
Just setting HWWRITE is simple.

>
>The tlbia in update_mmu_cache() doesn't look good. More like a
>workaround for breakage in the implementation.
>
It is :)

When I tried a selective TLB invalidate it crashed
in a spectacular way.

That lazy TLB stuff just gave the mm system a good shake and
it came apart.

>
>Paul, any comment ?
>
>Ben.
>
>
Regards

Pantelis

P.S.

Perusing the headers I came across a comment that said swap is
broken on 8xx. For some reason I need to fix it.
Where can I go about looking?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

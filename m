Message-ID: <40BC2A7A.2010801@intracom.gr>
Date: Tue, 01 Jun 2004 10:04:26 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] fix TLB handling for 8xx on linuxppc-2.5
References: <20040601070415.E13F6C109F@atlas.denx.de>
In-Reply-To: <20040601070415.E13F6C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <40BC1DBF.6050108@intracom.gr> you wrote:
>
>>Perusing the headers I came across a comment that said swap is
>>broken on 8xx. For some reason I need to fix it.
>>Where can I go about looking?
>>
>
>If a 2.4 kernel is good enough:
>
:)

Thanks

>
>Index: include/asm-ppc/pgtable.h
>===================================================================
>RCS file: /cvsroot/linuxppc_2_4_devel/include/asm-ppc/pgtable.h,v
>retrieving revision 1.6
>retrieving revision 1.7
>diff -u -r1.6 -r1.7
>--- include/asm-ppc/pgtable.h	11 Mar 2003 19:53:02 -0000	1.6
>+++ include/asm-ppc/pgtable.h	24 Aug 2003 13:58:59 -0000	1.7
>@@ -686,11 +686,11 @@
>  * must not include the _PAGE_PRESENT bit, or the _PAGE_HASHPTE bit
>  * (if used).  -- paulus
>  */
>-#define SWP_TYPE(entry)			((entry).val & 0x3f)
>-#define SWP_OFFSET(entry)		((entry).val >> 6)
>-#define SWP_ENTRY(type, offset)		((swp_entry_t) { (type) | ((offset) << 6) })
>-#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 2 })
>-#define swp_entry_to_pte(x)		((pte_t) { (x).val << 2 })
>+#define SWP_TYPE(entry)			(((entry).val >> 1) & 0x3f)
>+#define SWP_OFFSET(entry)		((entry).val >> 8)
>+#define SWP_ENTRY(type, offset)		((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
>+#define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) & ~0x81 })
>+#define swp_entry_to_pte(x)		((pte_t) { (x).val })
>
> /* CONFIG_APUS */
> /* For virtual address to physical address conversion */
>
>Best regards,
>
>Wolfgang Denk
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

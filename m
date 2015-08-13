Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32DCD1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 10:24:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 13 Aug 2015 10:24:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 400462BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 10:23:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7D0NjX766453686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 10:23:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7D0NPL7031542
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 10:23:26 +1000
Date: Thu, 13 Aug 2015 10:23:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 12/42] powerpc/powernv: Increase PE# capacity
Message-ID: <20150813002300.GA5761@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C8747E.9090908@ozlabs.ru> <20150811003804.GA18283@gwshan>
 <55C9623D.6070409@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C9623D.6070409@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2015 at 12:47:25PM +1000, Alexey Kardashevskiy wrote:
>On 08/11/2015 10:38 AM, Gavin Shan wrote:
>>On Mon, Aug 10, 2015 at 07:53:02PM +1000, Alexey Kardashevskiy wrote:
>>>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>>>Each PHB maintains an array helping to translate RID (Request
>>>>ID) to PE# with the assumption that PE# takes 8 bits, indicating
>>>>that we can't have more than 256 PEs. However, pci_dn->pe_number
>>>>already had 4-bytes for the PE#.
>>>>
>>>>The patch extends the PE# capacity so that each of them will be
>>>>4-bytes long. Then we can use IODA_INVALID_PE to check one entry
>>>>in phb->pe_rmap[] is valid or not.
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++++--
>>>>  arch/powerpc/platforms/powernv/pci.h      | 7 +++----
>>>>  2 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 57ba8fd..3094c61 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -786,7 +786,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>>>
>>>>  	/* Clear the reverse map */
>>>>  	for (rid = pe->rid; rid < rid_end; rid++)
>>>>-		phb->ioda.pe_rmap[rid] = 0;
>>>>+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>>>
>>>>  	/* Release from all parents PELT-V */
>>>>  	while (parent) {
>>>>@@ -3134,7 +3134,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>>  	unsigned long size, pemap_off;
>>>>  	const __be64 *prop64;
>>>>  	const __be32 *prop32;
>>>>-	int len;
>>>>+	int len, i;
>>>>  	u64 phb_id;
>>>>  	void *aux;
>>>>  	long rc;
>>>>@@ -3201,6 +3201,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>>  	if (prop32)
>>>>  		phb->ioda.reserved_pe = be32_to_cpup(prop32);
>>>>
>>>>+	/* Invalidate RID to PE# mapping */
>>>>+	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
>>>>+		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
>>>>+
>>>>  	/* Parse 64-bit MMIO range */
>>>>  	pnv_ioda_parse_m64_window(phb);
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>>>index 1dc9578..6f8568e 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci.h
>>>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>>>@@ -175,11 +175,10 @@ struct pnv_phb {
>>>>  			struct list_head	pe_list;
>>>>  			struct mutex            pe_list_mutex;
>>>>
>>>>-			/* Reverse map of PEs, will have to extend if
>>>>-			 * we are to support more than 256 PEs, indexed
>>>>-			 * bus { bus, devfn }
>>>>+			/* Reverse map of PEs, indexed by
>>>>+			 * { bus, devfn }
>>>>  			 */
>>>>-			unsigned char		pe_rmap[0x10000];
>>>>+			int			pe_rmap[0x10000];
>>>
>>>
>>>256k seems to be waste when only tiny fraction of it will ever be used. Using
>>>include/linux/hashtable.h makes sense here, and if you use a hashtable, you
>>>won't have to initialize anything with IODA_INVALID_PE.
>>>
>>
>>I'm not sure if I follow your idea completely. With hash table to trace
>>RID mapping here, won't more memory needed if all PCI buse numbers (0
>>to 255) are all valid? It means hash table doesn't have advantage in
>>memory consumption.
>
>You need 3 bytes - one for a bus and two for devfn - which makes it a perfect
>32bit has key and you only store existing devices in a hash so you do not
>waste memory.
>

You don't answer my concern yet: more memory will be needed if all PCI bus
numbers (0 to 255) are all valid. Also, 2 bytes are enough: one byte is for
bus number, another byte for devfn. Why we need 3 bytes here?

How many bits of the 16-bits (2-bytes) used as the hash key? I believe it
shouldn't all of them because lot of memory will be consumed for the hash
bucket heads. Since most of cases, we have bus level PE. So it sounds
reasonable to use the "devfn" as hash key, which is one-byte long. In this
case, 2KB (256 * 8) is used for the hash bucket head without any node
populated in the table yet.

Every node would be represented by below data struct, each of which consumes
24-bytes. If the PHB has 5 PCI buses, which is commonly seen, the total consumed
memory will be:

2KB for hash bucket head
30KB for hash nodes: (24 * 256 * 5)

struct pnv_ioda_rid {
       int bdfn;
       int pe_number;
       struct hlist_node node;
};

Don't forget it need more complex to maintain the conflicting list in one
bucket. So I don't see the benefit to use hashtable here.

>
>>On the other hand, searching in hash table buckets
>>have to iterate list of conflicting items (keys), which is slow comparing
>>to what we have.
>
>How often do you expect this code to execute? Is not it setup-type and
>hotplug only? Unless it is thousands times per second, it is not an issue
>here.
>

I was intending to say: hashtable has more complex than array. The data
struct can be as simple as array. I don't see why we bother to have
hashtable here. However, you're correct, the code is just executed at
system booting and hotplug time.

>>Actually, I like the idea, using array to map RID to PE#,
>>which was implemented by Ben.
>
>Where?
>

The array (unsigned char pe_rmap[0x10000]) was introduced by Ben. I think
it's simple enough to finish the simple work: translating RID to PE number.

>>
>>>
>>>>
>>>>  			/* 32-bit TCE tables allocation */
>>>>  			unsigned long		dma32_segcount;
>>>>
>>

Thanks,
Gavin

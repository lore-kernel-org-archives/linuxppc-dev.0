Return-Path: <mel@csn.ul.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3884867A3A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 05:05:22 +1000 (EST)
Date: Mon, 29 May 2006 20:05:15 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
Message-ID: <20060529190515.GA17608@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
	<20060526094924.10efc515.akpm@osdl.org>
	<20060529154923.GA9025@skynet.ie>
	<2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
	<Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
	<c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
From: mel@csn.ul.ie (Mel Gorman)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, vgoyal@in.ibm.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (29/05/06 19:56), Segher Boessenkool didst pronounce:
> >>> #define push_end(res, size) do { unsigned long __sz = (size) ; \
> >>>-	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
> >>>+	resource_size_t farEnd = (res->end + __sz); \
> >>>+	do_div(farEnd, (__sz + 1)); \
> >>>+	res->end = farEnd * (__sz + 1) + __sz; \
> >>>     } while (0)
> >>
> >>Size here is a) a misnomer (size + 1 is the actual size) and b) 
> >>always a power
> >>of two minus one.  So instead, do
> >>
> >>#define push_end(res, mask) res->end = -(-res->end & ~(unsigned 
> >>long)mask)
> >>
> >>(with a do { } while(0) armour if you prefer).
> >>
> >
> >It's not doing the same as the old code so is your suggested fix a 
> >correct replacement?
> >
> >For example, given 0xfff for size the current code rounds res->end to 
> >the next 0x1000 boundary and adds 0xfff. Your propose fix just rounds 
> >it to the next 0x1000 if I'm reading it correctly but is what the code 
> >was meant to do in the first place? Using masks, the equivilant of the 
> >current code is something like;
> >
> >#define push_end(res, mask) do { \
> >	res->end = -(-res->end & ~(unsigned long)mask); \
> >	res->end += mask; \
> >} while (0)
> 
> Yeah forgot a bit, this looks fine.
> 

Ok. The following patch has been successfully boot tested on the same machine
with 64 bit resource_size_t. Because the mask is assumed to be a
power-of-two - 1, I added a comment and a BUG_ON() to be sure.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc4-mm3-clean/arch/powerpc/kernel/pci_32.c linux-2.6.17-rc4-mm3-resources-32/arch/powerpc/kernel/pci_32.c
--- linux-2.6.17-rc4-mm3-clean/arch/powerpc/kernel/pci_32.c	2006-05-29 15:55:52.000000000 +0100
+++ linux-2.6.17-rc4-mm3-resources-32/arch/powerpc/kernel/pci_32.c	2006-05-29 19:09:36.000000000 +0100
@@ -1114,8 +1114,16 @@ check_for_io_childs(struct pci_bus *bus,
 	int	i;
 	int	rc = 0;
 
-#define push_end(res, size) do { unsigned long __sz = (size) ; \
-	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
+	/*
+	 * Assuming mask is a power of two - 1, push_end
+	 * moves res->end to the end of the next
+	 * mask-aligned boundary.
+	 * e.g. res->end of 0x1fff moves to 0x2fff
+	 */
+#define push_end(res, mask) do { \
+	BUG_ON( ((mask+1) & mask) != 0); \
+	res->end = -(-res->end & ~(unsigned long)mask); \
+	res->end += mask; \
     } while (0)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {

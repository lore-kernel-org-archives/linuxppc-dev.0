Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0313020827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ynhl6nbWzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:56:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YnfZ0zgLzDqND
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:54:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43YnfZ07xnz9sMQ; Tue,  8 Jan 2019 20:54:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43YnfY5jdbz9sDr;
 Tue,  8 Jan 2019 20:54:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: [1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
In-Reply-To: <3480116.KzcvcCly6l@debian64>
References: <43V85g033hz9sCX@ozlabs.org> <3480116.KzcvcCly6l@debian64>
Date: Tue, 08 Jan 2019 20:54:28 +1100
Message-ID: <87ef9ntqy3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christian Lamparter <chunkeey@gmail.com> writes:
> On Wednesday, January 2, 2019 12:31:50 PM CET Michael Ellerman wrote:
>> On Tue, 2019-01-01 at 03:56:00 UTC, Michael Ellerman wrote:
>> > Currently the code produces several warnings, eg:
>> > 
>> >   arch/powerpc/platforms/4xx/ocm.c:240:38: error: format '%llx'
>> >   expects argument of type 'long long unsigned int', but argument 3
>> >   has type 'phys_addr_t {aka unsigned int}'
>> >      seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
>> >                                    ~~~^     ~~~~~~~~~
>> > 
>> > Fix it by using the special %pa[p] format for printing phys_addr_t.
>> > Note we need to pass the value by reference for the special specifier
>> > to work.
>> > 
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> 
>> Series applied to powerpc fixes.
>> 
>> https://git.kernel.org/powerpc/c/52b88fa1e8c7bae03bb691178a9f8b
>
> Well, I guess I'm a late. I had issues with the getting 4.20+
> crosscompiled on debian with make-kpkg. 
>
> Nevertheless, I finally got a working kernel and 
> on the MyBook Live APM82181:
>
> ---
> root@mbl:/sys/kernel/debug# cat ppc4xx_ocm/info 
> PPC4XX OCM   : 1
> PhysAddr     : 0x0000000400040000[p]
> MemTotal     : 32768 Bytes
> MemTotal(NC) : 32768 Bytes
> MemTotal(C)  : 0 Bytes
>
> NC.PhysAddr  : 0x0000000400040000[p]
> NC.VirtAddr  : 0x6bc84b36
> NC.MemTotal  : 32768 Bytes
> NC.MemFree   : 32768 Bytes
>
> C.PhysAddr   : 0x0000000000000000[p]
> C.VirtAddr   : 0x  (null)
> C.MemTotal   : 0 Bytes
> C.MemFree    : 0 Bytes

Oh right, I'm an idiot :)

The docs say:

Physical address types phys_addr_t
----------------------------------

	%pa[p]	0x01234567 or 0x0123456789abcdef


And if you grep for that there's eg:

  drivers/ntb/test/ntb_tool.c:                     "Window Size    \t%pa[p]\n",

So I just literally copied that.

But it's trying to indicate that the p is optional.

This should fix it, I won't merge it until you've tested it this time :)

cheers


diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index a1aaa1569d7c..f0e488d97567 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -237,12 +237,12 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 			continue;
 
 		seq_printf(m, "PPC4XX OCM   : %d\n", ocm->index);
-		seq_printf(m, "PhysAddr     : %pa[p]\n", &(ocm->phys));
+		seq_printf(m, "PhysAddr     : %pa\n", &(ocm->phys));
 		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
 		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
 		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
 
-		seq_printf(m, "NC.PhysAddr  : %pa[p]\n", &(ocm->nc.phys));
+		seq_printf(m, "NC.PhysAddr  : %pa\n", &(ocm->nc.phys));
 		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
 		seq_printf(m, "NC.MemTotal  : %d Bytes\n", ocm->nc.memtotal);
 		seq_printf(m, "NC.MemFree   : %d Bytes\n", ocm->nc.memfree);
@@ -252,7 +252,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
 							blk->size, blk->owner);
 		}
 
-		seq_printf(m, "\nC.PhysAddr   : %pa[p]\n", &(ocm->c.phys));
+		seq_printf(m, "\nC.PhysAddr   : %pa\n", &(ocm->c.phys));
 		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
 		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
 		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);

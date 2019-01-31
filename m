Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F9AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 06:17:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7063920870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 06:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pW5BpTql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7063920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qqlh3tzDzDqWZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 17:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pW5BpTql"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qqjH2xPGzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 17:15:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qqjC1Kp4z9v0yF;
 Thu, 31 Jan 2019 07:15:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pW5BpTql; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id MRg_k5zYARGE; Thu, 31 Jan 2019 07:15:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qqjC0G9cz9v0yD;
 Thu, 31 Jan 2019 07:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548915327; bh=+LZp8TSLqcSjHz52Ph+hKRgUaSnwMVC4auzg2+GR1XM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pW5BpTqlpdKYshMzUZ5kuntZqMZ4so9JNnL0IAZlzdHUz4Z6yDx+AsS8e597MIohd
 S75y6g5Vo/FICVohJxmPr7/ozEvjzLDghtf8O91TVTnXlp+2GKplJfJkKWbJ1spAJk
 qPWvCLcJlOfNA12gGCuosoQEtwf10rI/ol7eFfOY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D4C418B78D;
 Thu, 31 Jan 2019 07:15:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dCpysGh5O7aI; Thu, 31 Jan 2019 07:15:27 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D3A458B74C;
 Thu, 31 Jan 2019 07:15:26 +0100 (CET)
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the akpm
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>
References: <20190131163854.307e17ab@canb.auug.org.au>
 <20190131170629.2cc20600@canb.auug.org.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
Date: Thu, 31 Jan 2019 07:15:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131170629.2cc20600@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 31/01/2019 à 07:06, Stephen Rothwell a écrit :
> Hi all,
> 
> On Thu, 31 Jan 2019 16:38:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> [I am guessing that is is something in Andrew's tree that has caused
>> this.]
>>
>> My qemu boot of the powerpc pseries_le_defconfig config failed like this:
>>
>> htab_hash_mask    = 0x1ffff
>> -----------------------------------------------------
>> numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
>> Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 2147483648 bytes align=0x10000 nid=0 from=fffffffffffffff
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
>> Call Trace:
>> [c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliable)
>> [c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
>> [c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
>> [c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
>> [c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
>> [c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
>> [c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
>> [c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c
> 
> A quick bisect leads to this:
> 
> 1c3c9328cde027eb875ba4692f0a5d66b0afe862 is the first bad commit
> commit 1c3c9328cde027eb875ba4692f0a5d66b0afe862
> Author: Mike Rapoport <rppt@linux.ibm.com>
> Date:   Thu Jan 31 10:51:32 2019 +1100
> 
>      treewide: add checks for the return value of memblock_alloc*()
>      
>      Add check for the return value of memblock_alloc*() functions and call
>      panic() in case of error.  The panic message repeats the one used by
>      panicing memblock allocators with adjustment of parameters to include only
>      relevant ones.
>      
>      The replacement was mostly automated with semantic patches like the one
>      below with manual massaging of format strings.
>      
>      @@
>      expression ptr, size, align;
>      @@
>      ptr = memblock_alloc(size, align);
>      + if (!ptr)
>      +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
>      size, align);
>      
>      Link: http://lkml.kernel.org/r/1548057848-15136-20-git-send-email-rppt@linux.ibm.com
>      Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>      Reviewed-by: Guo Ren <ren_guo@c-sky.com>                [c-sky]
>      Acked-by: Paul Burton <paul.burton@mips.com>            [MIPS]
>      Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>    [s390]
>      Reviewed-by: Juergen Gross <jgross@suse.com>            [Xen]
>      Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>  [m68k]
>      Cc: Catalin Marinas <catalin.marinas@arm.com>
>      Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>      Cc: Christoph Hellwig <hch@lst.de>
>      Cc: "David S. Miller" <davem@davemloft.net>
>      Cc: Dennis Zhou <dennis@kernel.org>
>      Cc: Greentime Hu <green.hu@gmail.com>
>      Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Cc: Guan Xuetao <gxt@pku.edu.cn>
>      Cc: Guo Ren <guoren@kernel.org>
>      Cc: Mark Salter <msalter@redhat.com>
>      Cc: Matt Turner <mattst88@gmail.com>
>      Cc: Max Filippov <jcmvbkbc@gmail.com>
>      Cc: Michael Ellerman <mpe@ellerman.id.au>
>      Cc: Michal Simek <monstr@monstr.eu>
>      Cc: Petr Mladek <pmladek@suse.com>
>      Cc: Richard Weinberger <richard@nod.at>
>      Cc: Rich Felker <dalias@libc.org>
>      Cc: Rob Herring <robh+dt@kernel.org>
>      Cc: Rob Herring <robh@kernel.org>
>      Cc: Russell King <linux@armlinux.org.uk>
>      Cc: Stafford Horne <shorne@gmail.com>
>      Cc: Tony Luck <tony.luck@intel.com>
>      Cc: Vineet Gupta <vgupta@synopsys.com>
>      Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Which is just adding the panic we hit.  So, presumably, the bug is in a
> preceding patch :-(
> 
> I have left the kernel not booting for today.
> 

No I think the error is really in that patch, see my other mail.

See 
https://elixir.bootlin.com/linux/v5.0-rc4/source/mm/memblock.c#L1455, 
memblock_alloc_try_nid_raw() is not supposed to panic, so the last hunk 
of this patch should be reverted.

Found in total three problematic hunks in that patch:

@@ -48,6 +53,11 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
  	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
  						__pa(MAX_DMA_ADDRESS),
  						MEMBLOCK_ALLOC_KASAN, node);
+	if (!p)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE, node,
+		      __pa(MAX_DMA_ADDRESS));
+
  	return __pa(p);
  }

@@ -211,6 +211,9 @@ static int __init iob_init(struct device_node *dn)
  	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
  					MEMBLOCK_LOW_LIMIT, 0x80000000,
  					NUMA_NO_NODE);
+	if (!iob_l2_base)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx max_addr=%x\n",
+		      __func__, 1UL << 21, 1UL << 21, 0x80000000);

  	pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);


@@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long 
size, int nid)
  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
  						__pa(MAX_DMA_ADDRESS),
  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	if (!sparsemap_buf)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
+		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
+
  	sparsemap_buf_end = sparsemap_buf + size;
  }



Christophe

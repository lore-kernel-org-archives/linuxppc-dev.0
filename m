Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC70C20771
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ORAhFp6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC70C20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBNm21txqzDqSL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 15:08:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBNWG4qY6zDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:57:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ORAhFp6k; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBNWG0rcZz9sR4;
 Wed, 22 Jul 2020 14:57:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595393866;
 bh=B8pvBVrzIk29D7BwkDHq1IDzv+qZD9WYtxIsi82itCE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ORAhFp6k3aMjyeZ8pIU35Rov5Q4Vn3tJEvTBD2jdUn9TfHhHe5rU4JappLOidtCTk
 29nhbOBDsfHkbaPKTcsdnTU6xQHlVqM6dvwEqopapoqmSAH08sOUnxQb9+Kh+nJix2
 MOJq/8j9fBuiCU24jZ8G49/dSx4okeIR0wTI7MylayNp7B+XghCEZaMGNxKY1DMifd
 bJYmaYRszNW7FF5cn27XpFCkRF7eEpEQ2hVZ8cJ0R6rWeU3gRvYY8jDEZdVT+Kbwhf
 Q5IvraAttjLGJhfCV3hXxdwXD0rqzlNycAEy4tfm9sbIHJXJcuahNrGh63HHh6sced
 d35JgWF5L7Jmw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
In-Reply-To: <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
Date: Wed, 22 Jul 2020 14:57:45 +1000
Message-ID: <87pn8oqh86.fsf@mpe.ellerman.id.au>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, kexec@lists.infradead.org,
 Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Pingfan Liu <kernelfans@gmail.com> writes:
> A bug is observed on pseries by taking the following steps on rhel:
                                                                ^
                                                                RHEL

I assume it happens on mainline too?

> -1. drmgr -c mem -r -q 5
> -2. echo c > /proc/sysrq-trigger
>
> And then, the failure looks like:
> kdump: saving to /sysroot//var/crash/127.0.0.1-2020-01-16-02:06:14/
> kdump: saving vmcore-dmesg.txt
> kdump: saving vmcore-dmesg.txt complete
> kdump: saving vmcore
>  Checking for memory holes                         : [  0.0 %] /                   Checking for memory holes                         : [100.0 %] |                   Excluding unnecessary pages                       : [100.0 %] \                   Copying data                                      : [  0.3 %] -          eta: 38s[   44.337636] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
> [   44.337663] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
> [   44.337677] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
> [   44.337692] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
> [   44.337708] makedumpfile[469]: unhandled signal 7 at 00007fffba400000 nip 00007fffbbc4d7fc lr 000000011356ca3c code 2
> [   44.338548] Core dump to |/bin/false pipe failed
> /lib/kdump-lib-initramfs.sh: line 98:   469 Bus error               $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete
> kdump: saving vmcore failed
>
> * Root cause *
>   After analyzing, it turns out that in the current implementation,
> when hot-removing lmb, the KOBJ_REMOVE event ejects before the dt updating as
> the code __remove_memory() comes before drmem_update_dt().
> So in kdump kernel, when read_from_oldmem() resorts to
> pSeries_lpar_hpte_insert() to install hpte, but fails with -2 due to
> non-exist pfn. And finally, low_hash_fault() raise SIGBUS to process, as it
> can be observed "Bus error"
>
> From a viewpoint of listener and publisher, the publisher notifies the
> listener before data is ready.  This introduces a problem where udev
> launches kexec-tools (due to KOBJ_REMOVE) and loads a stale dt before
> updating. And in capture kernel, makedumpfile will access the memory based
> on the stale dt info, and hit a SIGBUS error due to an un-existed lmb.
>
> * Fix *
>   In order to fix this issue, update dt before __remove_memory(), and
> accordingly the same rule in hot-add path.
>
> This will introduce extra dt updating payload for each involved lmb when hotplug.
> But it should be fine since drmem_update_dt() is memory based operation and
> hotplug is not a hot path.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> To: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> ---
> v2 -> v3: rebase onto ppc next-test branch
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 1a3ac3b..def8cb3f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -372,6 +372,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  	invalidate_lmb_associativity_index(lmb);
>  	lmb_clear_nid(lmb);
>  	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> +	drmem_update_dt();

No error checking?

>  	__remove_memory(nid, base_addr, block_sz);
>  
> @@ -607,6 +608,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  
>  	lmb_set_nid(lmb);
>  	lmb->flags |= DRCONF_MEM_ASSIGNED;
> +	drmem_update_dt();

And here ..
>  
>  	block_sz = memory_block_size_bytes();
>  
> @@ -625,6 +627,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  		invalidate_lmb_associativity_index(lmb);
>  		lmb_clear_nid(lmb);
>  		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> +		drmem_update_dt();


And here ..

>  		__remove_memory(nid, base_addr, block_sz);
>  	}
> @@ -877,9 +880,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  		break;
>  	}
>  
> -	if (!rc)
> -		rc = drmem_update_dt();
> -
>  	unlock_device_hotplug();
>  	return rc;

Whereas previously we did check it.


cheers

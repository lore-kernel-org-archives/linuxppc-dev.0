Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D2606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFNDj9se
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTX2W16Ccz2xl0;
	Wed, 18 Nov 2026 04:36:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794936963;
	cv=none; b=OQqj+NRRsVb/iziUHW3YU7Vgdt0MY+3rifw6KLiKS2V1qAYHS6+3lb13nBBAADeVn2yetXyWjn9qGPp/0Fvu0Hu1kXetP9WNQOi2yzBEKSZ3m3QLCqR6JEYySIY7d8jjYerxh68vCIN18vywFHQTYkfocX7UlJYYyCQ190+1W01N40EntN2QrayOFl/O5vl6zu39xDW/o7vsyqmvZql4uxkh5kl/HP1dHy/o63NCpMndE3m1FFLhl1AXJmtdMHprBIGxME6KiyEdhtlidkJoDvAOzQktekHRvDnho5TtrYzZDAtBVoZfjsB0fNHaReYSp2DvRveErx+XdTfxAUOyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794936963; c=relaxed/relaxed;
	bh=DiwDSqqY3noD1OsmVqWHD0ic/HvrhuFYXysk4k3SnZc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=bgJR9c48TNAp0c6WwnfnfRu5HibqnWQhdorl5+hJqmJ0wwUig0pGo3UoBNZEtmGbYnlgtfuC7Ha9tDpsR6Ixf3wVXRtkYtObJLVatyW8XpywQsI+ZVWtVpengLu4ZyrLJlsDVgGbqAjipDH3OPzxv7nk8s46uXC1d83HGzite+zrRL5chYcL6UhG6Li2qji0l4VfXW8D/TbU3UiLDhu3RijSqizqRNIeg9zSF32VlKi4yNyuNbaSv8E1LQtieSZX5xdXfD29NX1pqW9xQIb79oNVs7ZVjo8At++kBxKZwgGTAMC096R+DRQoRqIMF5txBM4As8uUw3YUBWQY1o9WSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFNDj9se; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFNDj9se;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTX2V3dPfz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:36:02 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-3282db206d3so231777eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936960; x=1795541760; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DiwDSqqY3noD1OsmVqWHD0ic/HvrhuFYXysk4k3SnZc=;
        b=JFNDj9segcHdVhNwnJlUpeSK1kZcFLNslWBWbwOrjZ0/QseNCLJb9d4DbFhhaIfEp6
         wf6rpc2dcT8U7hllqHRcX3l9PZZUk1EkOp5cwpk0bKjR3GpsspTdqQNDiG1ed757ypoC
         MsWrJp6nSYBxUtVFmSGppbwPs5zadnjT3ppsanjmQ43bkLjnMlX0AenhJnyaj6XwSZ6+
         gNxJrd+fuFmfufOWS49iButSIRGdOLdfp92AEwRhkp4mAHjdm3vF/CuhVC8OImwYiT43
         RpAe4y+J3sQmq7REmJi3eWO1UGbYVVmXIzLjbfr3jhTrXMM5L6Zsy9WtCuWQanebEFIg
         Oarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936960; x=1795541760;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiwDSqqY3noD1OsmVqWHD0ic/HvrhuFYXysk4k3SnZc=;
        b=L48TsBdBKDHTcA11LgigUzib/eYKdfeWJ7bX/Rmcu1/LHIDN+3bXN7iGRYgXnaaPGo
         pgk8eSLPLRGYoxZ2XkekVEF33NwWFkYZzZrCyoyQezV5UtRTPKBMj4EZkiNl0iiApI3e
         dOVh9rTJ6KsN2sR9zRRK/YcIOlFeKB1CzXlKMBHRAMKmqjVwNJ9okeY9G/NT2rdHVaC4
         etiIb75A8Hgn2AHQKXyW6wSEdgTXJmF/A41PzXheBO7MFtkDmJn94jOVlsv7Mk5Y4u94
         fblxiLqvebX4vpA1QccaBN9HQKx2UC7gdj8b2dHya1TW3sZ4cjDLE1BSIqXPbxjboFmW
         yC/Q==
X-Gm-Message-State: APuU4Z8SDygn7Dn3hWH537dp9hT8GSQN+7OqWa57dfV1Ym7r88sxwsP3
	AZvQq08ULlUgga5B4zmGtCKdNPj6DDgHPnMNy/AKOznRyW00+fZH4c62jQ3ZDc//
X-Gm-Gg: AYBFou1nNpL1IwqMsPy476uaovwC8OYaRHfZa8FLsP0e78Npr0peK0BaWuDnF1XiCPz
	0Hh579P1VZ95Oklv2YHp9gJ5sanPr/CLTR0P/QZX+iR9GKG/gWwVdP7tCR+KEqyo2mT4G4JSOqh
	Y0AgdYhHjh8Tp9iAuN85wcGCFlr5gooOmZVHbjNBXPDQ8LAekQU68DfnM3QtJrvLTHLidF9utMS
	NYlTUnlvp0gzT9aQmd8tlvXRW4nvVkdaAO0Z4CrS0oAJicFZdn0e97uzUixKow4i3fP7p5q4aGt
	BAEDwC1Ih656eeBQ2TxFCwA0kT/a3TTyljTMWefLDvfK0hH/4e8JBp+NKPGVxEB+cxsb2Hvoqlq
	Nk5XHB8trjx0n1lB/N46UzYbWfprWxvzEwcybvlfiBNbo+5EPvjEpJ4BpIUYA0CJ2IijXPrFGMR
	OnWXJJqkNlxKfIUIcFYHIedTDGkjAI2/MZoOJU7z4yG12NgdrVKfPTFuYYQeF2wu3rR88GVfH5c
	B1rAJRdTndnUhOnICTMyYJKXDqZcq01xgMz3YmnMUrIRjVo582nxKAS30pdytrLD3/NryrbaMYf
	Z28HXvCqZHrr+k2HocrjtMgHNb88
X-Received: by 2002:a05:701b:2058:20b0:1b5:3878:aa29 with SMTP id a92af1059eb24-1b543d355fbmr247604c88.38.1794936960214;
        Tue, 17 Nov 2026 09:36:00 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm61333595c88.9.2026.11.17.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:35:59 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
In-Reply-To: <avxhmaXa7lsQ86EA@kernel.org>
Date: Tue, 17 Nov 2026 23:03:41 +0530
Message-ID: <tslf747e.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com> <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com> <avltdwzlh07VZSFC@kernel.org> <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org> <avsn7Kn4a8wbB2QH@kernel.org> <zev77i3i.ritesh.list@gmail.com> <eb634d1f-cb08-44a8-88c9-e3b559c399a3@kernel.org> <avxhmaXa7lsQ86EA@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mike Rapoport <rppt@kernel.org> writes:

> On Tue, Nov 17, 2026 at 03:04:49PM +0100, Christophe Leroy (CS GROUP) wrote:
>> Le 17/11/2026 à 13:33, Ritesh Harjani a écrit :
>> > Mike Rapoport <rppt@kernel.org> writes:
>> > 
>> > > > > > Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
>> > > > > Right, I missed that on book3s/32 does vmalloc is not executable and its
>> > > > > protection can't be changed.
>> > > > > 
>> > > > > Could it be that 8xx also need a special treatment for kprobes?
>> > > > 
>> > > > Yes indeed, not for the same reasons but because 8xx ITLB-miss handler
>> > > > doesn't expect any instruction TLB miss on kernel addresses other than the
>> > > > ones from the module area:
>> > > > 
>> > > > Commit 4afb0be7ccda ("powerpc/8xx: Avoid testing for kernel space in ITLB
>> > > > Miss.")
>> > > > Commit 16a71c045186 ("powerpc/8xx: Preallocate execmem page tables")
>> > > > Commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in ITLB
>> > > > misses")
>> > 
>> > Right. I looked at the above series which added all of this support [1].
>> > So looks like 603 might also have this related problem (other than the
>> > per segment N bit issue), since it's iTLB miss handler only walks the
>> > task's PGDIR, unlike it's dTLB handler which falls back to reloading the
>> > missing kernel PGD entry from swapper_pg_dir. So what I meant to say is
>> > that, similar to 8xx, a new PGD entry created in the kernel's vmalloc
>> > area for an insn page does not get copied over after the task is
>> > created (/PGDIR allocated), on 603 as well.
>> > But since MODLUES_VADDR is defined for both BOOK3S/32 and 8xx, so I guess it
>> > gets covered by the same change anyways.
>> > 
>> > > > So at the end as MODULES_VADDR/MODULES_END only exist on book3s/32 and 8xx I
>> > > > think when they exist they should be used as follows:
>> > > > 
>> > > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> > > > index b617b69452cd..856f4609c488 100644
>> > > > --- a/arch/powerpc/mm/mem.c
>> > > > +++ b/arch/powerpc/mm/mem.c
>> > > > @@ -428,8 +428,13 @@ struct execmem_info __init *execmem_arch_setup(void)
>> > > >   				.fallback_end	= fallback_end,
>> > > >   			},
>> > > >   			[EXECMEM_KPROBES] = {
>> > > > +#ifdef MODULES_VADDR
>> > > > +				.start	= MODULES_VADDR,
>> > > > +				.end	= MODULES_END,
>> > > > +#else
>> > > >   				.start	= VMALLOC_START,
>> > > >   				.end	= VMALLOC_END,
>> > > > +#endif
>> > > 
>> > > We already have #ifdef MODULES_VADDR a few lines above, I think the
>> > > assignment of kprobes_start and kprobes_end could go there instead of if
>> > > (IS_ENABLED(CONFIG_PPC_BOOK3S_32)).
>> > > 
>> > 
>> > Right. So let me use the following diff then?
>> > 
>> > Please let me know if this diff looks good to you? If yes, then I can
>> > send a v3.
>> 
>> My preference would go to something similar to 'start' and 'end', no init at
>> declaration, kprobes_start and kprobes_end set to VMALLOC_START/VMALLOC_END
>> inside the #else

Sure.

>
> I agree, it's more consistent this way.
>  

Ok, then will go with the other approach.

>> > Also - it will be good to know if patch-1 and patch-3 looks ok too,
>> > before I spin a next revision?
>
> Both make sense to me, feel free to add my
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>

Thanks Mike and Christophe. Will make the changes in v3 as discussed.

-ritesh


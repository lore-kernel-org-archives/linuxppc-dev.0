Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7hdf26RfzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 14:49:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: rebuild vdsos correctly
In-Reply-To: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
References: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
Date: Tue, 09 Aug 2016 14:49:25 +1000
Message-ID: <87y446r1gq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index cbabd14..ae1f245 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -39,14 +39,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
>  # assembly rules for the .S files
> -$(obj-vdso32): %.o: %.S
> +$(obj-vdso32): %.o: %.S FORCE
>  	$(call if_changed_dep,vdso32as)
>  
>  # actual build commands
>  quiet_cmd_vdso32ld = VDSO32L $@
> -      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
> +      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
>  quiet_cmd_vdso32as = VDSO32A $@
> -      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
> +      cmd_vdso32as = $(CROSS32CC) $(a_flags) -o $@ -c $<

Are the two changes above required, they aren't obviously related.

cheers

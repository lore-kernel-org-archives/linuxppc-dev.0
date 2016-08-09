Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rj16PsvzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:52:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: rebuild vdsos correctly
In-Reply-To: <20160809155342.06731f98@roar.ozlabs.ibm.com>
References: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
 <87y446r1gq.fsf@concordia.ellerman.id.au>
 <20160809155342.06731f98@roar.ozlabs.ibm.com>
Date: Tue, 09 Aug 2016 20:52:49 +1000
Message-ID: <8760rausce.fsf@concordia.ellerman.id.au>
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

> On Tue, 09 Aug 2016 14:49:25 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
>> > index cbabd14..ae1f245 100644
>> > --- a/arch/powerpc/kernel/vdso32/Makefile
>> > +++ b/arch/powerpc/kernel/vdso32/Makefile
>> > @@ -39,14 +39,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>> >  	$(call if_changed,objcopy)
>> >  
>> >  # assembly rules for the .S files
>> > -$(obj-vdso32): %.o: %.S
>> > +$(obj-vdso32): %.o: %.S FORCE
>> >  	$(call if_changed_dep,vdso32as)
>> >  
>> >  # actual build commands
>> >  quiet_cmd_vdso32ld = VDSO32L $@
>> > -      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
>> > +      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
>> >  quiet_cmd_vdso32as = VDSO32A $@
>> > -      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
>> > +      cmd_vdso32as = $(CROSS32CC) $(a_flags) -o $@ -c $<  
>> 
>> Are the two changes above required, they aren't obviously related.
>
> The vdso32ld change is required because otherwise "FORCE" gets put on
> the end of the command line. vdso32as... I think is not required. Want
> a new version without it?

Yeah either without it or just explaining why it's needed in the change log.

cheers

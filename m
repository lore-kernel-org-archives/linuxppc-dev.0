Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7k3z5Y6CzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 15:53:51 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vy10so361770pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 22:53:51 -0700 (PDT)
Date: Tue, 9 Aug 2016 15:53:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: rebuild vdsos correctly
Message-ID: <20160809155342.06731f98@roar.ozlabs.ibm.com>
In-Reply-To: <87y446r1gq.fsf@concordia.ellerman.id.au>
References: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
 <87y446r1gq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 09 Aug 2016 14:49:25 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> > index cbabd14..ae1f245 100644
> > --- a/arch/powerpc/kernel/vdso32/Makefile
> > +++ b/arch/powerpc/kernel/vdso32/Makefile
> > @@ -39,14 +39,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
> >  	$(call if_changed,objcopy)
> >  
> >  # assembly rules for the .S files
> > -$(obj-vdso32): %.o: %.S
> > +$(obj-vdso32): %.o: %.S FORCE
> >  	$(call if_changed_dep,vdso32as)
> >  
> >  # actual build commands
> >  quiet_cmd_vdso32ld = VDSO32L $@
> > -      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
> > +      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
> >  quiet_cmd_vdso32as = VDSO32A $@
> > -      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
> > +      cmd_vdso32as = $(CROSS32CC) $(a_flags) -o $@ -c $<  
> 
> Are the two changes above required, they aren't obviously related.

The vdso32ld change is required because otherwise "FORCE" gets put on
the end of the command line. vdso32as... I think is not required. Want
a new version without it?

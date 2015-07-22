Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1BE01A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:11:29 +1000 (AEST)
Message-ID: <1437541889.16792.11.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Long <dave.long@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>,  Ingo Molnar <mingo@redhat.com>, Jan Willeke
 <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>,  Martin
 Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov
 <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>,  Paul Mackerras
 <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter
 <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King
 <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-s390@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
 linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>
Date: Wed, 22 Jul 2015 15:11:29 +1000
In-Reply-To: <55AF2037.2000803@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
 <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
 <5581BCD0.2040405@linaro.org> <1435634945.24866.2.camel@ellerman.id.au>
 <55AF2037.2000803@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-22 at 00:46 -0400, David Long wrote:
> On 06/29/15 23:29, Michael Ellerman wrote:
> > On Wed, 2015-06-17 at 14:30 -0400, David Long wrote:
> >> On 06/16/15 09:17, Rob Herring wrote:
> >>> On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> >>>>
> >>>>    #define REG_OFFSET_NAME(r) \
> >>>>           {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
> >>>>    #define REG_OFFSET_END {.name = NULL, .offset = 0}
> >>>
> >>> Can't you also move these? ARM is complicated with the "ARM_"
> >>> prefixing, but the others appear to be the same. Maybe you can remove
> >>> the prefix or redefine the macro for ARM.
> >>
> >> That would mandate that all the architecture-specific pt_regs structures
> >> would have to use a top-level named field for each named register.
> >
> > Why does it mandate that?
> >
> > See eg. powerpc where we use REG_OFFSET_NAME for the top-level named fields and
> > then a different macro for the array elements:
> >
> >    #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
> >    #define GPR_OFFSET_NAME(num)	\
> >    	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
> >
> >    static const struct pt_regs_offset regoffset_table[] = {
> >    	GPR_OFFSET_NAME(0),
> >    	GPR_OFFSET_NAME(1),
> >    	GPR_OFFSET_NAME(2),
> >    	GPR_OFFSET_NAME(3),
> >    	...
> >    	REG_OFFSET_NAME(nip),
> >    	REG_OFFSET_NAME(msr),
> >
> >
> > So I don't see why REG_OFFSET_NAME couldn't be common.
> >
> 
> Sorry for the delay in responding to this.
> 
> OK, so you're saying architectures that don't want this constraint can 
> make their own macro.  Seems to make this whole exercise slightly less 
> useful, but whatever.

Well yeah.

In fact of the 4 arches that use REG_OFFSET_NAME, 2 already have another macro
for specially named registers (powerpc & sh).

> I see three ways to go here:
> 
> 1) Leave it as is.
> 2) Force all architectures to use a common definition.
> 3) Provide a common definition that all architectures (except "arm") 
> currently using this functionality will use.
> 
> I have a v2 patch to implement #3, ready to post.  Do we think this is 
> the way to go?

Yeah I think it is. How are you making it conditional? Just #ifndef REG_OFFSET_NAME?

> I don't like #2 because I really don't want to rename all 
> uses of the current register fields for arm since this is 
> architecture-specific code to begin with and since it affects code in 39 
> arm source files.

I guess you're talking about renaming all the ARM_x regs to x. That would
likely cause problems because they're implemented as #defines,
eg. #define r0 uregs[0] would probably confuse your assembler.

The clean thing to do would be to have the in-kernel struct pt_regs have actual
named members, but that would still be an intrusive change.

cheers

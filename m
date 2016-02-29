Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0D0D1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 16:54:54 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7640F1402BF
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 16:54:54 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 15:54:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1B0892CE805C
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 16:54:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1T5shHM6029740
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 16:54:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1T5sIus013673
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 16:54:18 +1100
Date: Mon, 29 Feb 2016 11:23:28 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
Message-ID: <20160229055328.GB20786@naverao1-tp.ibm.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
 <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
 <20160224142738.GB18778@naverao1-tp.ibm.com>
 <20160225104441.6e7fe396@camb691>
 <20160225062205.GA20786@naverao1-tp.ibm.com>
 <20160226091846.76c9ac6d@camb691>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160226091846.76c9ac6d@camb691>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/26 09:18AM, Cyril Bur wrote:
> On Thu, 25 Feb 2016 11:52:05 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2016/02/25 10:44AM, Cyril Bur wrote:
> > > On Wed, 24 Feb 2016 19:57:38 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > >   
> > > > On 2016/02/23 02:38PM, Cyril Bur wrote:  
> > > > > Test that the non volatile floating point and Altivec registers get
> > > > > correctly preserved across the fork() syscall.
> > > > > 
> > > > > fork() works nicely for this purpose, the registers should be the same for
> > > > > both parent and child
> > > > > 
> > > > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > > > ---  
> > 
> > <snip>
> > 
> > > > > diff --git a/tools/testing/selftests/powerpc/basic_asm.h 
> > > > > b/tools/testing/selftests/powerpc/basic_asm.h
> > > > > new file mode 100644
> > > > > index 0000000..f56482f
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/powerpc/basic_asm.h
> > > > > @@ -0,0 +1,62 @@
> > > > > +#include <ppc-asm.h>
> > > > > +#include <asm/unistd.h>
> > > > > +
> > > > > +#if defined(_CALL_ELF) && _CALL_ELF == 2
> > > > > +#define STACK_FRAME_MIN_SIZE 32
> > > > > +#define STACK_FRAME_TOC_POS  24
> > > > > +#define __STACK_FRAME_PARAM(_param)  (32 + ((_param)*8))
> > > > > +#define __STACK_FRAME_LOCAL(_num_params,_var_num)  ((STACK_FRAME_PARAM(_num_params)) + ((_var_num)*8))
> > > > > +#else
> > > > > +#define STACK_FRAME_MIN_SIZE 112
> > > > > +#define STACK_FRAME_TOC_POS  40
> > > > > +#define __STACK_FRAME_PARAM(i)  (48 + ((i)*8))
> > > > > +/*
> > > > > + * Caveat: if a function passed more than 8 params, the caller will have
> > > > > + * made more space... this should be reflected by this C code.
> > > > > + * if (_num_params > 8)
> > > > > + *     total = 112 + ((_num_params - 8) * 8)
> > > > > + *
> > > > > + * And substitute the '112' for 'total' in the macro. Doable in preprocessor for ASM?
> > > > > + */    
> > > > 
> > > > Per my understanding, the parameter save area is only for parameters to 
> > > > functions that *we* call. And since we control that, I don't think we 
> > > > need to worry about having more than 8 parameters.
> > > >   
> > > 
> > > Yes, I just thought I'd put that there to prevent anyone blindly reusing this
> > > macro somewhere and getting stung. But you're correct, we don't need to worry
> > > about this caveat for this code.  
> > 
> > Agreed, so probably a simpler warning will suffice. Also, it is worth 
> > noting that this is not necessarily 8 parameters, but 8 doublewords - we 
> > may have less number of parameters, but may still need more than 8 
> > doublewords.
> > 
> 
> True, happy to send s/params/doublewords/ if it's that important.

It is, 8 parameters vs 8 doublewords mean different things.

> 
> > >   
> > > > > +#define __STACK_FRAME_LOCAL(_num_params,_var_num)  (112 + ((_var_num)*8))
> > > > > +#endif
> > > > > +/* Parameter x saved to the stack */
> > > > > +#define STACK_FRAME_PARAM(var)    __STACK_FRAME_PARAM(var)
> > > > > +/* Local variable x saved to the stack after x parameters */
> > > > > +#define STACK_FRAME_LOCAL(num_params,var)    __STACK_FRAME_LOCAL(num_params,var)    
> > > > 
> > > > So this works, but I'm wondering if this is really worth the code 
> > > > complexity - every use needs to determine appropriate extra stack space, 
> > > > the number of parameters to save and so on.  This is after all for 
> > > > selftests and so, we probably don't need to be precise in stack space 
> > > > usage. We can get away using a larger fixed size stack.  That will 
> > > > simplify a lot of the code further on and future tests won't need to 
> > > > bother with all the details.
> > > >   
> > > 
> > > So I agree that we don't need to be precise about stack space at all (I'm sure
> > > you noticed all my stack pushes and pops are very overestimated in size).
> > > 
> > > I should probably go back to basics and explain how these macros started. In
> > > writing all this I got fed up of typing the PUSH_BASIC_STACK and
> > > POP_BASIC_STACK macro out at the start of each function. I wasn't trying to
> > > macro out the entire calling convention and honestly I don't think it is a good
> > > idea. The more easy to use/abstracted the macros get the less flexible they  
> > 
> > The simplification here is largely in terms of the stack size and the 
> > fpu/gpr/vmx save areas. I don't think most tests would need more control 
> > there. For the few tests that may need it, they can always hand code or 
> > introduce different macros.
> > 
> 
> It seems like your goal here is to make it so easy to write asm with these
> macros that the programmer shouldn't need to open the abi because it's all done

I'm sorry, but I don't know how you got that impression. Let me clarify: 
this is only for selftests where there are no specific requirements on 
how the stack frame is set up (which I expect to be the common case 
including all the selftests you've written).

> for them. Lets just stick to the avoiding pointless repetition/avoiding silly
> mistakes feature of macros.
> 
> If these macros all of a sudden take off and every selftest programmer
> complains they aren't simple enough, perhaps we can revisit.

Right, though it's just about how the stack is handled.

> 
> > > become. These being selftests, I expect that people might want to do
> > > funky/questionable/hacky things, flexibility in the macros might help with that.  
> > 
> > Sure, but having every test deal with the intricacies of the stack is 
> > not good. It's better to have simple macros that work for the common 
> > generic case and consider introducing more specific macros/hard coding 
> > where more control is desired.
> > 
> 
> But what is the common general case? Isn't the common general case writing in C
> and if you've devolved into .S files its likely you're doing something not
> common or general?

Like I said earlier, what I'm proposing is only about how the stack gets 
handled. If that's the only thing your code is doing differently in asm 
(which doesn't seem to be the case), then sure, the generic macros may 
not work.  That's for you to take a call on.

But, I don't quite understand why you think that specific control over 
stack frame setup is a *must* for all asm code? Surely there is more to 
asm than that...


- Naveen

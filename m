Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-yw0-x231.google.com (mail-yw0-x231.google.com
 [IPv6:2607:f8b0:4002:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYH5w2wtrzDqfr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 14:56:03 +1000 (AEST)
Received: by mail-yw0-x231.google.com with SMTP id p73so87578642ywp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 21:56:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0a79517a-c9eb-6eca-4048-de20d4543114@us.ibm.com>
References: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
 <0a79517a-c9eb-6eca-4048-de20d4543114@us.ibm.com>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Thu, 25 May 2017 14:56:00 +1000
Message-ID: <CAPoR37YQ-9Q=HacFVrWDg_aS=rPhWhB_SuuevdZDCA2Vu=AVyg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/lib: Split xor_vmx file to guarantee instruction
 ordering
To: pc@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 24, 2017 at 11:36 PM, Paul Clarke <pc@us.ibm.com> wrote:
> On 05/23/2017 06:45 PM, Matt Brown wrote:
>> The xor_vmx.c file is used for the RAID5 xor operations. In these functions
>> altivec is enabled to run the operation and then disabled. However due to
>> compiler instruction reordering, altivec instructions are being run before
>> enable_altivec() and after disable_altivec().
>
> If altivec instructions can be reordered after disable_altivec(), then disable_altivec() is broken, I'd think.
>
> Could it be because the isync in mtmsr_isync() is after the mtmsr?
>
> disable_kernel_altivec
> - msr_check_and_clear
>   - __msr_check_and_clear
>     - mtmsr_isync

So it turns out the enable / disable functions don't actually enable
or disable the use of vector instructions.
If we have marked the file to be compiled with altivec the compiler
has free reign to reorder the vector instructions wherever it likes.
Including reordering it before or after the enable/disable_altivec
commands.

The enable_kernel_altivec and disable_kernel_altivec functions are
mainly there to empty and restore the vector registers which could
have been used in user-space. So those functions work as intended,
although not particularly intuitive.

Splitting the files and only compiling the xor_vmx.c file with altivec
will guarantee that there are no vector instructions in the
xor_vmx_glue.c file, and that no vector instructions are outside of
the enable/disable block.


- Matt Brown

>
> PC
>

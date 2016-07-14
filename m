Return-Path: <chzigotzky@bayern-mail.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtqj4nWbzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:33:21 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@bayern-mail.de>
Subject: Kernel 4.1.28: Update TM user feature bits in scan_features()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <01f37269-7f95-225a-b09e-2f1995a394a3@bayern-mail.de>
 <87d1mga311.fsf@@concordia.ellerman.id.au>
Cc: Pat Wall <pjwall@mac.com>, Darren Stevens <darren@stevens-zone.net>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@me.com>,
 Julian Margetson <runaway@candw.ms>, "contact@a-eon.com"
 <contact@a-eon.com>, Alex Perez <aperez@alexperez.com>,
 luigi burdo <intermediadc@hotmail.com>, "R.T.Dickinson" <rtd@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, Sasha Levin <sasha.levin@oracle.com>
Message-ID: <45730340-be42-4307-6c00-5328b2552d98@bayern-mail.de>
Date: Thu, 14 Jul 2016 13:33:09 +0200
MIME-Version: 1.0
In-Reply-To: <87d1mga311.fsf@@concordia.ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------C533E014D749A6D5A9FFF5D7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------C533E014D749A6D5A9FFF5D7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

When I received your email with your solution, I had already compiled 
the kernel 4.1.28 with the following temporary solution:

Not suitable for 4.1-stable (no PPC_FEATURE2_HTM_NOSC_COMP).

-     * If the kernel doesn't support TM (ie 
CONFIG_PPC_TRANSACTIONAL_MEM=n),
-     * we don't want to turn on TM here, so we use the *_COMP versions
-     * which are 0 if the kernel doesn't support TM.
+     * If the kernel doesn't support TM (ie. 
CONFIG_PPC_TRANSACTIONAL_MEM=n),
+     * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
+     * which is 0 if the kernel doesn't support TM.
       */
-    {CPU_FTR_TM_COMP, 0, 0,
-     PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
+    {CPU_FTR_TM_COMP, 0, 0, 0,        22, 0, 0},
  };

The kernel boots and KVM PR works. I tested it with Mac-on-Linux/KVM PR 
and Mac OS X Tiger as guest system. I will try your solution too.

Many thanks for your fast response!

Cheers,

Christian


On 14 July 2016 at 1:10 PM, Michael Ellerman wrote:
> Christian Zigotzky<chzigotzky@bayern-mail.de>  writes:
>
>> Hi All,
>>
>> I tried to compile the kernel 4.1.28 today. Unfortunately it doesn't
>> compile because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.
>>
>> Error message:
>>
>>     CHK     include/config/kernel.release
>>     CHK     include/generated/uapi/linux/version.h
>>     CHK     include/generated/utsrelease.h
>>     CHK     include/generated/bounds.h
>>     CHK     include/generated/asm-offsets.h
>>     CALL    scripts/checksyscalls.sh
>>     CHK     include/generated/compile.h
>>     CALL    arch/powerpc/kernel/systbl_chk.sh
>>     CC      arch/powerpc/kernel/prom.o
>> arch/powerpc/kernel/prom.c:170:25: error: 'PPC_FEATURE2_HTM_NOSC_COMP'
>> undeclared here (not in a function)
>>      PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
>>                            ^
>> make[1]: *** [arch/powerpc/kernel/prom.o] Error 1
>> make: *** [arch/powerpc/kernel] Error 2
>>
>> ---
>>
>> Commit:
>>
>> f49eb503f0f9ab66874a81992b14249a1c59b6ad
>> Author: Anton Blanchard<anton@samba.org>
>> Date:   Fri Apr 15 12:08:19 2016 +1000
>>
>>       powerpc: Update TM user feature bits in scan_features()
>>
>>       [ Upstream commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017 ]
>>
>>       We need to update the user TM feature bits (PPC_FEATURE2_HTM and
>>       PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
>>       bit.
>>
>>       At the moment, if firmware reports TM is not available we turn off
>>       the kernel TM feature bit but leave the userspace ones on. Userspace
>>       thinks it can execute TM instructions and it dies trying.
>>
>>       This (together with a QEMU patch) fixes PR KVM, which doesn't currently
>>       support TM.
>>
>>       Signed-off-by: Anton Blanchard<anton@samba.org>
>>       Cc:stable@vger.kernel.org
>>       Signed-off-by: Michael Ellerman<mpe@ellerman.id.au>
>>       Signed-off-by: Sasha Levin<sasha.levin@oracle.com>
>>
>> ---
>>
>> PPC_FEATURE2_HTM_NOSC_COMP isn't defined or doesn't exist in the
>> following files:
> Thanks.
>
>> arch/powerpc/include/asm/cputable.h
>> arch/powerpc/kernel/cputable.c
>> arch/powerpc/include/uapi/asm/tm.h
>>
>> That means the following patches aren't included in the 4.1.28 source code:
> Sorry that's the wrong fix.
>
> PPC_FEATURE2_HTM_NOSC indicates the presence of a certain kernel
> behaviour, which has *not* been backported to 4.1.
>
> The right fix is just to remove the reference to PPC_FEATURE2_HTM_NOSC
> in 4.1.28.
>
> eg:
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 28dbbb0d12c4..9b19d96e9562 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -166,8 +166,7 @@ static struct ibm_pa_feature {
>   	 * we don't want to turn on TM here, so we use the *_COMP versions
>   	 * which are 0 if the kernel doesn't support TM.
>   	 */
> -	{CPU_FTR_TM_COMP, 0, 0,
> -	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
> +	{CPU_FTR_TM_COMP, 0, 0, PPC_FEATURE2_HTM_COMP, 22, 0, 0},
>   };
>   
>   static void __init scan_features(unsigned long node, const unsigned char *ftrs,
>
>
>
> cheers
>


--------------C533E014D749A6D5A9FFF5D7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Michael,<br>
      <br>
      When I received your email with your solution, I had already
      compiled the kernel 4.1.28 with the following temporary solution:<br>
      <br>
      Not suitable for 4.1-stable (no PPC_FEATURE2_HTM_NOSC_COMP).<br>
      <br>
      -     * If the kernel doesn't support TM (ie
      CONFIG_PPC_TRANSACTIONAL_MEM=n),<br>
      -     * we don't want to turn on TM here, so we use the *_COMP
      versions<br>
      -     * which are 0 if the kernel doesn't support TM.<br>
      +     * If the kernel doesn't support TM (ie.
      CONFIG_PPC_TRANSACTIONAL_MEM=n),<br>
      +     * we don't want to turn on CPU_FTR_TM here, so we use
      CPU_FTR_TM_COMP<br>
      +     * which is 0 if the kernel doesn't support TM.<br>
            */<br>
      -    {CPU_FTR_TM_COMP, 0, 0,<br>
      -     PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},<br>
      +    {CPU_FTR_TM_COMP, 0, 0, 0,        22, 0, 0},<br>
       };<br>
      <br>
      The kernel boots and KVM PR works. I tested it with
      Mac-on-Linux/KVM PR and Mac OS X Tiger as guest system. I will try
      your solution too.<br>
      <br>
      Many thanks for your fast response!<br>
      <br>
      Cheers,<br>
      <br>
      Christian<br>
      <br>
      <br>
      On 14 July 2016 at 1:10 PM, Michael Ellerman wrote:<br>
    </div>
    <blockquote cite="mid:87d1mga311.fsf@@concordia.ellerman.id.au"
      type="cite">
      <pre wrap="">Christian Zigotzky <a class="moz-txt-link-rfc2396E" href="mailto:chzigotzky@bayern-mail.de">&lt;chzigotzky@bayern-mail.de&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="">Hi All,

I tried to compile the kernel 4.1.28 today. Unfortunately it doesn't 
compile because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.

Error message:

   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CHK     include/generated/bounds.h
   CHK     include/generated/asm-offsets.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c:170:25: error: 'PPC_FEATURE2_HTM_NOSC_COMP' 
undeclared here (not in a function)
    PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
                          ^
make[1]: *** [arch/powerpc/kernel/prom.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

---

Commit:

f49eb503f0f9ab66874a81992b14249a1c59b6ad
Author: Anton Blanchard <a class="moz-txt-link-rfc2396E" href="mailto:anton@samba.org">&lt;anton@samba.org&gt;</a>
Date:   Fri Apr 15 12:08:19 2016 +1000

     powerpc: Update TM user feature bits in scan_features()

     [ Upstream commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017 ]

     We need to update the user TM feature bits (PPC_FEATURE2_HTM and
     PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
     bit.

     At the moment, if firmware reports TM is not available we turn off
     the kernel TM feature bit but leave the userspace ones on. Userspace
     thinks it can execute TM instructions and it dies trying.

     This (together with a QEMU patch) fixes PR KVM, which doesn't currently
     support TM.

     Signed-off-by: Anton Blanchard <a class="moz-txt-link-rfc2396E" href="mailto:anton@samba.org">&lt;anton@samba.org&gt;</a>
     Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
     Signed-off-by: Michael Ellerman <a class="moz-txt-link-rfc2396E" href="mailto:mpe@ellerman.id.au">&lt;mpe@ellerman.id.au&gt;</a>
     Signed-off-by: Sasha Levin <a class="moz-txt-link-rfc2396E" href="mailto:sasha.levin@oracle.com">&lt;sasha.levin@oracle.com&gt;</a>

---

PPC_FEATURE2_HTM_NOSC_COMP isn't defined or doesn't exist in the 
following files:
</pre>
      </blockquote>
      <pre wrap="">Thanks.

</pre>
      <blockquote type="cite">
        <pre wrap="">arch/powerpc/include/asm/cputable.h
arch/powerpc/kernel/cputable.c
arch/powerpc/include/uapi/asm/tm.h

That means the following patches aren't included in the 4.1.28 source code:
</pre>
      </blockquote>
      <pre wrap="">Sorry that's the wrong fix.

PPC_FEATURE2_HTM_NOSC indicates the presence of a certain kernel
behaviour, which has *not* been backported to 4.1.

The right fix is just to remove the reference to PPC_FEATURE2_HTM_NOSC
in 4.1.28.

eg:

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 28dbbb0d12c4..9b19d96e9562 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -166,8 +166,7 @@ static struct ibm_pa_feature {
 	 * we don't want to turn on TM here, so we use the *_COMP versions
 	 * which are 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0,
-	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
+	{CPU_FTR_TM_COMP, 0, 0, PPC_FEATURE2_HTM_COMP, 22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,



cheers

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------C533E014D749A6D5A9FFF5D7--

Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79F991A0C81
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 05:05:44 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D438D14017F
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 05:05:43 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 04:05:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B13D93578023
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 05:05:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0EI5ekB24313976
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 05:05:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0EI5drQ004711
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 05:05:39 +1100
Message-ID: <54B6AFE8.4000104@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 23:35:28 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/nvram: move generic code for nvram and
 pstore
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
 <20141224115825.25731.65673.stgit@localhost.localdomain>
 <1421209860.10748.10.camel@ellerman.id.au>
In-Reply-To: <1421209860.10748.10.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------060303090805040909010309"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060303090805040909010309
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/14/2015 10:01 AM, Michael Ellerman wrote:
> On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
>> With minor checks, we can move most of the code for nvram
>> under pseries to a common place to be re-used by other
>> powerpc platforms like powernv. This patch moves such
>> common code to arch/powerpc/kernel/nvram_64.c file.
> As I said in my reply to the previous version:
>
>      ... you need to keep in mind that it is very common for us to build kernels
>      with both POWERNV=y and PSERIES=y.
>      
>      So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
>      that are optional on pseries. Not things that we *shouldn't* be doing on
>      powernv.

we could as well do away with the PPC_PSERIES flag in a couple of places in
arch/powerpc/kernel/nvram_64.c, but doing that will unnecessarily add
few extra variables for !PPC_PSERIES case.

> Please explain in your commit message how you have dealt with that.
>

Sure. Will update the changelog

> Also, you broke the build for every config that doesn't have
> CONFIG_PPC_PSERIES, all 95 of them. This is pasemi_defconfig for example:

My bad!clobbering_unread_rtas_event should have been static inline
while defining under !PPC_PSERIES

Thanks
Hari

>        LD      arch/powerpc/mm/built-in.o
>      arch/powerpc/mm/init_64.o: In function `clobbering_unread_rtas_event':
>      init_64.c:(.opd+0x48): multiple definition of `clobbering_unread_rtas_event'
>      arch/powerpc/mm/mem.o:mem.c:(.opd+0x90): first defined here
>      arch/powerpc/mm/init_64.o: In function `.clobbering_unread_rtas_event':
>      init_64.c:(.text+0x80): multiple definition of `.clobbering_unread_rtas_event'
>      arch/powerpc/mm/mem.o:mem.c:(.text+0x2c0): first defined here
>        CC      arch/powerpc/kernel/udbg.o
>      /home/kisskb/slave/src/scripts/Makefile.build:336: recipe for target 'arch/powerpc/mm/built-in.o' failed
>      make[2]: *** [arch/powerpc/mm/built-in.o] Error 1
>      /home/kisskb/slave/src/Makefile:938: recipe for target 'arch/powerpc/mm' failed
>      make[1]: *** [arch/powerpc/mm] Error 2
>      make[1]: *** Waiting for unfinished jobs....
>
>
> cheers
>
>


--------------060303090805040909010309
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 01/14/2015 10:01 AM, Michael
      Ellerman wrote:<br>
    </div>
    <blockquote cite="mid:1421209860.10748.10.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">With minor checks, we can move most of the code for nvram
under pseries to a common place to be re-used by other
powerpc platforms like powernv. This patch moves such
common code to arch/powerpc/kernel/nvram_64.c file.
</pre>
      </blockquote>
      <pre wrap="">As I said in my reply to the previous version:

    ... you need to keep in mind that it is very common for us to build kernels
    with both POWERNV=y and PSERIES=y.
    
    So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
    that are optional on pseries. Not things that we *shouldn't* be doing on
    powernv.
</pre>
    </blockquote>
    <br>
    we could as well do away with the PPC_PSERIES flag in a couple of
    places in<br>
    arch/powerpc/kernel/nvram_64.c, but doing that will unnecessarily
    add<br>
    few extra variables for !PPC_PSERIES case. <br>
    <br>
    <blockquote cite="mid:1421209860.10748.10.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">
Please explain in your commit message how you have dealt with that.

</pre>
    </blockquote>
    <br>
    Sure. Will update the changelog<br>
    <br>
    <blockquote cite="mid:1421209860.10748.10.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">
Also, you broke the build for every config that doesn't have
CONFIG_PPC_PSERIES, all 95 of them. This is pasemi_defconfig for example:
</pre>
    </blockquote>
    <br>
    My bad!<font face="sans-serif"> clobbering_unread_rtas_event should
      have been static inline</font><br>
    while defining under !PPC_PSERIES<br>
    <br>
    Thanks<br>
    Hari<br>
    <br>
    <blockquote cite="mid:1421209860.10748.10.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">      LD      arch/powerpc/mm/built-in.o
    arch/powerpc/mm/init_64.o: In function `clobbering_unread_rtas_event':
    init_64.c:(.opd+0x48): multiple definition of `clobbering_unread_rtas_event'
    arch/powerpc/mm/mem.o:mem.c:(.opd+0x90): first defined here
    arch/powerpc/mm/init_64.o: In function `.clobbering_unread_rtas_event':
    init_64.c:(.text+0x80): multiple definition of `.clobbering_unread_rtas_event'
    arch/powerpc/mm/mem.o:mem.c:(.text+0x2c0): first defined here
      CC      arch/powerpc/kernel/udbg.o
    /home/kisskb/slave/src/scripts/Makefile.build:336: recipe for target 'arch/powerpc/mm/built-in.o' failed
    make[2]: *** [arch/powerpc/mm/built-in.o] Error 1
    /home/kisskb/slave/src/Makefile:938: recipe for target 'arch/powerpc/mm' failed
    make[1]: *** [arch/powerpc/mm] Error 2
    make[1]: *** Waiting for unfinished jobs....


cheers


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060303090805040909010309--

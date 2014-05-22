Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AD9B1A0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:22:47 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 22 May 2014 18:22:44 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 162C56E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:22:33 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4MMMeFI9896400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 22:22:40 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4MMMdbC009446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:22:40 -0400
Message-ID: <537E78AD.1040409@linux.vnet.ibm.com>
Date: Thu, 22 May 2014 15:22:37 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH v4 09/11] powerpc/perf: add support for the hv 24x7
 interface
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
 <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
 <1400744950-sup-4804@delenn.ozlabs.ibm.com>
In-Reply-To: <1400744950-sup-4804@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 scottwood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2014 01:19 AM, Ian Munsie wrote:
> Hi Cody,
>
> I just tried building this with gcc 4.5, which failed with the following
> warning (treated as an error):
>
> cc1: warnings being treated as errors
> arch/powerpc/perf/hv-24x7.c: In function 'single_24x7_request':
> arch/powerpc/perf/hv-24x7.c:346:1: error: the frame size of 8192 bytes is larger than 2048 bytes
> make[3]: *** [arch/powerpc/perf/hv-24x7.o] Error 1
> make[2]: *** [arch/powerpc/perf] Error 2
>
> My .config has CONFIG_FRAME_WARN=2048 (default on 64bit), but the
> alignment constraints in this function may require 8K on the stack -
> possibly a bit large?
>

Yep, it is a bit large. In other places in hv-24x7 that use similar 
firmware interfaces (with similar alignment requirements), I've used a 
kmem_cache (hv_page_cache). Testing out a patch that uses that here as well.

>
> Notably for some reason this warning no longer seems to trigger on gcc
> 4.8 (or at least somewhere between 4.5-4.8), though the assembly does
> still show it aligning the buffers.

That's a bit concerning (and might be why I didn't pick it up, using gcc 
4.9.0 over here). Looking at the gcc docs, it seems to indicate that 
alloca() and VLAs aren't counted for -Wframe-larger-than. Perhaps gcc 
decided to move locally defined structures with alignment requirements 
into that same bucket? (while size of the structures is statically 
determinable, the stack consumption due to alignment is [to some degree] 
variable).

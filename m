Return-Path: <bergner@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE9C01A055C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:15:37 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Fri, 2 Oct 2015 14:15:36 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 32E131FF004B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:03:45 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92KFWrg7799188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:15:32 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92KFWBt029105
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:15:32 -0600
Subject: Re: Missing operand for tlbie instruction on Power7
From: Peter Bergner <bergner@vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Oct 2015 15:15:30 -0500
Message-ID: <1443816930.13186.214.camel@otta>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 22:03 +0300, Denis Kirjanov wrote:
> arch/powerpc/kernel/swsusp_asm64.S: Assembler messages:
>> arch/powerpc/kernel/swsusp_asm64.S:188: Error: missing operand
>> scripts/Makefile.build:294: recipe for target
>> 'arch/powerpc/kernel/swsusp_asm64.o' failed
>> make[1]: *** [arch/powerpc/kernel/swsusp_asm64.o] Error 1
>> Makefile:941: recipe for target 'arch/powerpc/kernel' failed
>> make: *** [arch/powerpc/kernel] Error 2
[snip]
>> I don't know enough ppc assembly to properly fix this but I can test.
> 
> Could you please test the patch attached?
[snip]
> -0:     tlbie   r4;                             \
> +0:     tlbie   r4, 0;                          \

This isn't correct.  With POWER7 and later (which this compile
is, since it's on LE), the tlbie instruction takes two register
operands:

    tlbie RB, RS

The tlbie instruction on pre POWER7 cpus had one required register
operand (RB) and an optional second L operand, where if you omitted
it, it was the same as using "0":

    tlbie RB, L

This is a POWER7 and later build, so your change which adds the "0"
above is really adding r0 for RS.  The new tlbie instruction doesn't
treat r0 specially, so you'll be using whatever random bits which
happen to be in r0 which I don't think that is what you want.


Peter

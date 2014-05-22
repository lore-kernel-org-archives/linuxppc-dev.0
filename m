Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74B181A070B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:26:56 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 22 May 2014 18:26:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6218F2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:26:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4M8QZGP4784428
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:26:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4M8JUrt032073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:19:31 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 09/11] powerpc/perf: add support for the hv 24x7
 interface
In-reply-to: <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
 <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
Date: Thu, 22 May 2014 18:19:29 +1000
Message-Id: <1400744950-sup-4804@delenn.ozlabs.ibm.com>
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

Hi Cody,

I just tried building this with gcc 4.5, which failed with the following
warning (treated as an error):

cc1: warnings being treated as errors
arch/powerpc/perf/hv-24x7.c: In function 'single_24x7_request':
arch/powerpc/perf/hv-24x7.c:346:1: error: the frame size of 8192 bytes is larger than 2048 bytes
make[3]: *** [arch/powerpc/perf/hv-24x7.o] Error 1
make[2]: *** [arch/powerpc/perf] Error 2

My .config has CONFIG_FRAME_WARN=2048 (default on 64bit), but the
alignment constraints in this function may require 8K on the stack -
possibly a bit large?


Notably for some reason this warning no longer seems to trigger on gcc
4.8 (or at least somewhere between 4.5-4.8), though the assembly does
still show it aligning the buffers.


Excerpts from Cody P Schafer's message of 2014-03-06 11:01:08 +1100:
> +static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
<snip>
> +    /*
> +     * request_buffer and result_buffer are not required to be 4k aligned,
> +     * but are not allowed to cross any 4k boundary. Aligning them to 4k is
> +     * the simplest way to ensure that.
> +     */
> +    struct reqb {
> +        struct hv_24x7_request_buffer buf;
> +        struct hv_24x7_request req;
> +    } __packed __aligned(4096) request_buffer = {
<snip>
> +    struct resb {
> +        struct hv_24x7_data_result_buffer buf;
> +        struct hv_24x7_result res;
> +        struct hv_24x7_result_element elem;
> +        __be64 result;
> +    } __packed __aligned(4096) result_buffer = {};
<snip>


Cheers,
-Ian

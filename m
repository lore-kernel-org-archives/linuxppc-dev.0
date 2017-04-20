Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w88GW22QVzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 05:35:15 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id x86so19906462ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 12:35:15 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com> <58F83C66.7030806@gmail.com>
 <64505d40-926d-b302-4ff3-dff71aa5018a@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, rostedt@goodmis.org,
 mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F90D56.9070602@gmail.com>
Date: Thu, 20 Apr 2017 12:34:46 -0700
MIME-Version: 1.0
In-Reply-To: <64505d40-926d-b302-4ff3-dff71aa5018a@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/17 09:51, Tyrel Datwyler wrote:
> On 04/19/2017 09:43 PM, Frank Rowand wrote:
> 

< snip >


>> The call stack could easily be post-processed, for example using addr2line.
>> Here is the call stack for when the refcount incremented to 23 from 22 (or
>> more accurately, to 22 from 21):
>>
>> 0xc0d00e3c Line 857 of "init/main.c"
>> 0xc03017d0 Line 792 of "init/main.c"
>> 0xc0d3a234 Line 528 of "drivers/of/platform.c"
>> 0xc0810684 Line 503 of "drivers/of/platform.c"
>> 0xc081061c Line 267 of "include/linux/of.h"
>> 0xc080d928 Line 815 of "drivers/of/base.c"
>>
>> Which ends up being this code:
>>
>>    of_platform_default_populate_init()
>>       of_platform_default_populate()
>>          of_platform_populate()
>>             [[ of_find_node_by_path("/") ]]
>>                [[ of_find_node_opts_by_path(path, NULL) ]]
>>                   of_node_get(of_root)
>>
>> Note that some functions can be left out of the ARM call stack, with
>> a return going back more than one level.  The functions in the call
>> list above that are enclosed in '[[' and ']]' were found by source
>> inspection in those cases.
> 
> The same thing is encountered in ppc64 stack traces. I assume it is
> generally inlining of small functions, but I've never actually verified
> that theory. Probably should take the time to investigate, or just ask
> someone.

Yes, inlining small functions is one reason for this.

Another case I often find is that when function A calls function B calls
function C.  If the final statement of function B is 'return C()' then
there is no need for function C to return through function B, it can
instead return directly to function A.  (That is more a conceptual
hand-waving of the idea, not the actual way the compiler implements
it.  Take this with a grain of salt, I'm not a compiler guy.)

< snip >

Message-ID: <40F8138F.8090004@pi.be>
Date: Fri, 16 Jul 2004 19:42:39 +0200
From: Stef Simoens <stef.simoens@pi.be>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] align.c
References: <40F57D15.8030700@pi.be> <69A5B0EA-D669-11D8-A9B5-000393DBC2E8@freescale.com>
In-Reply-To: <69A5B0EA-D669-11D8-A9B5-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kumar Gala wrote:
> Do you really see string ops and alignment exceptions?  I was under the
> impression they did byte accesses.

Yes, but i've only seen alignment exceptions with stswi/lswi
instructions though.

(On the MPC601, stswi/lswi has better timings than a series of stw/lwz;
that's why I'm probably the only one seeing them...)

While I was at it, Paulus asked me to handle stmw/lmw and stswx/lswx as
well...

Stef

> On Jul 14, 2004, at 1:36 PM, Stef Simoens wrote:
>
>> This is an (updated) diff to arch/ppc/kernel/align.c of the 2.6.8-rc1
>> kernel.
>> The patch adds support for the handling of alignment exceptions of
>> multiple (lmw/stmw) and string (lswi/lswx/stswi/stswx) instructions.
>> Stef
>>
>> diff -ur linux-2.6.8-rc1/arch/ppc/kernel/align.c
>> linux-2.6.8-rc1-mq/arch/ppc/kernel/align.c
>> --- linux-2.6.8-rc1/arch/ppc/kernel/align.c    2004-07-12
>> 17:46:42.525695737 +0200
>> +++ linux-2.6.8-rc1-mq/arch/ppc/kernel/align.c    2004-07-12
>> 20:25:24.390989048 +0200
(snip)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

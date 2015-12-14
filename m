Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FBA61A116D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:05:52 +1100 (AEDT)
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com
 [IPv6:2607:f8b0:400d:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5561B140556
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 21:05:50 +1100 (AEDT)
Received: by qkfb125 with SMTP id b125so126854898qkf.2
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 02:05:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1450087241.9595.0.camel@ellerman.id.au>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <1448389419-5296-2-git-send-email-kda@linux-powerpc.org>
 <20151207155224.2a8d71dd@gandalf.local.home>
 <1449522135.21036.11.camel@kernel.crashing.org>
 <20151207163343.0ea2f1bb@gandalf.local.home>
 <1450087241.9595.0.camel@ellerman.id.au>
Date: Mon, 14 Dec 2015 13:05:48 +0300
Message-ID: <CAOJe8K3nx8MTu77XyBAyUZNOLrEKzph00SsL47yYyJTx5wbO9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: tracing: don't trace hcalls on offline CPUs
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-12-07 at 16:33 -0500, Steven Rostedt wrote:
>> On Tue, 08 Dec 2015 08:02:15 +1100
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> > On Mon, 2015-12-07 at 15:52 -0500, Steven Rostedt wrote:
>> > > > +     TP_CONDITION(cpu_online(smp_processor_id())),
>> > > > +
>> >
>> > This should probably be some kind of __raw version though, hcalls can
>> > be called in contexts where the debug stuff in smp_processor_id() isn't
>> > safe (or preempt enabled).
>> >
>>
>> OK, then that needs to be updated.
>
> Denis, please respin with raw_smp_processor_id().

Sure, I'll respin today.

Thanks!

>
> cheers
>
>

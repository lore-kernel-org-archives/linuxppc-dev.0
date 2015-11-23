Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 931531A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:31:07 +1100 (AEDT)
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com
 [IPv6:2607:f8b0:4002:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07A5F1402B2
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 20:31:07 +1100 (AEDT)
Received: by ykfs79 with SMTP id s79so231976288ykf.1
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 01:31:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448235359.18775.1.camel@ellerman.id.au>
References: <1446145810-5383-1-git-send-email-kda@linux-powerpc.org>
 <1446545202.2801.2.camel@ellerman.id.au>
 <CAOJe8K0=J033NMh++iznar21_p4G4epAgE0wONoxZxEyFPS9VQ@mail.gmail.com>
 <CAOJe8K1q=bO5iKfnG=9ZLNvk0sREcfqNJuHNhyspe6MG4hSfHA@mail.gmail.com>
 <1448235359.18775.1.camel@ellerman.id.au>
Date: Mon, 23 Nov 2015 12:31:05 +0300
Message-ID: <CAOJe8K2nDEU9B9wwFDqK0Rv5s15MV09En-OrrJh=qWmcpbyDmw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: tracing: don't trace hcalls on offline CPUs
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2015-11-20 at 15:22 +0300, Denis Kirjanov wrote:
>> On 11/3/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
>> > On 11/3/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > > On Thu, 2015-10-29 at 22:10 +0300, Denis Kirjanov wrote:
>> > > > ./drmgr -c cpu -a -r gives the following warning:
>> > > >
>> > > > [ 2327.035563] RCU used illegally from offline CPU!
>> > > >
>> > > > Make the hypervisor tracepoints conditional by introducing
>> > > > TRACE_EVENT_FN_COND similar to TRACE_EVENT_FN
>> > >
>> > > We've fixed other cases like this with RCU_NONIDLE(), but I assume
>> > > that
>> > > doesn't work here because we're actually offline?
>> >
>> > Yes, in this case we're moving the complete core offline through
>> > dlpar...
>> >
>>
>> Hi Michael,
>> Could you pick this patch?
>
> It's mostly a tracing patch, so I'd need an ACK from Steve at least.
>
> It would probably be best if you split it into a "tracing: .. " patch which
> adds the new macros and then a powerpc patch which uses them.

Ok, sounds reasonable.

Thanks!
>
> cheers
>
>

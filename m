Return-Path: <dev@codyps.com>
Received: from mail-lb0-x235.google.com (mail-lb0-x235.google.com
 [IPv6:2a00:1450:4010:c04::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CA5A1A0C46
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 10:05:32 +1100 (AEDT)
Received: by mail-lb0-f181.google.com with SMTP id l4so1359882lbv.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Dec 2014 15:05:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141204124422.GA4195@krava.brq.redhat.com>
References: <1417572578-9051-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1417572578-9051-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141204124422.GA4195@krava.brq.redhat.com>
Date: Fri, 5 Dec 2014 18:05:26 -0500
Message-ID: <CAPoQQ-1m9oRQ7wLfRHFNNZyw7fvCoMa_DX7msP2QsY_i2QyHug@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] tools/perf: support parsing parameterized events
From: Cody P Schafer <dev@codyps.com>
To: Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 4, 2014 at 7:44 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> On Tue, Dec 02, 2014 at 06:09:35PM -0800, Sukadev Bhattiprolu wrote:
>> From: Cody P Schafer <cody@linux.vnet.ibm.com>
>>
>> Enable event specification like:
>>
>>       pmu/event_name,param1=0x1,param2=0x4/
>>
>> Assuming that
>>
>>       /sys/bus/event_source/devices/pmu/events/event_name
>>
>> Contains something like
>>
>>       param2=$foo,bar=1,param1=$baz
>
> oops.. sorry to be PITA on this one.. I might have missed something
> in the previous discussion but I guess I might have finally some
> opinion on this ;-)
>
> here's how I think your patchset works:
>
> in /sys/bus/event_source/devices/pmu/events/event_name you can actually have:
>
>    param2=foo,bar=1,param1=baz
>
> notice no '$', thats what you add later in 'perf list' output, right?
>
> Moreover it actually does not matter whats in value 'param2=HERE',
> because it's not used in the config code at all apart from the
> 'perf list' display processing.
>
> So when we discussed the '$' name way, I thought it'd be like:
>
> in /sys/bus/event_source/devices/pmu/events/event_name you have:
>   param2=$foo,bar=1,param1=$baz
>
> and on command line you'd use:
>   pmu/event_name,foo=0x1,bar=0x4/
>
> to assign directly to the $var, which would justify the $var
> syntax I think..
>

Agreed, what you've described above sounds like a good idea.

Compared to monopolizing all strings (which is what I did when
initialy writing this), using a '$' prefix would allow less pain when
some events suddenly need non-integer parameters.

> anyway we could assign directly to the param term name as you do,
> but I think we just need to mark the term as parametrized, like:
>
> in /sys/bus/event_source/devices/pmu/events/event_name you have:
>   param2=?,bar=1,param1=?
>
> and on command line you'd use:
>   pmu/event_name,param2=0x1,param1=0x4/
>
> while the config code would check that the param substitution is
> done only for terms with '?' in value, like 'param2=?' and not
> for all PARSE_EVENTS__TERM_TYPE_STR type terms (as of now)

I prefer the `foo=0x1` as mentioned previously: it makes the user
interface much less painful as we can have event-specific names for
register/hcall fields.

I'm pretty sure the code used to do this, not sure when it was removed
(haven't been following this patchset closely).

That said: I haven't fiddled with this code in a while (it's Suka's at
this point), and there might be arguments the other way on both of
those.

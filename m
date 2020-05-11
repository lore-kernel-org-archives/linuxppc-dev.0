Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C920C47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 17:12:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B034920714
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 17:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tbeMsNET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B034920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LSCh2Y0lzDr5V
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 03:12:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::d42;
 helo=mail-io1-xd42.google.com; envelope-from=jwadams@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=tbeMsNET; dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LS1D118fzDqtN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2020 03:02:55 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id e9so10571840iok.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v9CvyozKz45tnTJQ44+n4GCpZIz1GaPx/h3VjVloSMY=;
 b=tbeMsNETXaEX3eJAcNRFx55zA4c6oWWywXJTG0m9Laj8pgKvsqI7TxoQJ64X4vE4z1
 KA3IuRAIIjUJrjr3WjqA24MmwomMG4cu4cWAni3plBKjfwhrJxPfbLuO9m1FjoAf6c2V
 tNwkuMMNnJOXVORPh8uuO8jvnKUOsmiy8jjjP4G8ZvPYf3udSJVnLdWmuCJoz2u0yxMi
 +oIituEo72EEqvu9+Pa+GXdkvq/PgDg2nH8Gt73tTw2l/vZacrGPtfkJoLRPxzDERdkD
 BYVqxGGvUD8JSOma+Kr/PXclcfjnUHDrFgS/59PETBSkayfVQEvNfaTrCfIDG18RKAec
 dwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v9CvyozKz45tnTJQ44+n4GCpZIz1GaPx/h3VjVloSMY=;
 b=QPi3NhgHfQ1WQTp5LVzs305P1TRUB638mrgShM8QN6vUdvGzEgemmPXn8TwgALWIu5
 hCus2e42leVsvMYZu6kVM9N+E9yfX1fBA8mXWzM5f2GoYwIziAL7SD4TN/5gyYJnb3tV
 c1TmVlTntGDtXOmmw6d9REBTsdZcS1DxzqQi8Djjd57SZmKOSOW4RHKuMiPYwEiuTp9X
 p0NxYES0xmJIdAKwhFyVSqkCjQoSiMJ3KiqucLnr+M9npSN0QxgyFfTFkxmLDscR6NG1
 5nEhVTSa0pqUhF02Po7BLVahz5PB1k6893ZfpbWa30I6ak5EeQb1whZjeBIhnEn9EE6Q
 xLGQ==
X-Gm-Message-State: AGi0Pub7RvJBr+zJUFBkesWNTh/m2leF9b13DCxSxB0wqD8SUp20qRAS
 8xQTBRVa+o3n96hr/mXJee6FdCv3mkVkY1osA5Lt
X-Google-Smtp-Source: APiQypIzyhjcdRL5OT7UxMCqUNX1Cf2+MX0zMCcjnimWF5EBRCR6JtPmcD8rSAVKspTwViI94ganHU9wtPVKGKmx8k0=
X-Received: by 2002:a6b:dd06:: with SMTP id f6mr12960070ioc.90.1589216571449; 
 Mon, 11 May 2020 10:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
In-Reply-To: <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
From: Jonathan Adams <jwadams@google.com>
Date: Mon, 11 May 2020 10:02:14 -0700
Message-ID: <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 linux-s390@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 linux-mips@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Jim Mattson <jmattson@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 8, 2020 at 2:44 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> [Answering for Emanuele because he's not available until Monday]
>
> On 07/05/20 19:45, Jonathan Adams wrote:
> > This is good work.  As David Rientjes mentioned, I'm currently investigating
> > a similar project, based on a google-internal debugfs-based FS we call
> > "metricfs".  It's
> > designed in a slightly different fashion than statsfs here is, and the
> > statistics exported are
> > mostly fed into our OpenTelemetry-like system.  We're motivated by
> > wanting an upstreamed solution, so that we can upstream the metrics we
> > create that are of general interest, and lower the overall rebasing
> > burden for our tree.
>
> Cool.  We included a public reading API exactly so that there could be
> other "frontends".  I was mostly thinking of BPF as an in-tree user, but
> your metricfs could definitely use the reading API.
>
> >  - the 8/16/32/64 signed/unsigned integers seems like a wart, and the
> > built-in support to grab any offset from a structure doesn't seem like
> > much of an advantage. A simpler interface would be to just support an> "integer" (possibly signed/unsigned) type, which is always 64-bit, and
> > allow the caller to provide a function pointer to retrieve the value,
> > with one or two void *s cbargs.  Then the framework could provide an
> > offset-based callback (or callbacks) similar to the existing
> > functionality, and a similar one for per-CPU based statistics.  A
> > second "clear" callback could be optionally provided to allow for
> > statistics to be cleared, as in your current proposal.
>
> Ok, so basically splitting get_simple_value into many separate
> callbacks.  The callbacks would be in a struct like
>
> struct stats_fs_type {
>         uint64_t (*get)(struct stats_fs_value *, void *);
>         void (*clear)(struct stats_fs_value *, void *);
>         bool signed;
> }
...
> struct stats_fs_type stats_fs_type_u8 = {
>         stats_fs_get_u8,
>         stats_fs_clear_u8,
>         false
> };
>
> and custom types can be defined using "&(struct stats_fs_type) {...}".

That makes sense.

> >  - Beyond the statistic's type, one *very* useful piece of metadata
> > for telemetry tools is knowing whether a given statistic is
> > "cumulative" (an unsigned counter which is only ever increased), as
> > opposed to a floating value (like "amount of memory used").
>
> Good idea.  Also, clearing does not make sense for a floating value, so
> we can use cumulative/floating to get a default for the mode: KVM
> statistics for example are mostly cumulative and mode 644, except a few
> that are floating and those are all mode 444.  Therefore it makes sense
> to add cumulative/floating even before outputting it as metadata.
>
> > I'm more
> > concerned with getting the statistics model and capabilities right
> > from the beginning, because those are harder to adjust later.
>
> Agreed.
>
> > 1. Each metricfs metric can have one or two string or integer "keys".
> > If these exist, they expand the metric from a single value into a
> > multi-dimensional table. For example, we use this to report a hash
> > table we keep of functions calling "WARN()", in a 'warnings'
> > statistic:
> >
> > % cat .../warnings/values
> > x86_pmu_stop 1
> > %
> >
> > Indicates that the x86_pmu_stop() function has had a WARN() fire once
> > since the system was booted.  If multiple functions have fired
> > WARN()s, they are listed in this table with their own counts. [1]  We
> > also use these to report per-CPU counters on a CPU-by-CPU basis:
> >
> > % cat .../irq_x86/NMI/values
> > 0 42
> > 1 18
> > ... one line per cpu
> > % cat .../rx_bytes/values
> > lo 501360681
> > eth0 1457631256
>
> These seem like two different things.

I see your point; I agree that there are two different things here.

> The percpu and per-interface values are best represented as subordinate
> sources, one per CPU and one per interface.  For interfaces I would just
> use a separate directory, but it doesn't really make sense for CPUs.  So
> if we can cater for it in the model, it's better.  For example:
>
> - add a new argument to statsfs_create_source and statsfs_create_values
> that makes it not create directories and files respectively.
>
> - add a new "aggregate function" STATS_FS_LIST that directs the parent
> to build a table of all the simple values below it
>
> We can also add a helper statsfs_add_values_percpu that creates a new
> source for each CPU, I think.

I think I'd characterize this slightly differently; we have a set of
statistics which are essentially "in parallel":

  - a variety of statistics, N CPUs they're available for, or
  - a variety of statistics, N interfaces they're available for.
  - a variety of statistics, N kvm object they're available for.

Recreating a parallel hierarchy of statistics any time we add/subtract
a CPU or interface seems like a lot of overhead.  Perhaps a better
model would
be some sort of "parameter enumn" (naming is hard; parameter set?), so
when a CPU/network interface/etc is added you'd add its ID to the
"CPUs" we know about, and at removal time you'd take it out; it would
have an associated cbarg for the value getting callback.

Does that make sense as a design?

I'm working on characterizing all of our metricfs usage; I'll see if
this looks like it mostly covers our usecases.

> The warnings one instead is a real hash table.  It should be possible to
> implement it as some kind of customized aggregation, that is implemented
> in the client instead of coming from subordinate sources.  The
> presentation can then just use STATS_FS_LIST.  I don't see anything in
> the design that is a blocker.

Yes; though if it's low-enough overhead, you could imagine having a
dynamically-updated parameter enum based on the hash table.

> > 2.  We also export some metadata about each statistic.  For example,
> > the metadata for the NMI counter above looks like:
> >
> > % cat .../NMI/annotations
> > DESCRIPTION Non-maskable\ interrupts
> > CUMULATIVE
> > % cat .../NMI/fields
> > cpu value
> > int int
> > %
>
> Good idea.  I would prefer per-directory dot-named files for this.  For
> example a hypothetical statsfs version of /proc/interrupts could be like
> this:
>
> $ cat /sys/kernel/stats/interrupts/.schema
> 0                                          // Name
> CUMULATIVE                                 // Flags
> int:int                                    // Type(s)
> IR-IO-APIC    2-edge      timer            // Description
> ...
> LOC
> CUMULATIVE
> int:int
> Local timer interrupts
> ...
> $ cat /sys/kernel/stats/interrupts/LOC
> 0 4286815
> 1 4151572
> 2 4199361
> 3 4229248
>
> > 3. We have a (very few) statistics where the value itself is a string,
> > usually for device statuses.
>
> Maybe in addition to CUMULATIVE and FLOATING we can have ENUM
> properties, and a table to convert those enums to strings.  Aggregation
> could also be used to make a histogram out of enums in subordinate
> sources, e.g.
>
> $ cat /sys/kernel/stats/kvm/637-1/vcpu_state
> running 12
> uninitialized 0
> halted 4

That's along similar lines to the parameter enums, yeah.

> So in general I'd say the sources/values model holds up.  We certainly
> want to:
>
> - switch immediately to callbacks instead of the type constants (so that
> core statsfs code only does signed/unsigned)
>
> - add a field to distinguish cumulative and floating properties (and use
> it to determine the default file mode)

Yup, these make sense.

> - add a new argument to statsfs_create_source and statsfs_create_values
> that makes it not create directories and files respectively
>
> - add a new API to look for a statsfs_value recursively in all the
> subordinate sources, and pass the source/value pair to a callback
> function; and reimplement recursive aggregation and clear in terms of
> this function.

This is where I think a little iteration on the "parameter enums"
should happen before jumping into implementation.

> > For our use cases, we generally don't both output a statistic and it's
> > aggregation from the kernel; either we sum up things in the kernel
> > (e.g. over a bunch of per-cpu or per-memcg counters) and only have the
> > result statistic, or we expect user-space to sum up the data if it's
> > interested.  The tabular form makes it pretty easy to do so (i.e. you
> > can use awk(1) to sum all of the per-cpu NMI counters).
>
> Yep, the above "not create a dentry" flag would handle the case where
> you sum things up in the kernel because the more fine grained counters
> would be overwhelming.

nodnod; or the callback could handle the sum itself.

Thanks,
- jonathan

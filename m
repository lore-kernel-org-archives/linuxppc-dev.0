Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12394C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 04:50:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B6920811
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 04:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B6920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F4B91hG1zDr2s
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 15:50:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F4830TgCzDqsD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 15:48:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43F4812KnBz9s0n;
 Wed, 12 Dec 2018 15:48:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
 <87bm5sxqya.fsf@concordia.ellerman.id.au>
 <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
Date: Wed, 12 Dec 2018 15:48:32 +1100
Message-ID: <87sgz3wdsv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Mark Rutland <mark.rutland@arm.com>, Christoffer.Dall@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org,
 "paulus@samba.org" <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Murray <andrew.murray@arm.com> writes:
> On Tue, Dec 11, 2018 at 10:06:53PM +1100, Michael Ellerman wrote:
>> [ Reviving old thread. ]
>>=20
>> Andrew Murray <andrew.murray@arm.com> writes:
>> > On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
>> >> Andrew Murray <andrew.murray@arm.com> writes:
>> >>=20
>> >> > Update design.txt to reflect the presence of the exclude_host
>> >> > and exclude_guest perf flags.
>> >> >
>> >> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> >> > ---
>> >> >  tools/perf/design.txt | 4 ++++
>> >> >  1 file changed, 4 insertions(+)
>> >> >
>> >> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
>> >> > index a28dca2..7de7d83 100644
>> >> > --- a/tools/perf/design.txt
>> >> > +++ b/tools/perf/design.txt
>> >> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'excl=
ude_hv' bits provide a
>> >> >  way to request that counting of events be restricted to times when=
 the
>> >> >  CPU is in user, kernel and/or hypervisor mode.
>> >> >=20=20
>> >> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a =
way
>> >> > +to request counting of events restricted to guest and host context=
s when
>> >> > +using virtualisation.
>> >>=20
>> >> How does exclude_host differ from exclude_hv ?
>> >
>> > I believe exclude_host / exclude_guest are intented to distinguish
>> > between host and guest in the hosted hypervisor context (KVM).
>>=20
>> OK yeah, from the perf-list man page:
>>=20
>>            u - user-space counting
>>            k - kernel counting
>>            h - hypervisor counting
>>            I - non idle counting
>>            G - guest counting (in KVM guests)
>>            H - host counting (not in KVM guests)
>>=20
>> > Whereas exclude_hv allows to distinguish between guest and
>> > hypervisor in the bare-metal type hypervisors.
>>=20
>> Except that's exactly not how we use them on powerpc :)
>>=20
>> We use exclude_hv to exclude "the hypervisor", regardless of whether
>> it's KVM or PowerVM (which is a bare-metal hypervisor).
>>=20
>> We don't use exclude_host / exclude_guest at all, which I guess is a
>> bug, except I didn't know they existed until this thread.
>>=20
>> eg, in a KVM guest:
>>=20
>>   $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;don=
e"
>>   $ perf report -D | grep -Fc "dso: [hypervisor]"
>>   16
>>=20
>>=20
>> > In the case of arm64 - if VHE extensions are present then the host
>> > kernel will run at a higher privilege to the guest kernel, in which
>> > case there is no distinction between hypervisor and host so we ignore
>> > exclude_hv. But where VHE extensions are not present then the host
>> > kernel runs at the same privilege level as the guest and we use a
>> > higher privilege level to switch between them - in this case we can
>> > use exclude_hv to discount that hypervisor role of switching between
>> > guests.
>>=20
>> I couldn't find any arm64 perf code using exclude_host/guest at all?
>
> Correct - but this is in flight as I am currently adding support for this
> see [1].

OK, so at least that will be consistent across arm64 & x86.

>> And I don't see any x86 code using exclude_hv.
>
> I can't find any either.

I think that's because they don't need it, because they don't let guests
program the PMU directly. It's all handled by the host and the host
doesn't let the guest count host cycles anyway. But I could be wrong I'm
no x86 expert.

>> But maybe that's OK, I just worry this is confusing for users.
>
> There is some extra context regarding this where exclude_guest/exclude_ho=
st
> was added, see [2]

Good find. I had looked at that commit, but the thread on the list is
more informative.

In fact there was even a man page update! Never occurred to me look
there :P

http://man7.org/linux/man-pages/man2/perf_event_open.2.html

       exclude_host (since Linux 3.2)
              When conducting measurements that include processes running VM
              instances (i.e., have executed a KVM_RUN ioctl(2)), only mea=
=E2=80=90
              sure events happening inside a guest instance.  This is only
              meaningful outside the guests; this setting does not change
              counts gathered inside of a guest.  Currently, this function=
=E2=80=90
              ality is x86 only.

       exclude_guest (since Linux 3.2)
              When conducting measurements that include processes running VM
              instances (i.e., have executed a KVM_RUN ioctl(2)), do not
              measure events happening inside guest instances.  This is only
              meaningful outside the guests; this setting does not change
              counts gathered inside of a guest.  Currently, this function=
=E2=80=90
              ality is x86 only.


Which makes things much clearer.

Perhaps you want to add a reference to the man page in your text,
something like?

  Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
  to request counting of events restricted to guest and host contexts when
  using virtualisation. See the perf_event_open(2) man page for more
  detail.


cheers

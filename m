Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE8C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:58:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A558D2082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A558D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fnM551nlzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 23:58:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fnGw5fgCzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 23:54:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fnGw18grz9sDL; Wed, 16 Jan 2019 23:54:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43fnGv6B0wz9sDB;
 Wed, 16 Jan 2019 23:54:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/5] powerpc/syscalls: Remove unused offset parameter
In-Reply-To: <CAK8P3a2UA9n8VmdpRMp-2HakOk=w1UaRiPvmLhF7A4_4Z0sENw@mail.gmail.com>
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <CAK8P3a3PnbJ1Mr01HeRUzk+cfK4t-yok4YTJdNrBs6f==fVrnw@mail.gmail.com>
 <87y37lxx1s.fsf@concordia.ellerman.id.au>
 <CAK8P3a2UA9n8VmdpRMp-2HakOk=w1UaRiPvmLhF7A4_4Z0sENw@mail.gmail.com>
Date: Wed, 16 Jan 2019 23:54:43 +1100
Message-ID: <87o98gyd7w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Jan 16, 2019 at 1:31 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > On Mon, Jan 14, 2019 at 12:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >>
>> >> We never pass a value for offset, nor do we need to, so remove the
>> >> offset logic.
>> >>
>> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> >
>> > This change and the next three defeat the idea of having a shared script across
>> > all architectures.
>>
>> The scripts are < 100 lines total, so sharing them across arches is
>> really not much of a win. Especially if it requires compromising the
>> format of the table on some architectures. Shoe horning the SPU
>> visibility into the ABI field was a good hack but I really dislike it
>> being the permanent state of our syscall table.
>
> IMHO the main advantage is that sharing the scripts guarantees that
> the format remains compatible across all architectures, which in turn
> allows us to build additional tooling around these files, and make it
> less error-prone to do cross-architecture changes.

Yeah I guess. Equally those scripts could be made to cope with slight
differences across arches.

>> > Firoz has already posted patches to move the scripts to scripts/syscalltbl.sh
>>
>> Those don't work for x86 AFAICS?
>
> I hope we can address that in a follow-up step, integrating all of arm, s390 and
> x86, which had the scripts first.

My worry is that the generic script is going to end up being a big
mish-mash of what's needed by every arch, which makes it harder to
maintain and means we need to coordinate changes across all arches.


>> > and I think it's better to go on with those patches, as they
>> > also guarantee that the format of the files remains consistent across all
>> > architectures.
>>
>> Why is that a requirement?
>>
>> Another possibility is that we have a separate file that stores the SPU
>> visibility, that way our syscall.tbl would have the same format as other
>> arches, and we could probably share the scripts, but we'd need our own
>> script for generating the SPU table.
>>
>> I'll hack that up and see how it looks.
>
> Ok. See also what x86 has done, they also have some extensions to
> their copy of the script.

Yeah I have been looking at theirs. They added a "qualifier" to the
entry, eg. sys_foo/ptregs.

That really should have been an extra column, I'm not sure why they did
it that way, probably to avoid breaking scripts :)

I'd like to do something similar and add a fullregs attribute and use
that to generate stubs that save the full regs for the syscalls that
require it, the same as x86 did.

We could cater to things like that by having a generic "attributes"
column on every arch, and then allow arches to use it for whatever they
need. On powerpc we could use it for spu as well.

> I still think that keeping the information about the SPU in the same file
> is best, otherwise it becomes harder to maintain as changes to the
> main table are done, unless we decide that we don't want to leave
> the SPU syscalls as explicit opt-in for future additions.

I think we do want them opt-in, and I don't anticipate adding any to the
list in future unless someone explicitly asks for them. So I don't
actually think the list will ever change which is why I think it might
work to have it in a separate file.

> Even as CellBE hardware was being actively marketed, the syscall
> interfaces were never overly popular, so it's unlikely that anyone relies
> on future syscalls here anway. From the newlib repository, I see only
> eight system calls being used in total: getpid, gettid, pread, pwrite,
> read, write, readv, and writev.

Right. My policy is all new syscalls are nospu unless someone puts their
hand up to test them.

cheers

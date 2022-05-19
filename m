Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B570C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 May 2022 18:00:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L3yLp0P6Fz3bk1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 May 2022 04:00:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.233;
 helo=out03.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L3yLJ2461z2xKs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2022 03:59:50 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52]:36212)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nrkR5-00ENiG-OH; Thu, 19 May 2022 11:59:43 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38802
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nrkR3-006e82-PA; Thu, 19 May 2022 11:59:43 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Baoquan He <bhe@redhat.com>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
 <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
 <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
Date: Thu, 19 May 2022 12:59:17 -0500
In-Reply-To: <YoWySwbszfdZS9LU@MiWiFi-R3L-srv> (Baoquan He's message of "Thu, 
 19 May 2022 10:58:19 +0800")
Message-ID: <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrkR3-006e82-PA; ; ;
 mid=<87bkvt4d56.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.174.4; ; ; frm=ebiederm@xmission.com;
 ; ; spf=softfail
X-XM-AID: U2FsdGVkX1/rSxyKigaHMoSccMUFZ8spyBuVsjtCT6w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Baoquan He <bhe@redhat.com> writes:

> Hi Eric,
>
> On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> 
>> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> > symbols") [1], binutils (v2.36+) started dropping section symbols that
>> > it thought were unused.  This isn't an issue in general, but with
>> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
>> > separate .text.unlikely section and the section symbol ".text.unlikely"
>> > is being dropped. Due to this, recordmcount is unable to find a non-weak
>> > symbol in .text.unlikely to generate a relocation record against.
>> >
>> > Address this by dropping the weak attribute from these functions:
>> > - arch_kexec_apply_relocations() is not overridden by any architecture
>> >   today, so just drop the weak attribute.
>> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>> >   Retain the function prototype for those and move the weak
>> >   implementation into the header as a static inline for other
>> >   architectures.
>> >
>> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
>> 
>> Any chance you can also get machine_kexec_post_load,
>> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
>> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
>> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
>> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.
>> 
>> That is everything in kexec that uses a __weak symbol.  If we can't
>> count on them working we might as well just get rid of the rest
>> preemptively.
>
> Is there a new rule that __weak is not suggested in kernel any more?
> Please help provide a pointer if yes, so that I can learn that.
>
> In my mind, __weak is very simple and clear as a mechanism to add
> ARCH related functionality.

You should be able to trace the conversation back for all of the details
but if you can't here is the summary.

There is a tool that some architectures use called recordmcount.  The
recordmcount looks for a symbol in a section, and ignores all weak
symbols.  In certain cases sections become so simple there are only weak
symbols.  At which point recordmcount fails.

Which means in practice __weak symbols are unreliable and don't work
to add ARCH related functionality.

Given that __weak symbols fail randomly I would much rather have simpler
code that doesn't fail.  It has never been the case that __weak symbols
have been very common in the kernel.  I expect they are something like
bool that have been gaining traction.  Still given that __weak symbols
don't work.  I don't want them.

Eric

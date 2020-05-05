Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A489C47247
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 20:34:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A604920746
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 20:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A604920746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GrzV1lstzDqkf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 06:33:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=xmission.com
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Grxg0kHLzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 06:32:21 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out01.mta.xmission.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.90_1)
 (envelope-from <ebiederm@xmission.com>)
 id 1jW4Eh-0006W8-CV; Tue, 05 May 2020 14:32:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com) by in02.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1jW4Ef-0006JU-Rg; Tue, 05 May 2020 14:32:15 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20200505101256.3121270-1-hch@lst.de>
 <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
Date: Tue, 05 May 2020 15:28:50 -0500
In-Reply-To: <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
 (Linus Torvalds's message of "Tue, 5 May 2020 09:52:04 -0700")
Message-ID: <877dxqgm7x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW4Ef-0006JU-Rg; ; ; mid=<877dxqgm7x.fsf@x220.int.ebiederm.org>;
 ; ; hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX19LmJDSmWFKMWb2UuEaurqQBJ8BfhbCMgQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: remove set_fs calls from the coredump code v6
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
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
Cc: Arnd Bergmann <arnd@arndb.de>, the arch/x86 maintainers <x86@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 5, 2020 at 3:13 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> this series gets rid of playing with the address limit in the exec and
>> coredump code.  Most of this was fairly trivial, the biggest changes are
>> those to the spufs coredump code.
>
> Ack, nice, and looks good.
>
> The only part I dislike is how we have that 'struct compat_siginfo' on
> the stack, which is a huge waste (most of it is the nasty padding to
> 128 bytes).
>
> But that's not new, I only reacted to it because the code moved a bit.
> We cleaned up the regular siginfo to not have the padding in the
> kernel (and by "we" I mean "Eric Biederman did it after some prodding
> as part of his siginfo cleanups" - see commit 4ce5f9c9e754 "signal:
> Use a smaller struct siginfo in the kernel"),  and I wonder if we
> could do something similar with that compat thing.
>
> 128 bytes of wasted kernel stack isn't the end of the world, but it's
> sad when the *actual* data is only 32 bytes or so.

We probably can.   After introducing a kernel_compat_siginfo that is
the size that userspace actually would need.

It isn't something I want to mess with until this code gets merged, as I
think the set_fs cleanups are more important.


Christoph made some good points about how ugly the #ifdefs are in
the generic copy_siginfo_to_user32 implementation.

I am thinking the right fix is to introduce.
	- TS_X32 as a companion to TS_COMPAT in the x86_64.
        - Modify in_x32_syscall() to test TS_X32
        - Implement x32_copy_siginfo_to_user32 that forces TS_X32 to be
          set. AKA:
        
	        x32_copy_siginfo_to_user32()
	        {
	        	unsigned long state = current_thread_info()->state;
	                current_thread_info()->state |= TS_X32;
	                copy_siginfo_to_user32();
	                current_thread_info()->state = state;
	        }

That would make the #ifdefs go away, but I don't yet know what the x86
maintainers would say about that scheme.  I think it is a good path as
it would isolate the runtime cost of that weird SIGCHLD siginfo format
to just x32.  Then ia32 in compat mode would not need to pay.

Once I get that then it will be easier to introduce a yet another helper
of copy_siginfo_to_user32 that generates just the kernel_compat_siginfo
part, and the two visible derivatives can call memset and clear_user
to clear the unset parts.

I am assuming you don't don't mind having a full siginfo in
elf_note_info that ultimately gets copied into the core dump?

Eric

Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19158C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 21:58:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2382082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="b2saf7+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2382082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kT4L1dFpzDrNw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 08:58:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="b2saf7+y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mpi-sws.org
 (client-ip=139.19.86.40; helo=juno.mpi-klsb.mpg.de;
 envelope-from=msammler@mpi-sws.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="b2saf7+y"; 
 dkim-atps=neutral
Received: from juno.mpi-klsb.mpg.de (srv-40-62.mpi-klsb.mpg.de [139.19.86.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kT1r4Z6NzDrNV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 08:55:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org;
 s=mail200803; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=jf4sdl6lmwSCwIgWC2kqj5tO7nd9bUtf7kM0Lo13O8E=; 
 b=b2saf7+yP8bJMSMHCNFowL+aG3//zuNzAgl6+DJtg7Hq3iS5HiavuFvYrX+jW3bT1Fi0h0z2g4yAK0O0B17xYAH/qPMlQGTmLXWxQRIgnG4FCCJhvF9kmb4FD6O3GTJUg3iCPJx/z242F0W9YbxJSDMnMY1byxEHaaEPWv1DId4=;
Received: from srv-00-61.mpi-klsb.mpg.de ([139.19.86.26]:41862
 helo=sam.mpi-klsb.mpg.de)
 by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHFVk-0008PK-Cx; Mon, 29 Oct 2018 22:55:50 +0100
Received: from ip5f5860b3.dynamic.kabel-deutschland.de ([95.88.96.179]:61974
 helo=[192.168.178.163])
 by sam.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHFVk-0005Sc-4o; Mon, 29 Oct 2018 22:55:48 +0100
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
 <7d93080b-68bd-7563-bd3b-e7ee1545e367@intel.com>
 <CAG48ez1mY7Osdsc4iJ1JKq=C60wb9bQF=aHbi1fb=pb_V2XMJA@mail.gmail.com>
 <62e09400-0443-8db9-a389-ba4f4201226b@intel.com>
From: Michael Sammler <msammler@mpi-sws.org>
Message-ID: <2fefcbfc-1d7e-dfe8-d49a-07824218d389@mpi-sws.org>
Date: Mon, 29 Oct 2018 22:55:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <62e09400-0443-8db9-a389-ba4f4201226b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-MPI-Local-Sender: true
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
Cc: wad@chromium.org, Kees Cook <keescook@chromium.org>,
 Linux API <linux-api@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxram@us.ibm.com,
 Andy Lutomirski <luto@amacapital.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Am 29.10.2018 um 18:29 schrieb Dave Hansen:

> On 10/29/18 9:48 AM, Jann Horn wrote:
>> On Mon, Oct 29, 2018 at 5:37 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>> I'm not sure this is a great use for PKRU.  I *think* the basic problem
>>> is that you want to communicate some rights information down into a
>>> filter, and you want to communicate it with PKRU.  While it's handy to
>>> have an extra register that nobody (generally) mucks with, I'm not quite
>>> convinced that we want to repurpose it this way.
>> That's not how I understand it; I believe that the context is probably
>> https://arxiv.org/pdf/1801.06822.pdf ?
>> My understanding is that PKRU is used for lightweight in-process
>> sandboxing, and to extend this sandbox protection to the syscall
>> interface, it is necessary to expose PKRU state to seccomp filters.
>> In other words, this isn't using PKRU exclusively for passing rights
>> into a filter, but it has to use PKRU anyway.
> PKRU gives information about rights to various bits of application data.
>   From that, a seccomp filter can infer the context, and thus the ability
> for the code to call a given syscall at a certain point in time.
>
> This makes PKRU an opt-in part of the syscall ABI, which is pretty
> interesting.  We _could_ do the same kind of thing with any callee-saved
> general purpose register, but PKRU is particularly attractive because
> there is only one instruction that writes to it (well, outside of
> XSAVE*), and random library code is very unlikely at this point to be
> using it.
I agree with you on the points, why PKRU is particularly attractive but 
I think the most important point is that PKRU is _not_ a general purpose 
register, but is already used to control access to some resource 
(memory). This patch would allow to also control access to another 
resource (system calls) using the PKRU. This is why it makes sense to 
use the PKRU in this patch instead of another callee-saved register.
> PKRU getting reset on signals, and the requirement now that it *can't*
> be changed if you make syscalls probably needs to get thought about very
> carefully before we do this, though.
I am not sure, whether I follow you. Are you saying, that PKRU is 
currently not guaranteed to be preserved across system calls?
This would make it very hard to use protection keys if libc does not 
save and restore the PKRU before/after systemcalls (and I am not aware 
of this).

Or do you mean, that the kernel might want to use the PKRU register for 
its own purposes while it is executing?
Then the solution you proposed in another email in this thread would 
work: instead of providing the seccomp filter with the current value of 
the PKRU (which might be different from what the user space expects) use 
the user space value which must have been saved somewhere (otherwise it 
would not be possible to restore it).

Or are you afraid, that one part of a user space program installs a 
seccomp filter, which blocks system calls based on the PKRU, and another 
part of the same program (maybe a library) changes the PKRU in a way, 
which the first part did not expect and the program dies because it 
tries to do a forbidden system call?
I don't know whether the kernel can (and wants) do anything against 
this. This problem also exists without this patch if you replace system 
call with memory access.

-- Michael

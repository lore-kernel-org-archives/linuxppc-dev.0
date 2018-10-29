Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF175C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 17:05:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305AF20824
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 17:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="WXs+CdjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305AF20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kLb21PbyzF14d
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 04:05:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="WXs+CdjG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mpi-sws.org
 (client-ip=139.19.86.40; helo=juno.mpi-klsb.mpg.de;
 envelope-from=msammler@mpi-sws.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="WXs+CdjG"; 
 dkim-atps=neutral
Received: from juno.mpi-klsb.mpg.de (juno.mpi-klsb.mpg.de [139.19.86.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kLW35SVWzF0yv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 04:02:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org;
 s=mail200803; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=9N5ubwzE97W6nhq7z7bVr7wBJygCs3RTk+x2mBr/x1Q=; 
 b=WXs+CdjGlZRLHRuGtmaCqlxYmhlCTb0nPPe+BB4NY5zJKMFRa2XM7x7LwBC1ExK6nKjNYbDvXG0A7mFtOhjZVQd8X6EKHmuSWfcmvJmpq9L5C+zaoKL8IHlrPYIdp/FnA6x9Z2l0PkWj0M228WYp5kymH9q//p0zgpFGqHRyjAM=;
Received: from sam.mpi-klsb.mpg.de ([139.19.86.26]:34652)
 by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHAvZ-0001IY-0f; Mon, 29 Oct 2018 18:02:11 +0100
Received: from wks-40-211.mpi-sws.org ([139.19.168.107]:45398)
 by sam.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHAvY-0005Bg-QH; Mon, 29 Oct 2018 18:02:08 +0100
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To: Jann Horn <jannh@google.com>, Dave Hansen <dave.hansen@intel.com>
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
 <7d93080b-68bd-7563-bd3b-e7ee1545e367@intel.com>
 <CAG48ez1mY7Osdsc4iJ1JKq=C60wb9bQF=aHbi1fb=pb_V2XMJA@mail.gmail.com>
From: Michael Sammler <msammler@mpi-sws.org>
Message-ID: <24afa443-92e8-8202-845a-c1e1df1a3226@mpi-sws.org>
Date: Mon, 29 Oct 2018 18:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1mY7Osdsc4iJ1JKq=C60wb9bQF=aHbi1fb=pb_V2XMJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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

On 10/29/2018 05:48 PM, Jann Horn wrote:
> On Mon, Oct 29, 2018 at 5:37 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 10/29/18 9:25 AM, Kees Cook wrote:
>>> On Mon, Oct 29, 2018 at 4:23 AM, Michael Sammler <msammler@mpi-sws.org> wrote:
>>>> Add the current value of an architecture specific protection keys
>>>> register (currently PKRU on x86) to data available for seccomp-bpf
>>>> programs to work on. This allows filters based on the currently
>>>> enabled protection keys.
>> How does the current "assignment" of protection keys to the various uses
>> get communicated to the filter?
> I assume that you first allocate your protection keys, then install the filter?
>
Yes, but I agree that it should probably be documented, that the filter 
should only look at the parts of the PKRU, which belong to pkeys the 
user space program allocated (if the kernel wants to use some parts of 
the PKRU for its own purposes).
>> I'm not sure this is a great use for PKRU.  I *think* the basic problem
>> is that you want to communicate some rights information down into a
>> filter, and you want to communicate it with PKRU.  While it's handy to
>> have an extra register that nobody (generally) mucks with, I'm not quite
>> convinced that we want to repurpose it this way.
> That's not how I understand it; I believe that the context is probably
> https://arxiv.org/pdf/1801.06822.pdf ?
> My understanding is that PKRU is used for lightweight in-process
> sandboxing, and to extend this sandbox protection to the syscall
> interface, it is necessary to expose PKRU state to seccomp filters.
> In other words, this isn't using PKRU exclusively for passing rights
> into a filter, but it has to use PKRU anyway.
Yes, https://arxiv.org/pdf/1801.06822.pdf is indeed the context and what 
you say is correct.
>> Also, I'm not sure the kernel provides the PKRU guarantees you want at
>> the moment.  Our implementation *probably* works, but it's mostly by
>> accident.
I don't know, which guarantees about the PKRU are provided at the 
moment, but the only guarantee needed for this patch is, that the kernel 
does not change the bits of the PKRU register, which belong to pkeys 
allocated by the user program, between the syscall entry and the call to 
secure_computing(). Is there are use case where the kernel would like to 
modify these bits of the PKRU?

-- MIchael

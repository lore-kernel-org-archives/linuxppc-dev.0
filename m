Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFDC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 16:44:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF492083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="MFbFs4WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF492083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gtJS1lfxzF3B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 03:44:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="MFbFs4WN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mpi-sws.org
 (client-ip=139.19.86.40; helo=juno.mpi-klsb.mpg.de;
 envelope-from=msammler@mpi-sws.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="MFbFs4WN"; 
 dkim-atps=neutral
Received: from juno.mpi-klsb.mpg.de (srv-40-62.mpi-klsb.mpg.de [139.19.86.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gtFj6WDJzF38c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 03:42:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org;
 s=mail200803; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=R0FKIInajIKhXJiPNXQgd1krbW5sMDNf5yX/B61YWr8=; 
 b=MFbFs4WNegZmNDBkOngYb1uc1TBgzGkIKWN955ElpBXau2KLPXbs7oe6FlOkwRn2bV3xiv0iwkMcnvyiKegOGtSiB06GvJcvxxzb1norUO3fpDQsDXcA9UPAFKpU8NtEJ4SIsVL11YLGPldaamBfFBhgLT4bIEF9nQsIZPiwmqA=;
Received: from sam.mpi-klsb.mpg.de ([139.19.86.26]:54660)
 by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gFihy-0007j8-Cv; Thu, 25 Oct 2018 18:42:08 +0200
Received: from wks-40-211.mpi-sws.org ([139.19.168.107]:55748)
 by sam.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gFihy-0003jU-7M; Thu, 25 Oct 2018 18:42:06 +0200
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
To: Florian Weimer <fweimer@redhat.com>
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
 <875zxqo0ee.fsf@oldenburg.str.redhat.com>
From: Michael Sammler <msammler@mpi-sws.org>
Message-ID: <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
Date: Thu, 25 Oct 2018 18:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875zxqo0ee.fsf@oldenburg.str.redhat.com>
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
Cc: Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>,
 linux-api@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/25/2018 11:12 AM, Florian Weimer wrote:
>> I understand your concern about exposing the number of protection keys
>> in the ABI. One idea would be to state, that the pkru field (which
>> should probably be renamed) contains an architecture specific value,
>> which could then be the PKRU on x86 and AMR (or another register) on
>> POWER. This new field should probably be extended to __u64 and the
>> reserved field removed.
> POWER also has proper read/write bit separation, not PKEY_DISABLE_ACCESS
> (disable read and write) and PKEY_DISABLE_WRITE like Intel.  It's
> currently translated by the kernel, but I really need a
> PKEY_DISABLE_READ bit in glibc to implement pkey_get in case the memory
> is write-only.
The idea here would be to simply provide the raw value of the register 
(PKRU on x86, AMR on POWER) to the BPF program and let the BPF program 
(or maybe a higher level library like libseccomp) deal with the 
complications of interpreting this architecture specific value (similar 
how the BPF program currently already has to deal with architecture 
specific system call numbers). If an architecture were to support more 
protection keys than fit into the field, the architecture specific value 
stored in the field might simply be the first protection keys. If there 
was interest, it would be possible to add more architecture specific 
fields to seccomp_data.
>> Another idea would be to not add a field in the seccomp_data
>> structure, but instead provide a new BPF instruction, which reads the
>> value of a specified protection key.
> I would prefer that if it's possible.  We should make sure that the bits
> are the same as those returned from pkey_get.  I have an implementation
> on POWER, but have yet to figure out the implications for 32-bit because
> I do not know the AMR register size there.
>
> Thanks,
> Florian
I have had a look at how BPF is implemented and it does not seem to be 
easy to just add an BPF instruction for seccomp since (as far as I 
understand) the code of the classical BPF (as used by seccomp) is shared 
with the code of eBPF, which is used in many parts of the kernel and 
there is at least one interpreter and one JIT compiler for BPF. But 
maybe someone with more experience than me can comment on how hard it 
would be to add an instruction to BPF.

- Michael

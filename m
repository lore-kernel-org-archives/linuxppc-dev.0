Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B6C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:57:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676B2075D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="vY5Aa/Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gpbW6dn9zF37J
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="vY5Aa/Hu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mpi-sws.org
 (client-ip=139.19.86.40; helo=juno.mpi-klsb.mpg.de;
 envelope-from=msammler@mpi-sws.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="vY5Aa/Hu"; 
 dkim-atps=neutral
X-Greylist: delayed 401 seconds by postgrey-1.36 at bilbo;
 Thu, 25 Oct 2018 19:46:15 AEDT
Received: from juno.mpi-klsb.mpg.de (srv-40-62.mpi-klsb.mpg.de [139.19.86.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gghR0d2NzDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 19:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org;
 s=mail200803; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=OtszJXbILkhAzIveiKRaaIsBfFrcMgI062lAwpLYMtY=; 
 b=vY5Aa/Hu89tshvVfndMdzINwSivtujxlske7U1CAwHxp4n2YvpP4rzt8UyQAHJ4zmdbx12dnKA5LPkNxKN4i6WRlQttGuG7UVbzISMwqWsaDodrJdgeJ4KkhUguwA2C1JeQLzpdJigjwnscBY7rUnYzBAiW+Z1LNL3LuMUKdtTQ=;
Received: from sam.mpi-klsb.mpg.de ([139.19.86.26]:36706)
 by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gFbAj-0003xr-Pp; Thu, 25 Oct 2018 10:39:19 +0200
Received: from wks-40-211.mpi-sws.org ([139.19.168.107]:48218)
 by sam.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gFbAj-0003zS-J2; Thu, 25 Oct 2018 10:39:17 +0200
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
To: Florian Weimer <fweimer@redhat.com>
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
From: Michael Sammler <msammler@mpi-sws.org>
Message-ID: <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
Date: Thu, 25 Oct 2018 10:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-MPI-Local-Sender: true
X-Mailman-Approved-At: Fri, 26 Oct 2018 00:50:26 +1100
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

On 10/24/2018 08:06 PM, Florian Weimer wrote:

> * Michael Sammler:
>
>> Add the current value of the PKRU register to data available for
>> seccomp-bpf programs to work on. This allows filters based on the
>> currently enabled protection keys.
>> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
>> index 9efc0e73..e8b9ecfc 100644
>> --- a/include/uapi/linux/seccomp.h
>> +++ b/include/uapi/linux/seccomp.h
>> @@ -52,12 +52,16 @@
>>    * @instruction_pointer: at the time of the system call.
>>    * @args: up to 6 system call arguments always stored as 64-bit values
>>    *        regardless of the architecture.
>> + * @pkru: value of the pkru register
>> + * @reserved: pad the structure to a multiple of eight bytes
>>    */
>>   struct seccomp_data {
>>   	int nr;
>>   	__u32 arch;
>>   	__u64 instruction_pointer;
>>   	__u64 args[6];
>> +	__u32 pkru;
>> +	__u32 reserved;
>>   };
> This doesn't cover the POWER implementation.  Adding Cc:s.
>
> And I think the kernel shouldn't expose the number of protection keys in
> the ABI.
>
> Thanks,
> Florian
Thank you for the pointer about the POWER implementation. I am not 
familiar with POWER in general and its protection key feature at all. 
Would the AMR register be the correct register to expose here?

I understand your concern about exposing the number of protection keys 
in the ABI. One idea would be to state, that the pkru field (which 
should probably be renamed) contains an architecture specific value, 
which could then be the PKRU on x86 and AMR (or another register) on 
POWER. This new field should probably be extended to __u64 and the 
reserved field removed.

Another idea would be to not add a field in the seccomp_data structure, 
but instead provide a new BPF instruction, which reads the value of a 
specified protection key.

- Michael

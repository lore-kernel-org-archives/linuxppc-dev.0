Return-Path: <linuxppc-dev+bounces-17585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2BEDA687
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:17:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQKDf0Gqqz30Lw;
	Wed, 04 Mar 2026 02:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772551073;
	cv=none; b=YjyXe/dhQhiAT3rHOV58HGMgu6g1RoHp0Kus0f9pjoLhrVLrRsHPiZnviNC2X3jqiYIYTOmUrB4SWUhuQigom6HVOrTJvnUzE1/YLyZOZmKnqx5lVPSscJCxV/raJKR0a5OrhW0061NGDOMuavYIgZmopQza1xHX1kgko/gJ880VbQ+vyZJrkoQiBnBFDhVSxZaD+SOqPsk71VEsNzCBupPvmJDkyt0DVBTwwrw7lDcO1D1Bm5J1kYSKs3ZmXCKoeEM9C4EKz5A3YU+DHlb12GEbg1lA5dJtv51dIznk6/jkAP7Wjue5mis/FVgzYG//jFgiHxQUHkwsi1N+6oN5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772551073; c=relaxed/relaxed;
	bh=9qfH6jeAUQYYS7o1S/nMh7kw/Ts1Z0SpG0xI7zMjymc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Btas4ibRfh2LGtn818mcj++N2St+FDVxikWBkDhBixR5wVxxLH8Tyk88HMNPgTTdneJywFqyX4ggJF5OWVMjHqgm22RPtld9TQ85NVwLMHFW+d4RshZmlDRFe9wwMny21euZ+hzRJ+kTZVe9kVcOEhcuocMEOy601ZsYBCIaUhGE3litViKVieIYdTzVPxb+4zaEXVR2CA0XaJesl5xXsevXUpc3W8O+PFyk6iwI2izXStjrG57jTHzFTOp7XScyIH51/q+c36y7r0fRbaSskkooBAQ9W44zoYvGCBJOL/QyqdVqwEbHXWICoqGN3V9TrNMfWBgMeXJgKyCdlMhqXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/F5Go+e; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/F5Go+e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQKDc63Ztz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 02:17:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BBD6060053;
	Tue,  3 Mar 2026 15:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E2C2BCB1;
	Tue,  3 Mar 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772551069;
	bh=9x7ijW1J9N6R732fXw9YQTUsbNskyHBDZG0ErdRgxm8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=R/F5Go+ecKWcrisyC6t/5+IjaQvuZnTOZXvslqm4+hbUl5pMWRAWYrmcJnipHdEzy
	 IA+j9aBO4/y1lxwELAqKdXFjQ5CiQfhdMGyI8oxYPBMrxSIw4YHRxYggZzV3Sv+QL1
	 5bGl0klf+WzOY74eRO4DLgRSPwewcJeGA9wIuuuHN5TKySK9mm43c5v8IQSS/At35N
	 ESpi2A92AZ0XObY3ZcrAFzU3cFvmqnjtl1L8o5NSYyGzaua06uO1naBnpN2XFsfa1F
	 3HTuIemFxmxl9IP1Rjpj66wpQtVnA6+GV7+ZDHBXjCZCl6YTo47iZ3ODAtfDlVkT1y
	 B/DJsZsxIDp7w==
Message-ID: <b605bdcf-fe10-4fe3-9a83-8c542e980a3e@kernel.org>
Date: Tue, 3 Mar 2026 16:17:45 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc: fix KUAP warning in VMX usercopy path
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com
Cc: aboorvad@linux.ibm.com, sshegde@linux.ibm.com, riteshh@linux.ibm.com,
 hbathini@linux.ibm.com, ming.lei@redhat.com, csander@purestorage.com,
 czhong@redhat.com, venkat88@linux.ibm.com
References: <20260228135319.238985-1-sayalip@linux.ibm.com>
 <d90efa16-932e-4c29-b8e1-1a4ef08db403@kernel.org>
 <c5138d29-e192-4a6f-b5d2-40d3a29d5bd4@linux.ibm.com>
 <65abe055-38b4-44ec-a7a0-7b4161677ead@kernel.org>
 <5eaa620f-17cb-4ecb-a1bd-eadc7df81574@kernel.org>
Content-Language: fr-FR
In-Reply-To: <5eaa620f-17cb-4ecb-a1bd-eadc7df81574@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi once more,

Le 03/03/2026 à 16:10, Christophe Leroy (CS GROUP) a écrit :
> Hi Again,
> 
> Le 03/03/2026 à 15:57, Christophe Leroy (CS GROUP) a écrit :
>> Hi,
>>
>> Le 03/03/2026 à 10:19, Sayali Patil a écrit :
>>>
>>> On 02/03/26 16:42, Christophe Leroy (CS GROUP) wrote:
>>>>
>>> Hi Christophe,
>>> Thanks for the review.
>>> With the suggested change, we are hitting a compilation error.
>>>
>>> The issue is related to how KUAP enforces the access direction.
>>> allow_user_access() contains:
>>>
>>> BUILD_BUG_ON(!__builtin_constant_p(dir));
>>>
>>> which requires that the access direction is a compile-time constant.
>>> If we pass a runtime value (for example, an unsigned long), the
>>> __builtin_constant_p() check fails and triggers the following build 
>>> error.
>>>
>>> Error:
>>> In function 'allow_user_access', inlined from 
>>> '__copy_tofrom_user_vmx' at arch/powerpc/lib/vmx-helper.c:19:3:
>>> BUILD_BUG_ON failed: !__builtin_constant_p(dir) 706
>>>
>>>
>>> The previous implementation worked because allow_user_access() was 
>>> invoked with enum
>>> constants (READ, WRITE, READ_WRITE), which satisfied the 
>>> __builtin_constant_p() requirement.
>>> So in this case, the function must be called with a compile-time 
>>> constant to satisfy KUAP.
>>>
>>> Please let me know if you would prefer a different approach.
>>>
>>
>> Ah, right, I missed that. The problem should only be in vmx-helper.c
>>
> 
> Thinking about it once more, I realised that powerpc does not define 
> INLINE_COPY_FROM_USER nor INLINE_COPY_TO_USER.
> 
> This means that raw_copy_from_user() and raw_copy_to_user() will in 
> really not be called much. Therefore __copy_tofrom_user_vmx() could 
> remain in uaccess.h as static __always_inline allthough it requires 
> exporting enter_vmx_usercopy() and exit_vmx_usercopy().

That would result in something like:

static __always_inline bool will_use_vmx(unsigned long n)
{
	return IS_ENABLED(CONFIG_ALTIVEC) && cpu_has_feature(CPU_FTR_VMX_COPY) &&
	       n > VMX_COPY_THRESHOLD;
}

static __always_inline unsigned long
raw_copy_tofrom_user(void __user *to, const void __user *from, unsigned 
long n, unsigned long dir)
{
	unsigned long ret;

	if (will_use_vmx(n) && enter_vmx_usercopy()) {
		allow_user_access(to, dir);
		ret = __copy_tofrom_user_power7_vmx(to, from, size);
		prevent_user_access(dir);
		exit_vmx_usercopy();

		if (unlikely(ret)) {
			allow_user_access(to, dir);
			ret = __copy_tofrom_user_base(to, from, size);
			prevent_user_access(dir);
		}
		return ret;
	}
	allow_user_access(to, dir);
	ret = __copy_tofrom_user(to, from, n);
	prevent_user_access(dir);
	return ret;
}


Christophe


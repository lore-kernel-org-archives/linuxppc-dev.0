Return-Path: <linuxppc-dev+bounces-26360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD08C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 07:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYxsb4LM9z2y2S;
	Tue, 01 Sep 2026 17:13:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788246803;
	cv=none; b=VQP39N0UyAAK9MUoJvRgk7EKLslU2Sdb3GMkN4yb5la0TliFwB0Hl6FtVVAhzafIvjIBf054eueklPIGYEtkr5XbyAlXHfuVUt1aRig+/LDOxhKRf8RNQAb0D3IY96ZFFTIyJeczBbkvvA3OAJlqKgR77PI7eCFgnoJW45EU1aaOa7czB0TqFTL+1dDzz3Du3ALlna+w6pO19wjGT3L9B1kJUz11UCNU/iZlE+CUc4uMSX3mc6//1lpn1Gj1BKF32GG94bLg03PvriBNrgELwIGP9dJ9ZB3cCQticgKyp/MZErVwl3/dJmrMoVuSnTDV21h6M3O6Cr0LxwgVSekpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788246803; c=relaxed/relaxed;
	bh=7vlPVxxOq7kLEL6+QoF62NqA25ABM6Pdignc8YpmkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/eY8h8kSvztWuQSvvtnSCg3mXNNk9l5rakYSZjd2XTLwQDhA06E9C8fMe5trzGhmCYCuWmyacUU/2TZC5snFQAW2eKmRBGtsjpF0FFUIZzzIoCHlDIiXVppP2Kij6H7olKuPY+5sRWM0v/6NaCTA4I+O26srv0CwE0G2C4SEwxT87JDFvIQH55ag67PB1rdRBSy7WbhuFlWpQduS4Nr0RblfSxvzQmC3a+rSnVcWhskzqa5kkpvX8YcP2L+hBhr+y87EKQNbUU/9YLrVF37Ut0vZxWd8sPnYYIt/IHIW/33Jo/v1TzQGPDeEolZKojK1rz+yfad9RpqBTDSY4uHJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=olwYR+dc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=olwYR+dc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYxsY1tywz2y2P
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 17:13:20 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2d91ded8174so4555225ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246797; x=1788851597; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vlPVxxOq7kLEL6+QoF62NqA25ABM6Pdignc8YpmkUk=;
        b=olwYR+dcdngj9RGDQCPPQtKEuKVsmvmuc1NMR/aEGsJrH/om4z6COVr1vJUzTwKxbL
         8bWYW80Y2i/+zvb440SqW5hiWs4S6HNjXxHpfiRnQ4QyJ3Khm+OganoPHWe90Y28bbwh
         u3XTGfkf4CdR+1+xsitWtVidmqmw5lIbFZkLogBp+M+xL0sBOos7FYFR4IARHmwCp+Rb
         OvC8MDRcBist2v+4SeeRyyPM+RWFJUMMufQ4brjnXcv7nPwr2CL3RPwPF7wRoTWREhVy
         mur1l37AGCHoT6pvaSm6OeaDdft76iml6Dq+cqLkoutxDgCIjPoF6zkCLT2LUftRm4C8
         d64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246797; x=1788851597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vlPVxxOq7kLEL6+QoF62NqA25ABM6Pdignc8YpmkUk=;
        b=poH8nlD2fbvEetnBOunb7D/vSHMMObLiS7KlJ2xloEfRTPZbf0V25SeY0FEmBGKst4
         Erm+KWAew5g79HQtIlEhFCoRzPHIKvhT2l4wonkKfjZDi2XiTXcFV6BdkYw29deNHkgJ
         BmuaYyOTcfMcaIGoC18JWoL27pWC50V6QVblmUmpwl0VNjlh9p65f6lAVvxWQX0c7VtD
         ZqVxZtGP1JWuC6BIBC9cYB6UBzxAn+N4SEgFQedPaJrOHmNBniQkxpUaXbNh7zFqzWZ1
         vvBxgrjCiNNPmwWAzXTax0foHJ5U6Ew4iwwfd6tHZ5WpYb925oMfHMKIxXdGUEVP5V+k
         Ht7Q==
X-Forwarded-Encrypted: i=1; AHgh+RohI/9dH7VYj21Uy+2fUYJt5OTXL2wNapwiC+kVPR9bLixmL+Kp+kHdWHGfW3CKhC8xY2n1p3JY5APcoSw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nocaqdjYGUJEMhzL7RIC8lJZt4gcG0ri2Wh/LXjAfOgWaAwOtC
	qHbV822D8XZdOfu1+FDMB9hf5WfHNPy1PZ8TxfR/kk/2VnS6BE3tydTQ
X-Gm-Gg: AR+sD12hnwsDqjKBuFqTBa9znWe2E4Fq1RyTkYDwZ0nS62N0sS5UuzyksYExY9VeL1Z
	4D+KHTidKteh0mceEz2GFcP/0K45MeeqC0p9H1g+nteb2Gk74TwAvHJOk7Dpt960hbpvIr+/+sT
	NCBb2hYtuV2XwJOdgZl4b0ng0TsIogtCBEAXm0rdT+pJ2+u4U0dWDu+Fnt10d/2ntZ98M0Kw5Po
	coFVk33DtnKqU3wqjtF0V9BnJsWIAoDDFZDdTx7PiHiTTpplKnN25fRDKmjXM7toBbAqv85+fuZ
	H+ZK5R0DQK+ki0BaOoUEQZFXsH/s4M8UkUGW/x6EMFfFdgDEhhN9WWoHak1KMcn8OVLtjMRs3Uq
	cITqEpzQjLWOqLo4bSlB2Vq1Qwg+j3NOiTS7LYr53XLd60aOGDidCOASzkdMQG++0yl5j9QWC91
	h3js186VD13zSKsuK12THLO8xXwZgPdkOqrJOnWvDX03YYII0ubTM+eu83IpnH9A5+hYckGmRjh
	kvHxK6Kd2+sDz42DgK/2ZnWB3Ft09h4SRM=
X-Received: by 2002:a17:903:458d:b0:2d8:f965:7e48 with SMTP id d9443c01a7336-2d8f9658ad5mr288966065ad.1.1788246796726;
        Tue, 01 Sep 2026 00:13:16 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fc0b3sm47893595ad.16.2026.09.01.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:13:16 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:43:11 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: tglx@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/entry: Clear TIF_SYSCALL_RET before syscall
 error return
Message-ID: <apZ63gSfONkXTJhH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260828053811.1042300-1-sshegde@linux.ibm.com>
 <apUBdKP1ytHSvuQd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <46786528-4e56-4df3-b142-bcf047bacbb0@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46786528-4e56-4df3-b142-bcf047bacbb0@linux.ibm.com>

On Mon, Aug 31, 2026 at 02:34:10PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 8/31/26 10:09 AM, Mukesh Kumar Chaurasiya wrote:
> > On Fri, Aug 28, 2026 at 11:08:11AM +0530, Shrikanth Hegde wrote:
> > > Shivaprasad reported a boot failure due to userspace processes crash on
> > > abort() from libc.so.6. It was bisected to merge request
> > > commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'
> > > 
> > > Upon checking the merge, when syscall_enter_from_user_mode_randomize_stack
> > > fails, which could happen when a tracer like seccomp or ptrace intercepts
> > > and skips the syscall, the code returns to userspace immediately without
> > > clearing the intermediate flag which was set.
> > > 
> > > When the next syscall is made, it immediately aborts the valid syscall
> > > since the flag is still set. Hence clear the flag on occurrence of first
> > > failure.
> > > 
> > > Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > > Closes: https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com/
> > > Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > ---
> > > PS: I have kept the block below since earlier code was checking it
> > > regardless of result of syscall_enter_from_user_mode. If it turns out
> > > to be a redundant, it can be removed later.
> > > 
> > I think it is redundant as of now. The TIF_SYSCALL_RET flag is set when
> > error is set by the ptrace or seccomp, If the error value is set then
> > the syscall_enter_from_user_mode_randomize_stack will return false.
> > Hence the next check will become redundant.
> > 
> > I also see that TIF_SYSCALL_RET is also set when processing the ptrace
> > syscall, Which can leave the flag set for next syscall execution. Which
> > can again trigger the same issue.
> > 
> 
> I believe it is a pre-existing bug which can be fixed independent of this issue.
> Since merge request broke the userspace it is better we fix it right away and
> this pre-existing issue fix can be done subsequently.
> 
> No?
> 
Agreed.
Sure we can send that as a separate fix.
With that,

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Regards
Mukesh.
> > Regards,
> > Mukesh
> > >   arch/powerpc/kernel/syscall.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > index 4916c205c4bb..fbefe1927b10 100644
> > > --- a/arch/powerpc/kernel/syscall.c
> > > +++ b/arch/powerpc/kernel/syscall.c
> > > @@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > >   	long ret;
> > >   	syscall_fn f;
> > > -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> > > +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> > > +		clear_thread_flag(TIF_SYSCALL_RET);
> > >   		return syscall_get_error(current, regs);
> > > +	}
> > >   	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> > >   		return syscall_get_error(current, regs);
> > > -- 
> > > 2.47.3
> > > 
> 


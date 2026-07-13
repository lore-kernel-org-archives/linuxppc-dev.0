Return-Path: <linuxppc-dev+bounces-24097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F510C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 06:51:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzCkv23m7z2xqM;
	Mon, 13 Jul 2026 16:51:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783925463;
	cv=none; b=e6PSFLooAUcoRt+R0BtbrVRYVc7Ek7BiqWQdEcK06ruChoO265B9kllqIi1B3ucjV+Kl82LmiOmLXJ8B/MIe31GUhS+N+ZXMXzX3RMX1attDNDxcWzr3t5zzN7GK84fxhxUOq3gcrHB+uveeRKT9oitHAlHTba96Xg6M1HZDVsMIWt2nuDR9WPYyGIEa7MpEw9p4x+rPxM7wog9lxcNuKhWnfiZJ/YWCxbMU/QkfA8WCD97ZfNnhSlUvZf6wt1ePgs2USJPVBYLAreJMKMdcL4sl42VQhg2L2sqwrxU8X7psDK6FFcZNDBS4jubqooroRYqnDvrtxYXufTKBJpN8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783925463; c=relaxed/relaxed;
	bh=eWmwa1QUvWmWfZcAMrMrN6lD6RiBuEcOW0PxEeSlbVg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=cuazkHMah2nrNMOBJTdOY0RuDLeBDTkYaVHi3YLNB4Yg4Na4aC0FZLlWfhbU+J6M3UffaeRjZwovusyeUETTRgZDz5natYhAX6YrDmUUknRzngakbAyv/T1ktfPrADrvthzJM01ibYz6oRojPXf/YOwW7WAhnqbNIMeZw0Q8BcJCGLfS+FB78otINPWqoOoDmfGrNyEHycT0SFTS4nPJoXxQU0cOUks2nuumrZbogyHZtfsBoD5ma8tnTfwuFbaWRkQLHhK4pIGVI8HclbXbYqmGdsQg9ANlAhOhA5MhqP9455xsyojwRG7Fhburk8EParawsQzuAPS30yHQvVpZJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IxyNO+w+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IxyNO+w+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzCks6JGWz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 16:51:01 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3253173a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783925458; x=1784530258; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWmwa1QUvWmWfZcAMrMrN6lD6RiBuEcOW0PxEeSlbVg=;
        b=IxyNO+w+nNjunfW6Mj4auR5jV7jVmGf1IUMiOjFvD+898irwk9YZeKrgDNr5yopghF
         3N3Fms8p2dKZuKPrU6DpvZBMo8cFbkSnVaqM8ouRFRWI3rFJu8VVm5w1sz9gOUBwNNSN
         EfWUdHL1r5gITuv9Qr9e+Tpx8A0Cz/YRPL5KO5x+F9b+wFfBV6eyFZ8uzo3MV6bcebJe
         XjS+BXf1I4Ld6itOnn7Al71QQ+YsULj1N6BBg4zmK8W/eX8o8CXtIdmA580E51J5qjzW
         B7Eerhvrm9c6+Jz/q4pPOWmlCki3k9zKxPdgpOrBaC/Qc0egC9d7jwzPSBnToNzVWwpN
         COCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783925458; x=1784530258;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWmwa1QUvWmWfZcAMrMrN6lD6RiBuEcOW0PxEeSlbVg=;
        b=VHdvtoTOhjHjj/qNnniS5gCf8icCgPg0AfzpWC2YTATm0fbto85o+m6owi989t6SMN
         D0EufrnTywtAAAXgob4uPJkfhFeWYpZ98ouG9DvY0Cr8fmWKLKf4m8N8V9RtmoTNhXdI
         I+vFT0l5eTLDYCKS0APuHAvrqXLhqS9Romd/8YkIHouaGpyJJ9R2nFr6OHRM1Zyx0WMS
         /5gCf65PV8Cwk3/yJItmqA8eO6BGm08h0oHsi5TvmfpUeiD7ou9cnLsjET1tLtWGJ8O9
         3gz38Q0Y7DfyaozZOyhsTCMtxhxKXAQcgm0kqSorRrWk6wY17TMXPmjcP6iPxSEb9wug
         YG2g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7FxPmWictJYTTllhC5Z6Kh31gLhkglirhNl/+HEyxgVBNBrejJpyLP1chZKdyEQ1BYfCPXQp++IkmIes=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTQvvngyLf63c5HXUmdHS7jrOhe9HHn0sSlGPPTs9Wgm5IVhi9
	GkIalyeovIC0dg/Px/LnCV/oY8lgjywPwE7Yo4l318hOnWv6UGAlpfft
X-Gm-Gg: AfdE7cmcbvHbJiHWjET+/xYw+S+vVP6ZP+sdEwcE3T/nJLuIc40BUf0HziyeounQsbT
	RX/sDltnUfiTGnLYj9tZF6SEsH9Ngj8RNwRWXgWe8lJW4rWWUl+o/hT9d3Bx4HO7Ff/6FHcw6Dg
	3vIibD/In2ELeaxs0L4DuBN2JTYmmG1F04LZX8ltMIsyudyDiqjI3O/af0s8XPvCfQquLZDn+dN
	gNlBkse3/gKmPS15Lpv8tl1bu8IfqY0eA1xYDxkYV/ZKFE9JbLbz+VAP+eO7upT4nTM+PdW3Y4/
	o3VoqNXcxgTpT1iciu0QeXt5b507SQFafJr9rrj35HlKA/T2wYHsAE7UKUjx89Y+2XQC68q8OA5
	rUNnGGe5cvyEK6wXHr8YR5t0ynyK1YdJuhZ/Zmbtd91oRJFN94F6RhNnWy27tFpAUddlFGrjRMv
	eDIFboKRvmROA=
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3c110009b82mr8720511637.12.1783925458332;
        Sun, 12 Jul 2026 23:50:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8fc7c088sm18775525c88.2.2026.07.12.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:50:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
Date: Mon, 13 Jul 2026 12:10:06 +0530
Message-ID: <ldbfv1dl.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <mrvvv515.ritesh.list@gmail.com> <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On 13/07/26 10:51, Ritesh Harjani (IBM) wrote:
>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>
>>> Changelog:
>>> ==========
>>>
>>> v2:
>>>   - Move H_WATCHDOG definitions to a common header for shared use
>>>     across pseries code. 1/3
>>>   - Added a new patch to handle pseries watchdog device registration
>>>     failure. 2/3
>>>   - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>>>   - Add suggested-by tag 1/3 & 3/3
>>
>> Reviewed the changes and mostly looks good with some minor nits added to
>> the individual patches.
>>
>> Small request -
>> Could you please also update test results with v3 in your changelog
>> (since you mentioned we are able to reproduce the issue easily with your
>> test code).
>
> I tested this fix with the program I shared in cover letter. The watchdog
> was successfully stopped even when H_WATCHDOG is called form crash
> handler.  I will share my test details in v3 cover letter also.
>
>>
>>
>> aah one other thing I just noticed since you are ccing stable and you
>> added a Fixes tag in patch-3.
>> Patch-3 alone cannot be easily backported now due to patch-1 and
>> patch-2. There must be a way to define the dependencies if you are
>> looking for backporting the fix patch to stable tree, please check that
>> and follow that accordingly in v3.
>
> I thought about that as well, but since they are part of the same patch 
> series,
> I assumed they would be picked together. However, I don't think that 
> will work
> in all cases.
>
> I checked the older commits and noticed that a backport note was added. 
> I think
> we can do the same for the fix patch. I'll add a note indicating that the
> following patches should be backported first:
>
> powerpc/pseries: Move H_WATCHDOG definitions to a common header
> powerpc/pseries: Handle and log pseries-wdt registration failures
>
> Since these patches are not upstream yet, I'll refer to them by their 
> commit titles.
>
> Does that look good to you?
>

Documentation/process/stable-kernel-rules.rst
  Note that for a patch series, you do not have to list as prerequisites the
  patches present in the series itself. For example, if you have the following
  patch series::

    patch1
    patch2

  where patch2 depends on patch1, you do not have to list patch1 as
  prerequisite of patch2 if you have already marked patch1 for stable
  inclusion.


In that case, I think, we should mark all 3 patches for stable inclusion.

  patch 1/3   Cc: stable@vger.kernel.org
  patch 2/3   Cc: stable@vger.kernel.org
  patch 3/3   Cc: stable@vger.kernel.org
              Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")

-ritesh


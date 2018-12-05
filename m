Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E3AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 16:23:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0FE2064D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 16:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixe8NX7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0FE2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4393vN5D6NzDqq7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 03:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ixe8NX7X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ixe8NX7X"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4393rY6VTLzDqwV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 03:21:17 +1100 (AEDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7AFF72146D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544026875;
 bh=ylkGGNQc2t4F8OSLDLnE0b+lc3fR5N1m4Py05stsJmc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ixe8NX7XiIQfJ+xzI9p+nyvbG6df4xV3YrmB8cWIIuAD+du0dgFQj646Opm2LGUIw
 uQK1um3VtJc1YtpXOlINhwI24+sD+p7xUYXxbW05qzljOEZTXIh2WgCoLYm63loiQ+
 eg8wfEXu0B4C874z7MMRPyleHzLL0j80yp0AKsDs=
Received: by mail-wm1-f43.google.com with SMTP id q26so13465091wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 08:21:15 -0800 (PST)
X-Gm-Message-State: AA+aEWaRKX0p4VALIQ+U5mQtqdNfoY1vIHOyW5D8rgWYwvM9VcRGnaBu
 smuH9LpPI6+Kyua3YDQmcfeAFwIenGRNn7HqvQSawQ==
X-Google-Smtp-Source: AFSGD/W2E9v5fcmwdohvHVqwPc8eF1cGEsMldY/9/6+P4SJvzZYTacIpvtukcN9oJcjrI6JNiCno0SZ1oFN8/39jjwg=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr12566747wmd.83.1544026873916; 
 Wed, 05 Dec 2018 08:21:13 -0800 (PST)
MIME-Version: 1.0
References: <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
 <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
 <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com>
 <87va4g5d3o.fsf@oldenburg.str.redhat.com>
 <20181203040249.GA11930@ram.oc3035372033.ibm.com>
In-Reply-To: <20181203040249.GA11930@ram.oc3035372033.ibm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 5 Dec 2018 08:21:02 -0800
X-Gmail-Original-Message-ID: <CALCETrXeSQ8T9nvK7WpgPpkraLfg70FoDWvPZeLS3KiDaqXwtw@mail.gmail.com>
Message-ID: <CALCETrXeSQ8T9nvK7WpgPpkraLfg70FoDWvPZeLS3KiDaqXwtw@mail.gmail.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
To: linuxram@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
 Linux API <linux-api@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> On Dec 2, 2018, at 8:02 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>
>> On Thu, Nov 29, 2018 at 12:37:15PM +0100, Florian Weimer wrote:
>> * Dave Hansen:
>>
>>>> On 11/27/18 3:57 AM, Florian Weimer wrote:
>>>> I would have expected something that translates PKEY_DISABLE_WRITE |
>>>> PKEY_DISABLE_READ into PKEY_DISABLE_ACCESS, and also accepts
>>>> PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ, for consistency with POWER.
>>>>
>>>> (My understanding is that PKEY_DISABLE_ACCESS does not disable all
>>>> access, but produces execute-only memory.)
>>>
>>> Correct, it disables all data access, but not execution.
>>
>> So I would expect something like this (completely untested, I did not
>> even compile this):
>
>
> Ok. I re-read through the entire email thread to understand the problem a=
nd
> the proposed solution. Let me summarize it below. Lets see if we are on t=
he same
> plate.
>
> So the problem is as follows:
>
> Currently the kernel supports  'disable-write'  and 'disable-access'.
>
> On x86, cpu supports 'disable-write' and 'disable-access'. This
> matches with what the kernel supports. All good.
>
> However on power, cpu supports 'disable-read' too. Since userspace can
> program the cpu directly, userspace has the ability to set
> 'disable-read' too.  This can lead to inconsistency between the kernel
> and the userspace.
>
> We want the kernel to match userspace on all architectures.
>
> Proposed Solution:
>
> Enhance the kernel to understand 'disable-read', and facilitate architect=
ures
> that understand 'disable-read' to allow it.
>
> Also explicitly define the semantics of disable-access  as
> 'disable-read and disable-write'
>
> Did I get this right?  Assuming I did, the implementation has to do
> the following --
>
>    On power, sys_pkey_alloc() should succeed if the init_val
>    is PKEY_DISABLE_READ, PKEY_DISABLE_WRITE, PKEY_DISABLE_ACCESS
>    or any combination of the three.
>
>    On x86, sys_pkey_alloc() should succeed if the init_val is
>    PKEY_DISABLE_WRITE or PKEY_DISABLE_ACCESS or PKEY_DISABLE_READ
>    or any combination of the three, except  PKEY_DISABLE_READ
>          specified all by itself.
>
>    On all other arches, none of the flags are supported.

I don=E2=80=99t really love having a situation where you can use different
flag combinations to refer to the same mode.

Also, we should document the effect these flags have on execute permission.

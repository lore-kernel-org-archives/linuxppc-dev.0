Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B5E7CB70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 03:53:39 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 87A00DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 03:53:38 +1000 (EST)
Received: by fxm22 with SMTP id 22so1045604fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 10:53:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
Date: Wed, 24 Jun 2009 23:16:08 +0530
Message-ID: <abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
Subject: Re: 85xx Address space query
From: kernel mailz <kernelmailz@googlemail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 24, 2009 at 6:45 PM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
>
> On Jun 24, 2009, at 4:44 AM, kernel mailz wrote:
>
>> Hi,
>>
>> I am a newbie, trying to learn but have a few queries, nice if you could
>> respond
>> For linux on 85xx systems...
>>
>> (a) Kernel code runs in PR=3D0 AS=3D0 and PID=3D0, which user space appl=
ication
>> run in PR=3D1 AS=3D0 and PID 1-255.
>> Is this correct.
>
> correct.
>
>> (b) I am writing a small program where the application code opens invoke=
s
>> a ioctl call and passes a buffer pointer ( say 0x10000 in user space)
>> Now the driver code is using copy_from_user.
>> How this works internally ?
>>
>> 1. User code executes ioctl
>> 2. interrupt goes to the kernel
>
> On the interrupt the PR changes from 0 -> 1
>
>> 3. ioctl handler in driver gets invoked
>> The buffer pointer still contains 0x10000.
>>
>> How kernel code running in PR=3D0 accesses it and does the copy. I am no=
t
>> able to see a address space switch in the asm code of copy_tofrom_user.
>
> There isn't a address space switch. =A0But address spaces exist at the sa=
me
> time. =A0The user app is given 0..0xc000_0000 and the kernel uses
> 0xc000_0000..0xffff_ffff.
>
Ah Ok, I get it Thanks Kumar

But If the app was running with PID=3D1, interrupt occurs, kernel code
gets executed in PID=3D1, how does the kernel handle this ? and goes
back to PID=3D0, since its translations are all in PID=3D0

> - k
>

Return-Path: <larry.finger@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCGWP0R3ZzDvNG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 02:26:41 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id b123so4677318itb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 07:26:40 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
To: Paul Burton <paul.burton@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
 <8737j3n18r.fsf@concordia.ellerman.id.au> <13471233.iqSeGS5aQ3@np-p-burton>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4f990791-ebff-dbe3-b923-3cac5fd6f97d@lwfinger.net>
Date: Mon, 7 Nov 2016 09:26:37 -0600
MIME-Version: 1.0
In-Reply-To: <13471233.iqSeGS5aQ3@np-p-burton>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2016 03:18 AM, Paul Burton wrote:
> On Monday, 7 November 2016 19:27:32 GMT Michael Ellerman wrote:
>> Paul Burton <paul.burton@imgtec.com> writes:
>>> If a device tree specified a preferred device for kernel console output
>>> via the stdout-path or linux,stdout-path chosen node properties there's
>>> no guarantee that it will have specified a device for which we have a
>>> driver. It may also be the case that we do have a driver but it doesn't
>>> call of_console_check() to register as a preferred console (eg. offb
>>> driver as used on powermac systems).
>>>
>>> In these cases try to ensure that we provide some console output by
>>> enabling the first usable registered console, which we keep track of
>>> with the of_fallback_console variable. Affected systems will enable
>>> their console later than they did prior to commit 05fd007e4629
>>> ("console: don't prefer first registered if DT specifies stdout-path")
>>> but should otherwise produce the same output.
>>>
>>> Tested in QEMU with a PowerPC pseries_defconfig kernel.
>>
>> Hi Paul,
>>
>> This does "work", as in it boots and I get a console. But the delay in
>> getting output on the VGA is not workable. I get pretty much no output
>> until the machine is booted entirely to userspace, meaning any crash
>> prior to that will be undebuggable.
>>
>> I also note Andreas reports it doesn't work at all on PowerMac.
>>
>> Please send a revert and we can try again next cycle.
>>
>> cheers
>
> Hi Michael,
>
> A revert was already submitted by Hans de Goede & is being discussed over
> here:
>
> https://marc.info/?l=linux-kernel&m=147826151427455&w=2

I am a little surprised that I was not CCd on that thread. To reiterate, my 
PowerBook G4 with a PPC32 processor CRASHES on boot. That is a lot more serious 
than the console output disappearing.

As it seems unlikely that this regression will be fixed in the current cycle, I 
recommend that the reversion of commit 05fd007e4629 until a proper fix is available.

Larry

Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A79D02C021F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:57:34 +1000 (EST)
Received: by qcse14 with SMTP id e14so3715241qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 13:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVMdr4MzH56FLKaQCk5FAfSpEQ9crka93djeMiU3s_FtA@mail.gmail.com>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
 <CAOZdJXVMdr4MzH56FLKaQCk5FAfSpEQ9crka93djeMiU3s_FtA@mail.gmail.com>
Date: Mon, 16 Jul 2012 16:57:31 -0400
Message-ID: <CA+5PVA7WSTK9Ad7yocSrsnFcsp7L1hyzJjKrWkKU7Yak=2ZoZg@mail.gmail.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
From: Josh Boyer <jwboyer@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jiang Lu <lu.jiang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 4:28 PM, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> On Fri, Jul 13, 2012 at 7:25 AM, Josh Boyer <jwboyer@gmail.com> wrote:
>
>> Right now, if the option is not set we call booke_wdt_disable which
>> indeed does not actually _disable_ the WDT, but it does set the timer
>> period to the maxium value.  We could go one step further and implement
>> a simple timer that pops and calls booke_wdt_ping if WATCHDOG_NOWAYOUT
>> is not set, then rearms itself.  That would leave the user with the
>> ability to perform recovery of the userspace process that exited or
>> died and was responsible for pinging the watchdog.
>
> I think the maximum value is still decades or centuries, so there's no
> real reason to complicate the code.

I have no idea about FSL cores, but the 4xx maximum value selects TBU
bit 31.  When that bit flips is going to be determined by the speed of
the clock driving TB.  Most of the 4xx implementations I have seen use
the CPU clock, so to take the example from the 44x user manuals, a 400
MHz clock results in a maximum time period of ~21 seconds.  Multiply
by 3 to get the time before the WDT actually does a reset and you're
at about 1min.

> The NOWAYOUT feature is working as designed, so I don't understand the
> need for this patch.

NOWAYOUT is working.  The patch was basically forcing it on, even if
the end user doesn't want the behavior described.  From what you've
said, that simply doesn't matter in the FSL case because the machine
will run for a really long time.  On 4xx, something needs to be done
to keep the machine running if the user doesn't want the NOWAYOUT
behavior, which is why I suggested a kernel timer.

josh

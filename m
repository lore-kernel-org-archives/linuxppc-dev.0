Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE8F71A0423
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 00:47:31 +1000 (EST)
Message-ID: <542C13FB.80608@suse.de>
Date: Wed, 01 Oct 2014 16:47:23 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
 <CAMuHMdWEN+q+s6ENoqqD8d0hy=hcZSiWzW3poJFBs8uEBGVuGg@mail.gmail.com>
In-Reply-To: <CAMuHMdWEN+q+s6ENoqqD8d0hy=hcZSiWzW3poJFBs8uEBGVuGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01.10.14 16:33, Geert Uytterhoeven wrote:
> Hi Alex,
> 
> On Wed, Oct 1, 2014 at 3:27 PM, Alexander Graf <agraf@suse.de> wrote:
>> The generic Linux framework to power off the machine is a function pointer
>> called pm_power_off. The trick about this pointer is that device drivers can
>> potentially implement it rather than board files.
>>
>> Today on PowerPC we set pm_power_off to invoke our generic full machine power
>> off logic which then calls ppc_md.power_off to invoke machine specific power
>> off.
>>
>> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
>> this card house falls apart. That driver only registers itself if pm_power_off
>> is NULL to ensure it doesn't override board specific logic. However, since we
>> always set pm_power_off to the generic power off logic (which will just not
>> power off the machine if no ppc_md.power_off call is implemented), we can't
>> implement power off via the generic GPIO power off driver.
>>
>> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
>> pm_power_off as was intended. Then individual drivers such as the GPIO power off
>> driver can implement power off logic via that function pointer.
>>
>> With this patch set applied and a few patches on top of QEMU that implement a
>> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
>> machine after halt.
> 
> This is touching the same area as last night's
> "[RFC PATCH 00/16] kernel: Add support for poweroff handler call chain"
> https://lkml.org/lkml/2014/9/30/575

I agree, and I think your patch set is walking into a reasonable
direction. However, I really think it should convert all users of
pm_power_off - at which point you'll probably get to the same conclusion
that ppc_md.power_off is a bad idea :).

So in a way, this patch set is semantically a prerequisite to the full
conversion you'd probably like to do :).

Also, in your cover letter you describe that some methods power off the
CPU power while others power off the system power. How do you
distinguish between them with a call chain? You probably won't get
around to trigger the system power off callback after the CPU power off
callback ran ;).


Alex

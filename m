Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 62668DE038
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 14:44:07 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so98843anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 21:44:06 -0700 (PDT)
Message-ID: <fa686aa40805222144i7026cf57r3382635853140c83@mail.gmail.com>
Date: Thu, 22 May 2008 22:44:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add the PC speaker only when requested so
In-Reply-To: <41365E63-56F5-4057-9F4A-BE986969466C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211496016-30311-1-git-send-email-Emilian.Medve@Freescale.com>
	<fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
	<41365E63-56F5-4057-9F4A-BE986969466C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 9:34 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On May 22, 2008, at 6:27 PM, Grant Likely wrote:
>
>> On Thu, May 22, 2008 at 4:40 PM, Emil Medve <Emilian.Medve@freescale.com>
>> wrote:
>>>
>>> This will cause this minor boot-time debugging error message to go away:
>>>
>>> [    1.316451] calling  add_pcspkr+0x0/0x84
>>> [    1.316478] initcall add_pcspkr+0x0/0x84 returned -19 after 0 msecs
>>
>> What situation are you hitting this in?  The code should only run if
>> there is a "pnpPNP,100" compatible node in the device tree.
>
> The code always runs, the -19 is from the fact that the code returns -ENODEV
> when it doesn't find the device in the tree.
>
> I don't see any reason we should be ALWAYS be probing for a PC speaker.
>  Seems like a reasonable patch.

Fair enough; I was just wondering if it was a complete fix.  But now
that I dig into the code I see that the calling...initcall returned...
messages are just debug stuff that isn't always turned on.

I have no problem with the patch.

>
>> Also, where is CONFIG_PCSPKR_PLATFORM defined?  I don't see it
>> anywhere in powerpc code and only a reference to it in an x86
>> Makefile.  As it stands, it looks like this patch unconditionally
>> disables the pcspkr code.
>
> Its defined in init/Kconfig.

Apparently my grep-foo isn't what it used to be...

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

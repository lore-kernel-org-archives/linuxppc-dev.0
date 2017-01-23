Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6gz7599pzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 06:16:35 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>, rtd@a-eon.com,
 aperez@alexperez.com, Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Mon, 23 Jan 2017 19:15:25 +0000 (GMT)
Message-ID: <497a17344e3.4cea1c9d@auth.smtp.1and1.co.uk>
In-Reply-To: <87h94qb8u2.fsf@concordia.ellerman.id.au>
References: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
 <87h94qb8u2.fsf@concordia.ellerman.id.au>
Subject: Re: powerpc/pasemi/nemo: Fix low memory values for boot.
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael

On 23/01/2017, Michael Ellerman wrote:
>> Clearing the long long at addr 8 has been shown to fix this, so
>> add an initalisation to head_64.S so the system will boot.
>
> I'd really prefer it if someone could tell me why we need to clear it.
> But I assume no one knows?

The problem was found by Christian, and the fix comes courtesy of Olof
Johansson, I've not looked into it before.

> I don't want to pollute this code with NEMO workarounds if we can avoid
> it.

To be honest, so would I.

> You said the hang happens after printing the initial memory map, I'm not
> quite sure where you mean, but it sounds like that will be late enough
> that we can do the clear in pasemi platform code?

During prom_init. Where it says 'Memory layout at Init'

I took a long look today and traced the problem the 'prom_find_boot_cpu' and a
much better patch will follow.

Regards
Darren

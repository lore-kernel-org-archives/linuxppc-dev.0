Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 42699DF270
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:17:48 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so73131ywj.39
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 08:17:25 -0700 (PDT)
Message-ID: <48076A00.1080608@genesi-usa.com>
Date: Thu, 17 Apr 2008 16:17:20 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
References: <1208105558.3026.137.camel@pmac.infradead.org>	
	<4807427B.3030902@genesi-usa.com>
	<1208443057.9212.250.camel@pmac.infradead.org>
In-Reply-To: <1208443057.9212.250.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


David Woodhouse wrote:
> On Thu, 2008-04-17 at 13:28 +0100, Matt Sealey wrote:
>> I thought we were using efika.forth for this in Fedora.
> 
> We were, until you pointed out that the kernel actually works just fine
> these days without it.

I said the kernel has had braindead patches shoved into it that sort of
obviate the need for the most heinous of crimes committed in the Efika
device tree.

The Linux kernel fixups don't add the CDM or XLB arbiter or many other
components some out-of-mainline drivers will need (and should be able
to just access without writing a fixup first) to map to work properly.
Adding these will clean up things like the UART module, Sylvain's sleep
patches will work on Efika, etc.

> can't set environment variables from within Linux (and yes, we can
> probably improve on that too, but we let them setenv for themselves, for
> now).

You really won't be improving on it because there's no reliable way to
pass setenv back to the firmware from userland :D

> That might be a little cleaner than what we have at the moment, yes. But
> what we have also works, so I'd rather concentrate on things like
> getting audio support merged, before we faff around with what are
> essentially cosmetics.

My ideal situation is all this stuff is stripped from the kernel. You do
realise 90% of the Efika traffic on this list is submitting code that
fixes fixups for a firmware which has a seperated fixup script, putting
the responsibility firmly where Linux-PPC policy dictated it should be
(with the firmware).

I think it's stunting the development of the platform. In lieu of a
real, solid, flashable firmware update that fixes the problems, I don't
think patching the Linux kernel is the correct solution, and I do not
appreciate the 180 degree turn that Linux-PPC policy has taken with this.
If we could not commit fixes for it in the beginning and were lambasted
for shoving firmware bugfixes into the kernel, how should it be so
different now?

You do realise that once the fixes are in the kernel *you may never see
another firmware update*? There'll be no point..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

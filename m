Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A0B6B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 20:20:41 +1100 (EST)
Subject: Re: High load average (~2.0) on an idle PowerPC 64 machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <AANLkTikbd0S6MGK4p7=_0q8c6nbk=k1TmLcM+Mc52=FW@mail.gmail.com>
References: <AANLkTikbd0S6MGK4p7=_0q8c6nbk=k1TmLcM+Mc52=FW@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 20:20:33 +1100
Message-ID: <1301044833.2402.482.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-24 at 21:23 +0100, Romain Goyet wrote:
> I there,
> 
>  I've this Quad G5 machine that's sitting pretty much idle with the
> latest Debian stable installed, and yet it's got an abnormaly high
> load average.
> I've detailed the situation over here, maybe you guys will find it
> interesting or have something to say :
> http://serverfault.com/questions/251299/high-load-average-over-2-0-on-an-idle-machine
> 
> The machine doesn't seem to be actually slowed down, it looks more
> like an incorrect measurement.
> 
> Thank you very much for any help !

>From memory, this can be due to the thermal control driver's kernel
thread, which essentially does uninterruptible sleeps all the time,
either when waiting for request completion from SMU or i2c.

Since it's pretty much constantly talking to these, it causes an
increase load (they can take time to respond). So in effect it's not
actually hogging the CPU.

I don't know if there's a clean way to fix that.

Now it's possible that there's a different cause, that's just talking
from some vague memories, so some investigations would be useful
regardless.

Cheers,
Ben.

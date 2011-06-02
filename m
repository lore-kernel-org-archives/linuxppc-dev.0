Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id B8790B6FA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 16:16:59 +1000 (EST)
Date: Wed, 1 Jun 2011 23:16:55 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <BANLkTi=JRDrzn=-d8jVqZLPGtV1osa1eiw@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1106012310580.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
	<BANLkTi=JRDrzn=-d8jVqZLPGtV1osa1eiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jun 2011 at 08:07, Rafał Miłecki wrote:
> 1) You didn't see (like Andres):
> Machine check in kernel mode.
>  Caused by (from SRR1=149030): Transfer error ack signal
>  Oops: Machine check, sig: 7 [#1]
> But, OK, maybe machine check requires something additional in kernel,
> I don't know...
> 
> 2) You didn't see SSB messages
> This is confusing. You should see SSB messages that appear before my
> invalid read happens. Did you somehow disable most of the important
> logs, or sth? Having ssb messages and the end of hung boot would
> directly point you to ssb module.

BenH advised to boot with udbg-immortal and out came:

 http://nerdbynature.de/bits/3.0-rc1/linux-3.0_powerpc_2.jpg
 http://nerdbynature.de/bits/3.0-rc1/linux-3.0_powerpc_2.mp4
 (watch it at very slow speed, as it's only 3sec long)

I've enabled[0] FB_NVIDIA and during normal booting the screen flickers 
after the "... : fixmap" message and the screen clears and is filled again 
from the top - maybe the messages would've been there if booted w/o the 
framebuffer enabled.

Right now I'm happy that Ben's fix helped to get past this message, but 
the system remains unsuable[1] with the latest -git, but more debugging 
has to wait until tomorrow...

Thanks,
Christian.

[0] http://nerdbynature.de/bits/3.0-rc1/config-2.6.39.txt
[1] https://lkml.org/lkml/2011/6/2/6
-- 
BOFH excuse #230:

Lusers learning curve appears to be fractal

Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9619067B82
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 20:45:16 +1000 (EST)
Date: Thu, 30 Jun 2005 12:15:22 +0200 (MEST)
Message-Id: <200506301015.j5UAFMOn023481@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, johnstul@us.ibm.com,
	linux-kernel@vger.kernel.org, paulus@samba.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] ppc misusing NTP's time_offset value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2005 15:05:51 -0700, john stultz wrote:
>	As part of my timeofday rework, I've been looking at the NTP code and I
>noticed that the PPC architecture is apparently misusing the NTP's
>time_offset (it is a terrible name!) value as some form of timezone
>offset. This could cause problems when time_offset changed by the NTP
>code.
>	
>	This patch changes the PPC code so it uses a more clear local variable:
>timezone_offset.
>
>Could a PPC maintainer verify this is correct?
>
>Let me know if you have any comments or feedback.

arch/ppc/kernel/time.c used to have a 'static long time_offset;'
variable. Ulthough unrelated, this declaration clashed with the
one for kernel/time.c, causing compile-time errors with gcc4.
I submitted a fix for this in February, which renamed ppc's local
variable, and it was ACKed by Tom Rini and queued for 2.6.12.

However, the patch that actually went into 2.6.12 was different:
it just removed ppc's local variable, making arch/ppc/kernel/time.c
now share kernel/time.c's variable. At the time I assumed someone
had proved that the two modules _should_ share state, so I didn't
make a fuss about it.

Your patch brings the semantics back to what it was prior to 2.6.12.

/Mikael

Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FDFC1A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 01:33:30 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [git pull] Please pull mpe/linux.git powerpc-3.19-2 tag
References: <1418980604.30631.1.camel@ellerman.id.au>
Date: Mon, 22 Dec 2014 15:33:16 +0100
In-Reply-To: <1418980604.30631.1.camel@ellerman.id.au> (Michael Ellerman's
 message of "Fri, 19 Dec 2014 20:16:44 +1100")
Message-ID: <87r3vrbvpv.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Anton Blanchard (1):
>       powerpc: Secondary CPUs must set cpu_callin_map after setting active and online

This breaks booting on the PowerMac7,3.  It takes forever to boot to
user space (~5 minutes instead of ~4 seconds), and then I see these
processes in top:

   37 root      20   0       0      0      0 D 0.000 0.000   0:00.00 kwindfarm
   10 root      rt   0       0      0      0 R 0.000 0.000   0:00.00 migration/1
   11 root      20   0       0      0      0 R 0.000 0.000   0:00.00 ksoftirqd/1

(The latter two processes don't accumulate any cpu time, but they are
constantly in run state.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

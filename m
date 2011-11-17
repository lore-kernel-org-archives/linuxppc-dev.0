Return-Path: <robert.richter@amd.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 981C6B724F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 10:20:36 +1100 (EST)
Date: Fri, 18 Nov 2011 00:20:27 +0100
From: Robert Richter <robert.richter@amd.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: oprofile callgraph support missing for common cpus
Message-ID: <20111117232027.GW15738@erda.amd.com>
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
 <4EC544C6.3050502@us.ibm.com>
 <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>
 <OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
 oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.11.11 22:27:46, Joakim Tjernlund wrote:
> > >> For my e300c2 cpu both if's are false and I don't get support for callgraph/backtrace
> > >> support. Moving the ops->backtrace = op_powerpc_backtrace; to the top
> > >> enables backtrace for me.

> It sure seems to work :)

Backtrace support also works in timer mode. This is already
implemented on arm and sh (out of my mind, have to look at the code to
be sure). This works if the architectural initialization code sets up
ops->backtrace even on failure, which is exactly what you proposed.

> Question, what is the sample rate for timer based oprofile?
> Is it HZ depended?

Yes, it uses the high resolution timer and sets it to HZ which is 4ms
on most architectures. (I did some measurements and for some reason I
got 8ms on x86 though it should be 4ms, but didn't debug this yet.)

Unless there are volunteers I will queue up a patch for v3.3 to enable
backtrace support in timer mode.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7BCBBB7D67
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Mar 2010 22:51:42 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 2.6.34-rc1: Badness at fs/proc/generic.c:316
References: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
	<20100314065526.GA5353@x200>
	<alpine.DEB.2.01.1003140336280.5493@bogon.housecafe.de>
	<20100314112428.GA4142@x200>
	<alpine.DEB.2.01.1003140431040.5493@bogon.housecafe.de>
Date: Sun, 14 Mar 2010 12:51:38 +0100
In-Reply-To: <alpine.DEB.2.01.1003140431040.5493@bogon.housecafe.de>
	(Christian Kujau's message of "Sun, 14 Mar 2010 04:46:07 -0700 (PDT)")
Message-ID: <m2tysjw27p.fsf@whitebox.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Alexey Dobriyan <adobriyan@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau <lists@nerdbynature.de> writes:

> On Sun, 14 Mar 2010 at 13:24, Alexey Dobriyan wrote:
>> Post "find /proc/device-tree" output.
>
> I did upload[0] a tarball of /proc/device-tree, please see below the 
> "find" output.
>
> Indeed, there's a /cpus/PowerPC,G4@0/l2-cache and 
> /cpus/PowerPC,G4@0/l2-cache#1 in the device-tree. However, from looking at 
> the logfiles, the
>
>    device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"

That's a red herring, the real problem is this:

name 'pulses/rev'

Of course, this name cannot be found in /proc/device-tree, because it
wasn't created.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCpfq6ZHtzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:35:15 +1100 (AEDT)
Message-ID: <1485920088.2953.15.camel@kernel.crashing.org>
Subject: Re: Timekeeping oddities on MacMini G4s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Blemings <hugh@blemings.org>, linuxppc-dev@ozlabs.org
Cc: devel@ntpsec.org, Hal Murray <hmurray@megapathdsl.net>, Paul Mackerras
 <paulus@ozlabs.org>, Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 01 Feb 2017 14:34:48 +1100
In-Reply-To: <fa5edfe0-66fb-6f82-c3b3-67fdf0a09c8c@blemings.org>
References: <fa5edfe0-66fb-6f82-c3b3-67fdf0a09c8c@blemings.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 14:10 +1100, Hugh Blemings wrote:
> Hi,
> 
> I've recently been lurking on the ntpsec project mailing list.
> 
> One of the developers (Hal Murray, CCd) has been doing some tests of the 
> codebase using FreeBSD and Debian on a G4 based Mac Mini - this largely 
> motivated by checking all is well on a big-endian system.
> 
> Hal has identified what appears to be a systemic inaccuracy in kernel 
> timekeeping of around 2500ppm on both Linux and FreeBSD and on several 
> different MacMini G4s (1.42GHz and 1.5GHz variants)
> 
> That it appears on both Linux and FreeBSD kernels and some other data 
> points leads us to wonder if the CPU frequency reported by Open Firmware 
> being different to the actual raw clock is the root cause, but I/we 
> speculate at this point.

Right, we just use the value provided by Open Firmware. Any chance you
can try with MacOS X ?

>From the value in the properties you showed me (and the ones I have in
some DT snapshots) it looks like the value isn't fixed but somewhat
calibrated by Open Firmware during boot.

It could be that this calibration sucks. MacOS X seems to do its own
calibration at boot time based on the KeyLargo timer. It would be useful
to see if their stuff is more precise, we could write something similar
for Linux and BSD.

Cheers,
Ben.

 

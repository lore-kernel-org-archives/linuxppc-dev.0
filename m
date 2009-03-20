Return-Path: <posco.grubb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id D2691DDDA1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 00:27:10 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so565017waf.9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 06:27:09 -0700 (PDT)
Date: Fri, 20 Mar 2009 22:27:05 +0900
From: TOMARI Hisanobu <posco.grubb@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Fwd: Re: IDE cable detection on Apple PowerBook]
Message-Id: <20090320222705.1974aaeb.posco.grubb@gmail.com>
In-Reply-To: <200903201240.30383.bzolnier@gmail.com>
References: <1237530407.25062.569.camel@pasglop>
	<200903201240.30383.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Mar 2009 12:40:29 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Moreover the underlying issue is non-PMAC specific and asks for generic
> resolution, please see:
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=12734#c13
> 
> for previous discussion.
> 
> In the very least case it should be a generic kernel parameter, i.e.
> "ide_core.ignore_cables" and iff the current "ide_core.ignore_cable="
> is not enough.  TOMARI, could please look into it?
> 
> Thanks,
> Bart

It works!
As the internal IDE controller is detected as ide0, I passed
"ide_core.ignore_cable=0" to the kernel, and the drive works in
UDMA/100 mode.
This method seems much cleaner way to solve the problem.
Thank you, Bart, Ben and Anton.

% dmesg |grep hda
Kernel command line: root=/dev/hda4 ro ide_core.ignore_cable=0 
hda: CORE_PATA, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hda: max request size: 512KiB
hda: 252411904 sectors (129234 MB), CHS=16383/255/63
hda: cache flushes supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7
XFS mounting filesystem hda4
Ending clean XFS mount for filesystem: hda4
Adding 846672k swap on /dev/hda5.  Priority:-1 extents:1 across:846672k

-- 
TOMARI Hisanobu <posco.grubb@gmail.com>

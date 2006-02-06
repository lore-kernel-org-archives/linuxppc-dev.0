Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id EC13968926
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Feb 2006 20:02:58 +1100 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id CDF77A403A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Feb 2006 09:41:08 +0100 (CET)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Floating point math in kernel interrupt -- am I doing this right?
Date: Mon, 6 Feb 2006 09:41:07 +0100
References: <200602051140.51759.jaf@lcsaudio.com>
In-Reply-To: <200602051140.51759.jaf@lcsaudio.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602060941.07567.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On s=F6ndag 05 februari 2006 20.40, Jeremy Friesner wrote:
> If I disable the saving and restoring of the FPU registers=20
> entirely, they don't seem to occur at all (at least within the bounds of =
my
> testing so far -- 15+ hours).
Is this with full mix?

Then I would really suspect the save/restore code.
Saving and restoring floating point state can be very tricky.
Do try to find an example in the manual (or possibly in the kernel itself -=
=20
context switch code)

Until this works reliably there is no point in looking for other error=20
sources.  You could also try to add code inside the save-resore that destro=
ys=20
all of the floating point registers to be able to spot errors.

/RogerL

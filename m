Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4A9ACB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 23:55:42 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PowerPC: const intspec pointers
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912151159.40628.roman.fietze@telemotive.de>
	<fa686aa40912151150o64f97533h1b736b4445301192@mail.gmail.com>
In-Reply-To: <fa686aa40912151150o64f97533h1b736b4445301192@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200912171355.34694.roman.fietze@telemotive.de>
Date: Thu, 17 Dec 2009 13:55:34 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

On Tuesday 15 December 2009 20:50:05 Grant Likely wrote:

> Yes, I'm using the driver in a couple of projects.  It works for me
> for both RX and TX (although TX+DMA has been troublesome).

That's what I found out.

> The test driver on the other hand is pretty poor code.  Don't expect
> much from it other than some hints.  There's a reason I didn't merge
> that chunk.

I brought it up to speed before using it.

> Yes, please post the patches and cc: me. I'll review, test, and make
> comments.

I hope it's ok that I've copied them to my web space instead of
providing patches in a mail. The URL is:

  http://www.fietze-home.de/telemotive/linux-2.6-telemotive-mpc.git

Branches:

  benh-next-lpbfifo
    the modified version of the LocalPlus platform driver

  benh-next-localplus-test
    your old test driver, now using the platform driver


Both branches are on top of the benh next branch.


I could only test the driver using fifo and bcom mode in read mode,
using your old test driver, because I currently do not yet have a
target with a writeable device on the LocalPlus. The test ran fine
using different transer sizes starting at 4 up to 128KiB.

I will now port our FPGA driver to use the platform driver, which can
deliver a very high load, and supports writing.

The biggest problem using DMA is the unpredictable order of arrival of
the two interrupts. They both depend on the appropriate load of the
system generating them. In the case of the BestComm a parallel load on
e.g. FEC or ATA can delay the bcom gen bd interrupt until it's task
gets scheduled again, which can take "some time" due its low BestComm
prio of 2. The second problem was, that the original driver does not
use the flush bit to avoid stale RX data.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

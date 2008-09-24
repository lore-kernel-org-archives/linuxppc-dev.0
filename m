Return-Path: <dan.j.williams@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id C530FDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 02:58:03 +1000 (EST)
Received: by gxk14 with SMTP id 14so5732986gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 09:58:02 -0700 (PDT)
Message-ID: <e9c3a7c20809240958i3ed4b7fbv3c13b6bbc31ac6ee@mail.gmail.com>
Date: Wed, 24 Sep 2008 09:58:02 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] fsldma: remove internal self-test from Freescale Elo DMA
	driver
In-Reply-To: <1222201756-21374-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222201756-21374-1-git-send-email-timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, leoli@freescale.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 1:29 PM, Timur Tabi <timur@freescale.com> wrote:
> The Freescale Elo DMA driver runs an internal self-test before registering
> the channels with the DMA engine.  This self-test has a fundemental flaw in
> that it calls the DMA engine's callback functions directly before the
> registration.  However, the registration initializes some variables that the
> callback functions uses, namely the device struct.
>
> The code works today because there are two device structs: the one created
> by the DMA engine, and one created by the Open Firmware (OF) subsystem.  The
> self-test currently uses the device struct created by OF.  However, in the
> future, some of the device structs created by OF will be eliminated.
> This means that the self-test will only have access to the device struct
> created by the DMA engine.  But this device struct isn't initialized when
> the self-test runs, and this causes a kernel panic.
>
> Since there is already a DMA test module (dmatest), the internal self-test
> code is not useful anyway.  It is extremely unlikely that the test will fail
> in normal usage.  It may have been helpful during development, but not any more.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch is for 2.6.28.

Applied to the 'next' [1] branch.

Thanks,
Dan

[1] http://git.kernel.org/?p=linux/kernel/git/djbw/async_tx.git;a=shortlog;h=next

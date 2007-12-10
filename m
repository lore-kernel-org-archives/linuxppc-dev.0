Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 4F330DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 03:12:22 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3679949wag
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:12:20 -0800 (PST)
Message-ID: <9e4733910712100812s8970691x4d2f038ecc5f925c@mail.gmail.com>
Date: Mon, 10 Dec 2007 11:12:20 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-Reply-To: <1E5FF6FC-E905-4FAF-84ED-A96B0E0ACCA8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071209233648.2327.14584.stgit@terra.home>
	<20071209233654.2327.18925.stgit@terra.home>
	<1E5FF6FC-E905-4FAF-84ED-A96B0E0ACCA8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Dec 9, 2007, at 5:36 PM, Jon Smirl wrote:
>
> > Convert MPC i2c driver from being a platform_driver to an open
> > firmware version. Error returns were improved. Routine names were
> > changed from fsl_ to mpc_ to make them match the file name.
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > ---
> >
> > arch/powerpc/sysdev/fsl_soc.c |   96 ---------------------
> > drivers/i2c/busses/i2c-mpc.c  |  190 +++++++++++++++++++++++++++
> > +-------------
> > 2 files changed, 129 insertions(+), 157 deletions(-)
>
> this patch breaks arch/ppc users which are platform_driver based and
> I'm guessing a number of arch/powerpc users which don't
> of_platform_bus_probe().

We should just make two copies of the driver. All of this is needed to
allow automatic loading of the correct i2c modules as dictated by the
device tree. I'm working on the same support for automatically loading
audio codec drivers.

> Also, you should split out the conversion and error fixing into
> separate patches.

I can spin another revision to move those nine lines adding missing
error returns to another patch.

>
> - k
>


-- 
Jon Smirl
jonsmirl@gmail.com

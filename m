Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E6F6B6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 23:01:51 +1000 (EST)
Received: by fxm5 with SMTP id 5so3007565fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 06:01:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305863541.7481.132.camel@pasglop>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-6-git-send-email-ericvh@gmail.com>
	<1305851941.7481.92.camel@pasglop>
	<BANLkTinAqeu7C+U_HFrOAOctFTuSUwG-iA@mail.gmail.com>
	<1305856442.7481.120.camel@pasglop> <4DD5E218.5030508@mcs.anl.gov>
	<1305863541.7481.132.camel@pasglop>
Date: Fri, 20 May 2011 08:01:47 -0500
Message-ID: <BANLkTikG9mfzXM0WmWxPLhjGD-M6AVznkw@mail.gmail.com>
Subject: Re: [bg-linux] [PATCH 6/7] [RFC] enable early TLBs for BG/P
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kazutomo Yoshii <kazutomo@mcs.anl.gov>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 10:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> Unfortunately, the firmware is also required:
>> - to configure Blue Gene Interrupt Controller(BIC)
>> - to configure Torus DMA unit. e.g. fifo
>> - to configure global interrupt (even we don't use, we need to disable
>> some channel correctly)
>
> Can't we just write bare metal code for that ?
>

The kittyhawk code has the bare-metal equivalents for all of these.
When I get to the drivers, I'll favor the kittyhawk versions for
submission and then we'll see if it would be possible to adapt the HPC
extensions to use the bare-metal versions of the drivers versus the
firmware interface.

>> - to access node personality information (node id, DDR size, HZ, etc) or
>> maybe we can directly access SRAM?
>
> That should be turned into device-tree at boot, possibly from a
> bootloader or from the zImage wrapper.
>

This is the approach is used by the kittyhawk u-boot approach.
However, it would also be just as easy to construct an in-memory
device-tree within Linux by mapping the personality page and copying
the relevant bits out.  This has the advantage of being able to boot
Linux directly on the nodes without an intermediary boot loader (which
kittyhawk uses just to allow us customize which kernel boots on a
node-to-node basis whereas the stock system boots the same kernel on
all the nodes within a partition allocation (64-40,000 nodes)).

         -eric

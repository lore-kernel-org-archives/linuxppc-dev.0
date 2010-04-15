Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A175BB7C48
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 17:44:22 +1000 (EST)
Date: Thu, 15 Apr 2010 09:44:13 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
Message-ID: <20100415094413.4d752de0@wker>
In-Reply-To: <4BC682DC.1050200@billgatliff.com>
References: <4BC682DC.1050200@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Apr 2010 22:07:08 -0500
Bill Gatliff <bgat@billgatliff.com> wrote:

> Put simply, I have an MPC5200b platform with a Fujitsu "Lime" GDC, and
> I'm trying to run Debian squeeze's xorg on it.
> 
> Actually, I *have* Debian squeeze's xorg running on the platform just
> fine, with a 2.6.34-rc1 kernel (kernel.org).  Problem is, every single
> diagonal line is very blocky--- not smooth at all.  I used to think this
> was a problem with X's fonts, but now I don't think so because the mouse
> cursor's diagonal lines also look equally bad.
> 
> It's almost as if any time the platform tries to draw a diagonal line,
> truncation/rounding errors are causing it problems in figuring out which
> pixels to turn on and off.

On all PowerPC based boards with Lime (PPC440EPx, MPC85xx) I have seen so
far there is a similar problem with direct access to the frame buffer in
16-bit mode.

> A non-Linux kernel on this hardware, running a non-X GUI, seems to work
> fine so I think the hardware isn't the problem.

It is possible that this non-X GUI doesn't access the frame buffer directly
but only uses the accelerated driver for rendering. In this case all
drawing is done by Lime itself triggered by 32-bit accesses to the
drawing command FIFO.

> Anyone have any suggestions on where to start with this one?  Anyone
> else running a similar configuration with any success?  I'm completely
> lost, and running out of hair *fast*...

You probably have to fix Xorg driver for swapping.

Anatolij

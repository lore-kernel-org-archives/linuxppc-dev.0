Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <411369F9.5060506@rossvideo.com>
Date: Fri, 06 Aug 2004 07:22:33 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs
References: <20040806081151.B77FCC109F@atlas.denx.de>
In-Reply-To: <20040806081151.B77FCC109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> Looks as if your init is crashing.
>
> Try running a (statically linked)  shell  instead  (by  passing  some
> init=/bin/sh" option on the boot command line).

This could also be a floating point issue.  Most code compiled against
libc will try to "reset" the floating point state upon startup.  This
will cause a fault if you do not have a kernel floating point emulator
of some sort loaded to handle it.  (Even though init doesn't use any
floating point itself).  So as a quick test try building your kernel
with CONFIG_MATH_EMULATION=y

-R

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

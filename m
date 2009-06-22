Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20547B718F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 18:51:43 +1000 (EST)
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17B5EDDDA1
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 18:51:40 +1000 (EST)
Date: Mon, 22 Jun 2009 09:52:45 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: michael@ellerman.id.au
Subject: Re: Badness at drivers/char/tty_ldisc.c:210 during shutdown
Message-ID: <20090622095245.38edafdd@lxorguk.ukuu.org.uk>
In-Reply-To: <1245655421.4400.78.camel@concordia>
References: <4A3A2D2B.7070704@in.ibm.com> <4A3F281F.9000408@in.ibm.com>
	<1245655421.4400.78.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > [c00000003cf6ba70] [c00000000040a3d0] .tty_ldisc_put+0xa4/0xf4 (unreliable)
> > [c00000003cf6bb10] [c00000000040a7c8] .tty_ldisc_reinit+0x38/0x80
> > [c00000003cf6bba0] [c00000000040b1d8] .tty_ldisc_hangup+0x190/0x260
> > [c00000003cf6bc40] [c000000000401090] .do_tty_hangup+0x188/0x4c0
> > [c00000003cf6bd20] [c000000000401440] .tty_vhangup_self+0x34/0x54
> > [c00000003cf6bdb0] [c00000000019236c] .sys_vhangup+0x38/0x58
> > [c00000003cf6be30] [c000000000008534] syscall_exit+0x0/0x40
> > Instruction dump:
> > 912b0088 4bcd17bd 60000000 e87e8008 7f44d378 481c04fd 60000000 801b0008 
> > 7c09fe70 7d200278 7c004850 54000ffe <0b000000> 7f63db78 4bd7c98d 60000000 
> 
> Ah right, so this has check has just gone in, and the code in question
> has been rewritten somewhat just recently.

The check is to catch any cases where a line discipline is being freed up
but has a refcount that is non zero. I think I know what is going on here.

Alan

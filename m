Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17622.57931.631871.287907@cargo.ozlabs.ibm.com>
Date: Mon, 7 Aug 2006 16:48:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
In-Reply-To: <20060803192629.GD25251@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
	<17616.17129.964122.125259@cargo.ozlabs.ibm.com>
	<20060803192629.GD25251@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> I realize that I didn't really answer your question.  Its at least
> possible that the console driver could not be known at link time.
> 
> An example I used in another email is a platform that has 4 serial
> ports, 2-16550 and 2-mpsc, say.  The /chosen/linux,stdout-path could
> pick any of the four so you would need to compile in a low-level
> serial driver for both and hook the correct one up at runtime.
> 
> Same could be said for a serial vs. video console.

OK, that's reasonable.  Still would be nice not to have to do the
double dereference though.  I think that the platform_ops and the
fw_ops could probably be combined.  Also, an init method for the
platform/fw_ops would be useful - it would let us remove the kludge
you have in the OF malloc implementation.

The OF malloc is currently applying a minimum address constraint for
all platforms, where it used to apply it only for 64-bit platforms.
We need to fix that up somehow too.

Regards,
Paul.

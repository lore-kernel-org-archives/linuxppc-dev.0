Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1108D67BD8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 14:41:22 +1000 (EST)
Date: Fri, 11 Aug 2006 23:37:25 -0500
From: Milton Miller <miltonm@bga.com>
To: benjamin.heyne@uni-dortmund.de, linuxppc-embedded@ozlabs.org,
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
Message-Id: <31155357445643c98694.1714636915.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon Aug  7 2006 04:46:43 AM CDT, Benjamin Heyne wrote:
> Peter Korsgaard <jacmet@sunsite.dk> wrote as thus:
> > >>>>> "David" == David H Lynch <dhlii@dlasys.net> 
> > David>     Have you tried 2.6.18.x to see if your stuff works with it
> > David> ?
> > 
> > Yes, 2.6.18-rc3 + my zlib fix
> > (http://thread.gmane.org/gmane.linux.kernel/428436) or -rc4 once it
> > hits kernel.org works fine on my v2p-based board.
> 
> Well, unfortunately I am still getting the inflate error
> as soon as the image grows >2MB (about). Have you tried with
> images of this size? If the image is smaller, everything works
> fine...

My first reaction when I saw this thread was that you didn't allocate 
something in memory and overlapped something.  However, looking
at your original post again, I think your kernel is growing larger than
4MB, which is the link address of the zImage.  This is based on the 
kernel is decompressed to address 0 in
ppc/boot/simple/misc-embedded.c, and a 50% compression factor 
and 2MB compressed image.

You can look at the file size of vmlinux to see if this is close.

milton

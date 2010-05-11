Return-Path: <dhbaird@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 67528B7DA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 08:48:50 +1000 (EST)
Received: by pvg6 with SMTP id 6so91999pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 15:48:48 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 11 May 2010 16:48:48 -0600
Message-ID: <AANLkTimk9eVTBPOSxCaGh12cC7x14bVDpGTQAhaYNGqj@mail.gmail.com>
Subject: Problem setting link_address too high on PowerPC 40x
From: David Baird <dhbaird@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am working with the PowerPC 405 in the Virtex-II Pro FPGA.  I've
come across a possible problem where the device tree is located in at
an address that the kernel cannot access if link_address (the location
where zImage executes from, set in the "wrapper" script) is set too
high (somewhere in the ballpark of 16 MB).  Here is a summary of the
problem:

In arch/powerpc/boot/main.c, ft_addr (a pointer to the flat? device
tree) is computed and then passed on to "kentry" to the kernel startup
code.  At startup, the kernel only has access via the TLB to the first
16 MB of memory which is initialized by "initial_imu" in
arch/powerpc/kernel/head_40x.S.  The problem is that ft_addr is
located relative to link_address / zImage, but this address might be
outside of the bounds of the 16MB initially mapped by the TLB.

A symptom of this problem is that the kernel ceases to print any
messages to the console because it could not read information about
the console from the flat device tree.  The last thing the user will
see is this:

zImage starting: loaded at 0x04000000 (sp: 0x0430beb0)
Allocating 0x6f11b0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0400c000:0x0430a31a)...done 0x657000 bytes

Linux/PowerPC load: console=ttyUL0 root=/dev/ram
Finalizing device tree... flat tree at 0x4318300

...and then the screen goes completely blank...  And it seems that the
kernel also eventually crashes (but I couldn't tell exactly what
happened because __log_buf repeatedly gets corrupted with zeros
whenever I try this particular experiment).

Maybe there is also more to this problem too than just the ft_addr.

-David

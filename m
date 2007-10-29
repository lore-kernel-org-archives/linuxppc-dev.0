Return-Path: <anton@ozlabs.org>
Date: Mon, 29 Oct 2007 09:07:20 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: boot/wrap assumes a biarch toolchain?
Message-ID: <20071029140719.GA17120@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jdittmer@ppp0.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Jan is seeing the following fail:

WRAP    arch/powerpc/boot/zImage.pmac
powerpc-linux-objcopy: vmlinux: File format not recognized

He is using a cross compile toolchain invoked with the following command
line:

# make HOSTCC=gcc-4.0 ARCH=powerpc CROSS_COMPILE=powerpc64-linux- CROSS32_COMPILE=powerpc-linux-

It seems like boot/wrap wants to use both 64bit and 32bit tools, however
it only receives the 32bit path:

ifneq ($(CROSS32_COMPILE),)
CROSSWRAP := -C "$(CROSS32_COMPILE)"
else
ifneq ($(CROSS_COMPILE),)
CROSSWRAP := -C "$(CROSS_COMPILE)"
endif
endif

Thoughts? I guess we have to pass in both cross compile targets.

One way to make this go away would be to build binutils as biarch:

# configure --target=powerpc-linux --enable-targets=powerpc64-linux ...

Anton

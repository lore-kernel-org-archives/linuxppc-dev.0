Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9AA5DDE04
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 08:50:35 +1100 (EST)
Subject: Re: [PATCH 1/2] firewire: endianess fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <47C7F209.9030907@s5r6.in-berlin.de>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
	<200802281342.06493.jwilson@redhat.com>
	<1204241162.15052.393.camel@pasglop>	<47C79CB1.6050104@redhat.com>
	<18375.60394.166769.540668@cargo.ozlabs.ibm.com>
	<47C7F209.9030907@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sat, 01 Mar 2008 08:49:53 +1100
Message-Id: <1204321793.15052.446.camel@pasglop>
Mime-Version: 1.0
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, Jarod Wilson <jwilson@redhat.com>,
	linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The second line looks like this is indeed one of those which needs the 
> header byte-swap workaround which ohci1394 has but firewire-ohci hasn't yet.
> 
> On the weekend I'm going to attempt to put Linux on this PowerBook, at last.

Those machines can netboot, or boot from USB. Might be easier for you.

For that sort of test, usually, I just netboot a zImage with built-in
initrd, using an initrd with all the tools I need on it.

(A way to build that sort of initrd or initramfs is OpenWRT though I use
a home made one).

You can netboot any newworld mac with that OF command:

boot enet:tftp_server_ip,filename

(you need to make sure you have a DHCP around to give it an address).

However, make _SURE_ you use the file arch/powerpc/boot/zImage.pmac (and
not any other zImage).

To build one with an initrd included, put the initrd in
arch/powerpc/boot as "ramdisk.image.gz" and do make zImage.initrd.

That should result in a file name zImage.initrd.pmac that you can
netboot.

Cheers,
Ben.

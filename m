Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpxFL5rvmzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 08:18:46 +1000 (AEST)
Date: Tue, 12 Jul 2016 23:18:05 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160712221804.GV1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160712225805.0d27fe5d@hananiah.suse.cz>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
> I'm not an expert on DTB, so I can't provide an example of code
> execution, but you have already mentioned the /chosen/linux,stdout-path
> property. If an attacker redirects the bootloader to an insecure
> console, they may get access to the system that would otherwise be
> impossible.

I fail to see how kexec connects with the boot loader - the DTB image
that's being talked about is one which is passed from the currently
running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
also ARM64) that's a direct call chain which doesn't involve any
boot loader or firmware, and certainly none that would involve the
passed DTB image.

However, your point is valid as an attacker can redirect the console
and/or mounted root on the to-be-kexec'd kernel if they can modify
the DTB - and there's a whole host of subtle ways to do that, not
necessarily just modification of the kernel command line.

> In general, tampering with the hardware inventory of a machine opens up
> a security hole, and one must be very cautious which modifications are
> allowed. You're giving this power to an (unsigned, hence untrusted)
> userspace application; Eric argues that only the kernel should have
> this power.

Given that, how does crashdump work in this scenario?

crashdump works by adding an elfcorehdr=address argument to the
crash-booted kernel's command line.  If you can add to the kernel
command line, you can redirect the console and do all sorts of
other stuff like specifying a different filesystem to mount, etc.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

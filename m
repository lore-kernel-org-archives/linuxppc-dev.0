Date: Fri, 7 Feb 2003 17:17:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What Does a Linux Image Expect From U-boot?
Message-ID: <20030208001739.GB1336@ip68-0-152-218.tc.ph.cox.net>
References: <DF2B720CF774D21189EE00805FA7FA220517838F@nmrusdunsx3.nielsenmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DF2B720CF774D21189EE00805FA7FA220517838F@nmrusdunsx3.nielsenmedia.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 03:47:11PM -0500, Wells, Charles wrote:

> My strategy has been to put whatever code is necessary at the beginning of
> "linux/arch/ppc/boot/simple/head.S" to make the compressed image think it
> just got control from u-boot.  Since I have the SDRAM setup at location
> 0x00000000 and the FLASH and IMMR are up high out of the way, this seems
> reasonable.

You're headed down the wrong path, arch/ppc/boot/simple and U-Boot (and
PPCBoot of course) are mutlally exclusive.  What you want to do is look
at the embed_config file and define an embed_config function (iirc) to
fill out the bd_t struct with the appropriate values.  Then just 'make
zImage' and, depending on how your firmware works, load the image into
memory w/o the ELF header and jump to where it was loaded.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

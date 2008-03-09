Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D5EB2DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 07:58:20 +1100 (EST)
Date: Sun, 9 Mar 2008 21:58:24 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: Re: Long boot delay with agpgart
Message-ID: <20080309205824.GA3373@localhost>
References: <20080305163320.GA3961@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080305163320.GA3961@localhost>
Cc: debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 05 2008, at 17:33 +0100, Wolfgang Pfeiffer wrote:

> The boot process began being stuck the moment some agpgart init
> routine started:
> 
> Excerpt from kern.log that moment:
> 
> [    6.882357] usbcore: registered new device driver usb
> [   36.732011] uninorth_agp: gave up waiting for init of module agpgart.
> [   36.733009] uninorth_agp: Unknown symbol agp_bridge
> [   66.734008] uninorth_agp: gave up waiting for init of module agpgart.
> [   66.735011] uninorth_agp: Unknown symbol agp_find_bridge
> [   96.736009] uninorth_agp: gave up waiting for init of module agpgart.
> [   96.737010] uninorth_agp: Unknown symbol agp_device_command
> 

With Debian package modutils not being installed I still had in
/etc/modutils/local and in /etc/modules.conf:

pre-install radeon /sbin/modprobe "-k" "agpgart"
pre-install agpgart /sbin/modprobe "-k" "uninorth_agp"

I don't know whether these lines can be confusing for the boot
routines, or whether they're read at all by the system on boot
time. Anyway: 

I removed modules.conf, and commented out everything in
/etc/modutils/local

A first reboot after the change didn't break anything, as it seems
... 

Sorry if it was only noise ...

Best Regards
Wolfgang

-- 
http://heelsbroke.blogspot.com/
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on

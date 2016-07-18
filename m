Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtPQC4mRWzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 23:38:27 +1000 (AEST)
Date: Mon, 18 Jul 2016 09:38:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de, Petr Tesarik <ptesarik@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com,
 linux-arm-kernel@lists.infradead.org, mjg59@srcf.ucam.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160718133824.GC32512@redhat.com>
References: <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com>
 <1468845964.2800.3.camel@gmail.com>
 <20160718132629.GB32512@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160718132629.GB32512@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 18, 2016 at 09:26:29AM -0400, Vivek Goyal wrote:
> On Mon, Jul 18, 2016 at 10:46:04PM +1000, Balbir Singh wrote:
> > On Wed, 2016-07-13 at 14:22 -0400, Vivek Goyal wrote:
> > > On Wed, Jul 13, 2016 at 06:40:10PM +0100, Russell King - ARM Linux wrote:
> > > > 
> > > > On Wed, Jul 13, 2016 at 09:03:38AM -0400, Vivek Goyal wrote:
> > > > > 
> > > > > On Wed, Jul 13, 2016 at 09:26:39AM +0100, Russell King - ARM Linux wrote:
> > > > > > 
> > > > > > Indeed - maybe Eric knows better, but I can't see any situation where
> > > > > > the dtb we load via kexec should ever affect "the bootloader", unless
> > > > > > the "kernel" that's being loaded into kexec is "the bootloader".
> > > > > > 
> > > > > > Now, going back to the more fundamental issue raised in my first reply,
> > > > > > about the kernel command line.
> > > > > > 
> > > > > > On x86, I can see that it _is_ possible for userspace to specify a
> > > > > > command line, and the kernel loading the image provides the command
> > > > > > line to the to-be-kexeced kernel with very little checking.  So, if
> > > > > > your kernel is signed, what stops the "insecure userspace" loading
> > > > > > a signed kernel but giving it an insecure rootfs and/or console?
> > > > > It is not kexec specific. I could do this for regular boot too, right?
> > > > > 
> > > > > Command line options are not signed. I thought idea behind secureboot
> > > > > was to execute only trusted code and command line options don't enforce
> > > > > you to execute unsigned code.
> > > > > 
> > 
> > You can set module.sig_enforce=0 and open up the system a bit assuming
> > that you can get a module to load with another attack
> 
> IIUC, sig_enforce bool_enable_only so it can only be enabled. Default
> value of it is 0 if CONFIG_MODULE_SIG_FORCE=n.
> 
> IOW, if your kernel forced signature verification, you should not be
> able to do sig_enforce=0. If you kernel did not have
> CONFIG_MODULE_SIG_FORCE=y, then sig_enforce should be 0 by default anyway
> and you are not making it worse using command line.

[ CC Matthew Garrett ]

I think on top of this there were patches by Matthew Garrett, which
disallowed loading of unsigned modules if booted with secureboot on. I
think those patches never made upstream though.

Vivek

> 
> > 
> > > > > So it sounds like different class of security problems which you are
> > > > > referring to and not necessarily covered by secureboot or signed
> > > > > kernel.
> > > > Let me give you an example.
> > > > 
> > > > You have a secure boot setup, where the firmware/ROM validates the boot
> > > > loader.  Good, the boot loader hasn't been tampered with.
> > > > 
> > > > You interrupt the boot loader and are able to modify the command line
> > > > for the booted kernel.
> > > > 
> > > > The boot loader loads the kernel and verifies the kernel's signature.
> > > > Good, the kernel hasn't been tampered with.  The kernel starts running.
> > > > 
> > > > You've plugged in a USB drive to the device, and specified a partition
> > > > containing a root filesystem that you control to the kernel.  The
> > > > validated kernel finds the USB drive, and mounts it, and executes
> > > > your own binaries on the USB drive.
> > > You will require physical access to the machine to be able to
> > > insert your usb drive. And IIRC, argument was that if attacker has
> > > physical access to machine, all bets are off anyway.
> > >
> > 
> > You don't need physical access -- your machine controller BMC can
> > do the magic for you. So its not always physical access, is it?
> 
> Well, idea was that if you have physical access to machine, then all
> bets are off. If BMC can do something which allows running unsigned
> code at ring level 0, its a problem I think from secureboot model of
> security.
> 
> >  
> > > > 
> > > > 
> > > > You run a shell on the console.  You now have control of the system,
> > > > and can mount the real rootfs, inspect it, and work out what it does,
> > > > etc.
> > > > 
> > > > At this point, what use was all the validation that the secure boot
> > > > has done?  Absolutely useless.
> > > > 
> > > > If you can change the command line arguments given to the kernel, you
> > > > have no security, no matter how much you verify signatures.  It's
> > > > the illusion of security, nothing more, nothing less.
> > > > 
> > 
> > I agree, if you can change command line arguments, all bets are of lesser value
> 
> If changing command line allows execution of unsigned code at ring level
> 0, then it is a problem. Otherwise we are talking of security issues which
> are not covered by secureboot model.
> 
> Vivek

Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtNF84yZWzDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 22:45:32 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id p64so30293884pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 05:45:32 -0700 (PDT)
Message-ID: <1468845964.2800.3.camel@gmail.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
From: Balbir Singh <bsingharora@gmail.com>
To: Vivek Goyal <vgoyal@redhat.com>, Russell King - ARM Linux
 <linux@armlinux.org.uk>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de,  Petr Tesarik <ptesarik@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 18 Jul 2016 22:46:04 +1000
In-Reply-To: <20160713182247.GA25232@redhat.com>
References: <87furf7ztv.fsf@x220.int.ebiederm.org>
 <50662781.Utjsnse3nb@hactar> <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-13 at 14:22 -0400, Vivek Goyal wrote:
> On Wed, Jul 13, 2016 at 06:40:10PM +0100, Russell King - ARM Linux wrote:
> > 
> > On Wed, Jul 13, 2016 at 09:03:38AM -0400, Vivek Goyal wrote:
> > > 
> > > On Wed, Jul 13, 2016 at 09:26:39AM +0100, Russell King - ARM Linux wrote:
> > > > 
> > > > Indeed - maybe Eric knows better, but I can't see any situation where
> > > > the dtb we load via kexec should ever affect "the bootloader", unless
> > > > the "kernel" that's being loaded into kexec is "the bootloader".
> > > > 
> > > > Now, going back to the more fundamental issue raised in my first reply,
> > > > about the kernel command line.
> > > > 
> > > > On x86, I can see that it _is_ possible for userspace to specify a
> > > > command line, and the kernel loading the image provides the command
> > > > line to the to-be-kexeced kernel with very little checking.  So, if
> > > > your kernel is signed, what stops the "insecure userspace" loading
> > > > a signed kernel but giving it an insecure rootfs and/or console?
> > > It is not kexec specific. I could do this for regular boot too, right?
> > > 
> > > Command line options are not signed. I thought idea behind secureboot
> > > was to execute only trusted code and command line options don't enforce
> > > you to execute unsigned code.
> > > 

You can set module.sig_enforce=0 and open up the system a bit assuming
that you can get a module to load with another attack

> > > So it sounds like different class of security problems which you are
> > > referring to and not necessarily covered by secureboot or signed
> > > kernel.
> > Let me give you an example.
> > 
> > You have a secure boot setup, where the firmware/ROM validates the boot
> > loader.  Good, the boot loader hasn't been tampered with.
> > 
> > You interrupt the boot loader and are able to modify the command line
> > for the booted kernel.
> > 
> > The boot loader loads the kernel and verifies the kernel's signature.
> > Good, the kernel hasn't been tampered with.  The kernel starts running.
> > 
> > You've plugged in a USB drive to the device, and specified a partition
> > containing a root filesystem that you control to the kernel.  The
> > validated kernel finds the USB drive, and mounts it, and executes
> > your own binaries on the USB drive.
> You will require physical access to the machine to be able to
> insert your usb drive. And IIRC, argument was that if attacker has
> physical access to machine, all bets are off anyway.
>

You don't need physical access -- your machine controller BMC can
do the magic for you. So its not always physical access, is it?
 
> > 
> > 
> > You run a shell on the console.  You now have control of the system,
> > and can mount the real rootfs, inspect it, and work out what it does,
> > etc.
> > 
> > At this point, what use was all the validation that the secure boot
> > has done?  Absolutely useless.
> > 
> > If you can change the command line arguments given to the kernel, you
> > have no security, no matter how much you verify signatures.  It's
> > the illusion of security, nothing more, nothing less.
> > 

I agree, if you can change command line arguments, all bets are of lesser value

Balbir Singh

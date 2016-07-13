Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqKMk13ckzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 23:25:38 +1000 (AEST)
Date: Wed, 13 Jul 2016 09:25:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Petr Tesarik <ptesarik@suse.cz>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713132535.GC16900@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <87a8hmpgp8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a8hmpgp8.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 09:41:39AM +1000, Stewart Smith wrote:
> Petr Tesarik <ptesarik@suse.cz> writes:
> > On Tue, 12 Jul 2016 13:25:11 -0300
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
> >
> >> Hi Eric,
> >> 
> >> I'm trying to understand your concerns leading to your nack. I hope you 
> >> don't mind expanding your thoughts on them a bit.
> >> 
> >> Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
> >> > AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> >> > > Device tree blob must be passed to a second kernel on DTB-capable
> >> > > archs, like powerpc and arm64, but the current kernel interface
> >> > > lacks this support.
> >> > > 
> >> > > This patch extends kexec_file_load system call by adding an extra
> >> > > argument to this syscall so that an arbitrary number of file descriptors
> >> > > can be handed out from user space to the kernel.
> >> > > 
> >> > > See the background [1].
> >> > > 
> >> > > Please note that the new interface looks quite similar to the current
> >> > > system call, but that it won't always mean that it provides the "binary
> >> > > compatibility."
> >> > > 
> >> > > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> >> > 
> >> > So this design is wrong.  The kernel already has the device tree blob,
> >> > you should not be extracting it from the kernel munging it, and then
> >> > reinserting it in the kernel if you want signatures and everything to
> >> > pass.
> >> 
> >> I don't understand how the kernel signature will be invalidated. 
> >> 
> >> There are some types of boot images that can embed a device tree blob in 
> >> them, but the kernel can also be handed a separate device tree blob from 
> >> firmware, the boot loader, or kexec. This latter case is what we are 
> >> discussing, so we are not talking about modifying an embedded blob in the 
> >> kernel image.
> >> 
> >> > What x86 does is pass it's equivalent of the device tree blob from one
> >> > kernel to another directly and behind the scenes.  It does not go
> >> > through userspace for this.
> >> > 
> >> > Until a persuasive case can be made for going around the kernel and
> >> > probably adding a feature (like code execution) that can be used to
> >> > defeat the signature scheme I am going to nack this.
> >> 
> >> I also don't understand what you mean by code execution. How does passing a 
> >> device tree blob via kexec enables code execution? How can the signature 
> >> scheme be defeated?
> >
> > I'm not an expert on DTB, so I can't provide an example of code
> > execution, but you have already mentioned the /chosen/linux,stdout-path
> > property. If an attacker redirects the bootloader to an insecure
> > console, they may get access to the system that would otherwise be
> > impossible.
> 
> In this case, the user is sitting at the (or one of the) console(s) of
> the machine. There could be petitboot UIs running on the VGA display,
> IPMI serial over lan, local serial port. The logic behind setting
> /chosen/linux,stdout-path is (currently) mostly to set it for the kernel
> to what the user is interacting with. i.e. if you select an OS installer
> to boot from the VGA console, you get a graphical installer running and
> if you selected it from a text console, you get a text installer running
> (on the appropriate console).
> 
> So the bootloader (petitboot) needs to work out which console is being
> interacted with in order to set up /chosen/linux,stdout-path correctly.
> 
> This specific option could be passed as a kernel command line to the
> next kernel, yes. However, isn't the kernel command line also an attack
> vector? Is *every* command line option safe?

I don't think kernel command line is signed. And we will have to define
what is considered *unsafe*. I am working on the assumption that a
user should not be able to force execution of unsigned code at provileged
level. And passing console on kernel command line should be safe in
that respect?

Vivek

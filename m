Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw7bY6fwfzDqTG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 19:22:33 +1000 (AEST)
Date: Thu, 21 Jul 2016 10:21:55 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Dave Young' <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 "bhe@redhat.com" <bhe@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "bauerman@linux.vnet.ibm.com" <bauerman@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160721092155.GM1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
 <20160715131950.GB19840@leverpostej>
 <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FE82B@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FE82B@AcuExch.aculab.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2016 at 11:41:35AM +0000, David Laight wrote:
> From: Dave Young
> > I do not think it is worth to add another syscall for extra fds.
> > We have open(2) as an example for different numbers of arguments
> > already.
> 
> Probably works 'by luck' and no one has actually thought about why.
> That ioctl() works is (probably) even more lucky.
> 
> There are ABI that use different calling conventions for varags functions
> (eg always stack all the arguments). I guess linux doesn't run on any of them.
> 
> ioctl() is a particular problem because the 'arg' might be an integer or a pointer.
> Fortunately all the 64bit ABI linux uses pass the arg parameter in a register
> (and don't use different registers for pointer and data arguments).
> 
> You could have two 'libc' functions that refer to the same system call entry.
> Certainly safer than a varargs function.

Don't forget that the syscall API is not a normal C function API - it's
special, because there's little point stacking arguments on the userspace
stack and then having the kernel function try and read them off the
kernelspace stack.

If an architecture does such a thing, then it needs special veneers to
handle that (reading off the userspace stack and placing them onto the
kernelspace stack, or the arch needs to define some other method of
handling the situation.)

So, really, the actual C APIs don't matter that much - what matters more
is the definition of a sane way to pass such arguments.  Given the
extensive historical nature of open() and ioctl(), it would be completely
silly not to create something which allows these calls to work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

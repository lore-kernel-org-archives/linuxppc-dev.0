Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rqwMK6hcCzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 22:42:21 +1000 (AEST)
Date: Thu, 14 Jul 2016 13:42:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Dave Young <dyoung@redhat.com>, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160714124206.GB26061@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713173804.GA25723@porco> <20160713175630.GA2668@leverpostej>
 <7927804.6bj1abO0d2@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7927804.6bj1abO0d2@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 09:57:28PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 6:58:32 PM CEST Mark Rutland wrote:
> > 
> > >   we may want to remove unnecessary devices and even add a dedicated
> > >   storage device for storing a core dump image.
> > 
> > I suspect that bringing up a minimal number of devices is better
> > controlled by a cmdline option. In general, figuring out what is
> > necessary and what is not is going to be board specific, so hacking the
> > FW tables (DTB or ACPI) is not a very portable/reliable approach.
> > 
> > Do we actually add devices in practice? More so than the above that
> > requires special knowledge of the platform (including things that were
> > not described in the boot DTB).
> > 
> > In the ACPI case modifying a DTB alone is not sufficient to change the
> > information regarding devices, as those won't be described in the DTB.
> > It's not possible to convert ACPI to DTB in general.
> 
> A more likely scenario would be replacing ACPI tables with a DTB that
> describes the platform in order to use devices that the ACPI tables
> don't contain.

To do so, you need special knowledge of the platform, which users are
unlikely to have in practice for ACPI-based platforms.

So, I think that boils down to the same problem, and the same comments
apply.

> > > - Say, booting BE kernel on ACPI LE kernel
> > >   In this case, there is no useful dtb in the kernel.
> 
> > If the platform only has ACPI, then you cannot boot a BE kernel to begin
> > with. As above one cannot convert ACPI to DTB, so one would need
> > extensive platform knowledge for this to work.
> 
> I think what he meant was to pass a DTB to the kexec kernel in order
> to run BE, while the original kernel can only run LE due to ACPI.

I understood that. My point was that to build that DTB, you need to have
knowledge of the platform that you are unlikely to have.

The platform firmware may expect to interact with AML, which you can't
place in DT or run in a BE context.

If you need to run BE kernels on a platform, you would likely get a
platform that could boot a BE kernel from the outset (i.e. one that
provides a DTB), or run that code ina VM under an LE host.

Thanks,
Mark.

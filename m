Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WkxY6xtNzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 05:44:49 +1000 (AEST)
Date: Thu, 19 Jul 2018 12:44:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 dan.j.williams@intel.com, nicolas.pitre@linaro.org, josh@joshtriplett.org,
 fengguang.wu@intel.com, bp@suse.de, andy.shevchenko@gmail.com,
 patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
 frowand.list@gmail.com, keith.busch@intel.com, jonathan.derrick@intel.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
 brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
 gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
 richard.weiyang@gmail.com, devel@linuxdriverproject.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 yinghai@kernel.org, monstr@monstr.eu, davem@davemloft.net,
 chris@zankel.net, jcmvbkbc@gmail.com, gustavo@padovan.org,
 maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Message-Id: <20180719124444.c893712cca2e6f2649d1bc0d@linux-foundation.org>
In-Reply-To: <20180719151753.GB7147@localhost.localdomain>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2018 23:17:53 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi Andrew,
> 
> On 07/18/18 at 03:33pm, Andrew Morton wrote:
> > On Wed, 18 Jul 2018 10:49:44 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
> > > is used to load kernel/initrd/purgatory is supposed to be allocated from
> > > top to down. This is what we have been doing all along in the old kexec
> > > loading interface and the kexec loading is still default setting in some
> > > distributions. However, the current kexec_file loading interface doesn't
> > > do like this. The function arch_kexec_walk_mem() it calls ignores checking
> > > kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
> > > all resources of System RAM from bottom to up, to try to find memory region
> > > which can contain the specific kexec buffer, then call locate_mem_hole_callback()
> > > to allocate memory in that found memory region from top to down. This brings
> > > confusion especially when KASLR is widely supported , users have to make clear
> > > why kexec/kdump kernel loading position is different between these two
> > > interfaces in order to exclude unnecessary noises. Hence these two interfaces
> > > need be unified on behaviour.
> > 
> > As far as I can tell, the above is the whole reason for the patchset,
> > yes?  To avoid confusing users.
> 
> 
> In fact, it's not just trying to avoid confusing users. Kexec loading
> and kexec_file loading are just do the same thing in essence. Just we
> need do kernel image verification on uefi system, have to port kexec
> loading code to kernel. 
> 
> Kexec has been a formal feature in our distro, and customers owning
> those kind of very large machine can make use of this feature to speed
> up the reboot process. On uefi machine, the kexec_file loading will
> search place to put kernel under 4G from top to down. As we know, the
> 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> it. It may have possibility to not be able to find a usable space for
> kernel/initrd. From the top down of the whole memory space, we don't
> have this worry. 
> 
> And at the first post, I just posted below with AKASHI's
> walk_system_ram_res_rev() version. Later you suggested to use
> list_head to link child sibling of resource, see what the code change
> looks like.
> http://lkml.kernel.org/r/20180322033722.9279-1-bhe@redhat.com
> 
> Then I posted v2
> http://lkml.kernel.org/r/20180408024724.16812-1-bhe@redhat.com
> Rob Herring mentioned that other components which has this tree struct
> have planned to do the same thing, replacing the singly linked list with
> list_head to link resource child sibling. Just quote Rob's words as
> below. I think this could be another reason.
> 
> ~~~~~ From Rob
> The DT struct device_node also has the same tree structure with
> parent, child, sibling pointers and converting to list_head had been
> on the todo list for a while. ACPI also has some tree walking
> functions (drivers/acpi/acpica/pstree.c). Perhaps there should be a
> common tree struct and helpers defined either on top of list_head or a
> ~~~~~
> new struct if that saves some size.

Please let's get all this into the changelogs?

> > 
> > Is that sufficient?  Can we instead simplify their lives by providing
> > better documentation or informative printks or better Kconfig text,
> > etc?
> > 
> > And who *are* the people who are performing this configuration?  Random
> > system administrators?  Linux distro engineers?  If the latter then
> > they presumably aren't easily confused!
> 
> Kexec was invented for kernel developer to speed up their kernel
> rebooting. Now high end sever admin, kernel developer and QE are also
> keen to use it to reboot large box for faster feature testing, bug
> debugging. Kernel dev could know this well, about kernel loading
> position, admin or QE might not be aware of it very well. 
> 
> > 
> > In other words, I'm trying to understand how much benefit this patchset
> > will provide to our users as a whole.
> 
> Understood. The list_head replacing patch truly involes too many code
> changes, it's risky. I am willing to try any idea from reviewers, won't
> persuit they have to be accepted finally. If don't have a try, we don't
> know what it looks like, and what impact it may have. I am fine to take
> AKASHI's simple version of walk_system_ram_res_rev() to lower risk, even
> though it could be a little bit low efficient.

The larger patch produces a better result.  We can handle it ;)

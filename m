Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z3t31ZjWzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 00:34:50 +1000 (AEST)
Date: Mon, 23 Jul 2018 16:34:43 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, dan.j.williams@intel.com,
 nicolas.pitre@linaro.org, josh@joshtriplett.org,
 fengguang.wu@intel.com, bp@suse.de, andy.shevchenko@gmail.com,
 patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com,
 dmitry.torokhov@gmail.com, frowand.list@gmail.com,
 keith.busch@intel.com, jonathan.derrick@intel.com,
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
Message-ID: <20180723143443.GD18181@dhcp22.suse.cz>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719151753.GB7147@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 19-07-18 23:17:53, Baoquan He wrote:
> Kexec has been a formal feature in our distro, and customers owning
> those kind of very large machine can make use of this feature to speed
> up the reboot process. On uefi machine, the kexec_file loading will
> search place to put kernel under 4G from top to down. As we know, the
> 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> it. It may have possibility to not be able to find a usable space for
> kernel/initrd. From the top down of the whole memory space, we don't
> have this worry. 

I do not have the full context here but let me note that you should be
careful when doing top-down reservation because you can easily get into
hotplugable memory and break the hotremove usecase. We even warn when
this is done. See memblock_find_in_range_node
-- 
Michal Hocko
SUSE Labs

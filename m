Return-Path: <lkp@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414bf669RXzF456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 13:56:11 +1000 (AEST)
Date: Tue, 12 Jun 2018 11:55:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, robh+dt@kernel.org,
 dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
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
 yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
 davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
 gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
 seanpaul@chromium.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Message-ID: <201806121130.gf9upRAU%fengguang.wu@intel.com>
References: <20180612032831.29747-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
In-Reply-To: <20180612032831.29747-2-bhe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600 HEAD 5545e79eef6387857faf41cdffa7be6b1f5d4efe builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> kernel/resource.c:990:12: error: static declaration of 'reparent_resources' follows non-static declaration
    static int reparent_resources(struct resource *parent,
               ^~~~~~~~~~~~~~~~~~
   In file included from kernel/resource.c:14:0:
   include/linux/ioport.h:195:5: note: previous declaration of 'reparent_resources' was here
    int reparent_resources(struct resource *parent, struct resource *res);
        ^~~~~~~~~~~~~~~~~~
   kernel/resource.c:990:12: warning: 'reparent_resources' defined but not used [-Wunused-function]
    static int reparent_resources(struct resource *parent,
               ^~~~~~~~~~~~~~~~~~

vim +/reparent_resources +990 kernel/resource.c

   985	
   986	/*
   987	 * Reparent resource children of pr that conflict with res
   988	 * under res, and make res replace those children.
   989	 */
 > 990	static int reparent_resources(struct resource *parent,
   991					     struct resource *res)
   992	{
   993		struct resource *p, **pp;
   994		struct resource **firstpp = NULL;
   995	
   996		for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
   997			if (p->end < res->start)
   998				continue;
   999			if (res->end < p->start)
  1000				break;
  1001			if (p->start < res->start || p->end > res->end)
  1002				return -1;	/* not completely contained */
  1003			if (firstpp == NULL)
  1004				firstpp = pp;
  1005		}
  1006		if (firstpp == NULL)
  1007			return -1;	/* didn't find any conflicting entries? */
  1008		res->parent = parent;
  1009		res->child = *firstpp;
  1010		res->sibling = *pp;
  1011		*firstpp = res;
  1012		*pp = NULL;
  1013		for (p = res->child; p != NULL; p = p->sibling) {
  1014			p->parent = res;
  1015			pr_debug("PCI: Reparented %s %pR under %s\n",
  1016				 p->name, p, res->name);
  1017		}
  1018		return 0;
  1019	}
  1020	EXPORT_SYMBOL(reparent_resources);
  1021	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WMlb1VPD0clkB7bAqOAHb89iz/wHnXGabHBYAAA=

--7JfCtLOvnd9MIVvH--

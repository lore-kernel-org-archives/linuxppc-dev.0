Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414tc30whMzF34X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 01:10:23 +1000 (AEST)
Date: Tue, 12 Jun 2018 17:10:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Baoquan He <bhe@redhat.com>
cc: brijesh.singh@amd.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-pci@vger.kernel.org, richard.weiyang@gmail.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, baiyaowei@cmss.chinamobile.com,
 frowand.list@gmail.com, lorenzo.pieralisi@arm.com, sthemmin@microsoft.com,
 Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
 patrik.r.jakobsson@gmail.com, linux-input@vger.kernel.org,
 gustavo@padovan.org, dyoung@redhat.com, vgoyal@redhat.com,
 thomas.lendacky@amd.com, haiyangz@microsoft.com,
 maarten.lankhorst@linux.intel.com, jglisse@redhat.com,
 seanpaul@chromium.org, bhelgaas@google.com, tglx@linutronix.de,
 yinghai@kernel.org, jonathan.derrick@intel.com, chris@zankel.net,
 monstr@monstr.eu, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org,
 dmitry.torokhov@gmail.com, kexec@lists.infradead.org,
 ebiederm@xmission.com, devel@linuxdriverproject.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, kbuild-all@01.org
Subject: Re: [PATCH v5 2/4] resource: Use list_head to link sibling resource
Message-ID: <alpine.DEB.2.20.1806121708070.3334@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This looks wrong.  After a list iterator, the index variable points to a
dummy structure.

julia

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600
:::::: branch date: 7 hours ago
:::::: commit date: 7 hours ago

>> kernel/resource.c:265:17-20: ERROR: invalid reference to the index variable of the iterator on line 253

# https://github.com/0day-ci/linux/commit/e906f15906750a86913ba2b1f08bad99129d3dfc
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout e906f15906750a86913ba2b1f08bad99129d3dfc
vim +265 kernel/resource.c

^1da177e4 Linus Torvalds 2005-04-16  247
5eeec0ec9 Yinghai Lu     2009-12-22  248  static void __release_child_resources(struct resource *r)
5eeec0ec9 Yinghai Lu     2009-12-22  249  {
e906f1590 Baoquan He     2018-06-12  250  	struct resource *tmp, *next;
5eeec0ec9 Yinghai Lu     2009-12-22  251  	resource_size_t size;
5eeec0ec9 Yinghai Lu     2009-12-22  252
e906f1590 Baoquan He     2018-06-12 @253  	list_for_each_entry_safe(tmp, next, &r->child, sibling) {
5eeec0ec9 Yinghai Lu     2009-12-22  254  		tmp->parent = NULL;
e906f1590 Baoquan He     2018-06-12  255  		INIT_LIST_HEAD(&tmp->sibling);
5eeec0ec9 Yinghai Lu     2009-12-22  256  		__release_child_resources(tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  257
5eeec0ec9 Yinghai Lu     2009-12-22  258  		printk(KERN_DEBUG "release child resource %pR\n", tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  259  		/* need to restore size, and keep flags */
5eeec0ec9 Yinghai Lu     2009-12-22  260  		size = resource_size(tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  261  		tmp->start = 0;
5eeec0ec9 Yinghai Lu     2009-12-22  262  		tmp->end = size - 1;
5eeec0ec9 Yinghai Lu     2009-12-22  263  	}
e906f1590 Baoquan He     2018-06-12  264
e906f1590 Baoquan He     2018-06-12 @265  	INIT_LIST_HEAD(&tmp->child);
5eeec0ec9 Yinghai Lu     2009-12-22  266  }
5eeec0ec9 Yinghai Lu     2009-12-22  267

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

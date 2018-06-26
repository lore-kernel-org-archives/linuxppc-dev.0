Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FLDH63QZzF1Gj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 19:22:38 +1000 (AEST)
Date: Tue, 26 Jun 2018 10:44:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Pingfan Liu <kernelfans@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180626074426.hzunfbvwbubt3t3p@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ There is a bug with kbuild where it's not showing the Smatch warnings
  but I can probably guess...  - dan ]

Hi Pingfan,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/drivers-base-bugfix-for-supplier-consumer-ordering-in-device_kset/20180625-132702


# https://github.com/0day-ci/linux/commit/1b2a1e63898baf80e8e830991284e1534bc54766
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 1b2a1e63898baf80e8e830991284e1534bc54766
vim +/ret +245 drivers/base/core.c

1b2a1e63 Pingfan Liu 2018-06-25  216  
1b2a1e63 Pingfan Liu 2018-06-25  217  /* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
1b2a1e63 Pingfan Liu 2018-06-25  218   * there may be requirement to recursively move item.
1b2a1e63 Pingfan Liu 2018-06-25  219   */
1b2a1e63 Pingfan Liu 2018-06-25  220  int device_reorder_consumer(struct device *dev)
1b2a1e63 Pingfan Liu 2018-06-25  221  {
1b2a1e63 Pingfan Liu 2018-06-25  222  	struct list_head *iter, *left, *right;
1b2a1e63 Pingfan Liu 2018-06-25  223  	struct device *cur_dev;
1b2a1e63 Pingfan Liu 2018-06-25  224  	struct pos_info info;
1b2a1e63 Pingfan Liu 2018-06-25  225  	int ret, idx;
1b2a1e63 Pingfan Liu 2018-06-25  226  
1b2a1e63 Pingfan Liu 2018-06-25  227  	idx = device_links_read_lock();
1b2a1e63 Pingfan Liu 2018-06-25  228  	if (list_empty(&dev->links.suppliers)) {
1b2a1e63 Pingfan Liu 2018-06-25  229  		device_links_read_unlock(idx);
1b2a1e63 Pingfan Liu 2018-06-25  230  		return 0;
1b2a1e63 Pingfan Liu 2018-06-25  231  	}
1b2a1e63 Pingfan Liu 2018-06-25  232  	spin_lock(&devices_kset->list_lock);
1b2a1e63 Pingfan Liu 2018-06-25  233  	list_for_each_prev(iter, &devices_kset->list) {
1b2a1e63 Pingfan Liu 2018-06-25  234  		cur_dev = list_entry(iter, struct device, kobj.entry);
1b2a1e63 Pingfan Liu 2018-06-25  235  		ret = find_last_supplier(dev, cur_dev);
1b2a1e63 Pingfan Liu 2018-06-25  236  		switch (ret) {
1b2a1e63 Pingfan Liu 2018-06-25  237  		case -1:
1b2a1e63 Pingfan Liu 2018-06-25  238  			goto unlock;
1b2a1e63 Pingfan Liu 2018-06-25  239  		case 1:
1b2a1e63 Pingfan Liu 2018-06-25  240  			break;
1b2a1e63 Pingfan Liu 2018-06-25  241  		case 0:
1b2a1e63 Pingfan Liu 2018-06-25  242  			continue;

The break breaks from the switch and the continue continues the loop so
they're equivalent.  Perhaps you intended to break from the loop?

1b2a1e63 Pingfan Liu 2018-06-25  243  		}
1b2a1e63 Pingfan Liu 2018-06-25  244  	}
1b2a1e63 Pingfan Liu 2018-06-25 @245  	BUG_ON(!ret);

If the list is empty then "ret" can be unitialized.  We test a different
list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
code to make Smatch try to understand about empty lists, but I don't
think it works...

1b2a1e63 Pingfan Liu 2018-06-25  246  
1b2a1e63 Pingfan Liu 2018-06-25  247  	/* record the affected open section */
1b2a1e63 Pingfan Liu 2018-06-25  248  	left = dev->kobj.entry.prev;
1b2a1e63 Pingfan Liu 2018-06-25  249  	right = iter;
1b2a1e63 Pingfan Liu 2018-06-25  250  	info.pos = list_entry(iter, struct device, kobj.entry);
1b2a1e63 Pingfan Liu 2018-06-25  251  	info.tail = NULL;
1b2a1e63 Pingfan Liu 2018-06-25  252  	/* dry out the consumers in (left,right) */
1b2a1e63 Pingfan Liu 2018-06-25  253  	__device_reorder_consumer(dev, left, right, &info);
1b2a1e63 Pingfan Liu 2018-06-25  254  
1b2a1e63 Pingfan Liu 2018-06-25  255  unlock:
1b2a1e63 Pingfan Liu 2018-06-25  256  	spin_unlock(&devices_kset->list_lock);
1b2a1e63 Pingfan Liu 2018-06-25  257  	device_links_read_unlock(idx);
1b2a1e63 Pingfan Liu 2018-06-25  258  	return 0;
1b2a1e63 Pingfan Liu 2018-06-25  259  }
1b2a1e63 Pingfan Liu 2018-06-25  260  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

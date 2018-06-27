Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fn7c4fN0zF1Cl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 12:35:08 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id 128-v6so5308106itf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 19:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
 <20180626074426.hzunfbvwbubt3t3p@mwanda>
In-Reply-To: <20180626074426.hzunfbvwbubt3t3p@mwanda>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 27 Jun 2018 10:34:54 +0800
Message-ID: <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
To: dan.carpenter@oracle.com
Cc: kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dan,

Thanks for your hints, see the comment in lines.

On Tue, Jun 26, 2018 at 3:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [ There is a bug with kbuild where it's not showing the Smatch warnings
>   but I can probably guess...  - dan ]
>
> Hi Pingfan,
>
> Thank you for the patch! Perhaps something to improve:
>
> url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/drivers-base-bugfix-for-supplier-consumer-ordering-in-device_kset/20180625-132702
>
>
> # https://github.com/0day-ci/linux/commit/1b2a1e63898baf80e8e830991284e1534bc54766
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 1b2a1e63898baf80e8e830991284e1534bc54766
> vim +/ret +245 drivers/base/core.c
>
> 1b2a1e63 Pingfan Liu 2018-06-25  216
> 1b2a1e63 Pingfan Liu 2018-06-25  217  /* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
> 1b2a1e63 Pingfan Liu 2018-06-25  218   * there may be requirement to recursively move item.
> 1b2a1e63 Pingfan Liu 2018-06-25  219   */
> 1b2a1e63 Pingfan Liu 2018-06-25  220  int device_reorder_consumer(struct device *dev)
> 1b2a1e63 Pingfan Liu 2018-06-25  221  {
> 1b2a1e63 Pingfan Liu 2018-06-25  222    struct list_head *iter, *left, *right;
> 1b2a1e63 Pingfan Liu 2018-06-25  223    struct device *cur_dev;
> 1b2a1e63 Pingfan Liu 2018-06-25  224    struct pos_info info;
> 1b2a1e63 Pingfan Liu 2018-06-25  225    int ret, idx;
> 1b2a1e63 Pingfan Liu 2018-06-25  226
> 1b2a1e63 Pingfan Liu 2018-06-25  227    idx = device_links_read_lock();
> 1b2a1e63 Pingfan Liu 2018-06-25  228    if (list_empty(&dev->links.suppliers)) {
> 1b2a1e63 Pingfan Liu 2018-06-25  229            device_links_read_unlock(idx);
> 1b2a1e63 Pingfan Liu 2018-06-25  230            return 0;
> 1b2a1e63 Pingfan Liu 2018-06-25  231    }
> 1b2a1e63 Pingfan Liu 2018-06-25  232    spin_lock(&devices_kset->list_lock);
> 1b2a1e63 Pingfan Liu 2018-06-25  233    list_for_each_prev(iter, &devices_kset->list) {
> 1b2a1e63 Pingfan Liu 2018-06-25  234            cur_dev = list_entry(iter, struct device, kobj.entry);
> 1b2a1e63 Pingfan Liu 2018-06-25  235            ret = find_last_supplier(dev, cur_dev);
> 1b2a1e63 Pingfan Liu 2018-06-25  236            switch (ret) {
> 1b2a1e63 Pingfan Liu 2018-06-25  237            case -1:
> 1b2a1e63 Pingfan Liu 2018-06-25  238                    goto unlock;
> 1b2a1e63 Pingfan Liu 2018-06-25  239            case 1:
> 1b2a1e63 Pingfan Liu 2018-06-25  240                    break;
> 1b2a1e63 Pingfan Liu 2018-06-25  241            case 0:
> 1b2a1e63 Pingfan Liu 2018-06-25  242                    continue;
>
> The break breaks from the switch and the continue continues the loop so
> they're equivalent.  Perhaps you intended to break from the loop?
>
Yes, you are right.

> 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
>
> If the list is empty then "ret" can be unitialized.  We test a different
> list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> code to make Smatch try to understand about empty lists, but I don't
> think it works...
>
Yes, if list_empty, then the code can not touch ret. But ret is
useless in this scene. Does it matter?

Thanks and regards,
Pingfan

> 1b2a1e63 Pingfan Liu 2018-06-25  246
> 1b2a1e63 Pingfan Liu 2018-06-25  247    /* record the affected open section */
> 1b2a1e63 Pingfan Liu 2018-06-25  248    left = dev->kobj.entry.prev;
> 1b2a1e63 Pingfan Liu 2018-06-25  249    right = iter;
> 1b2a1e63 Pingfan Liu 2018-06-25  250    info.pos = list_entry(iter, struct device, kobj.entry);
> 1b2a1e63 Pingfan Liu 2018-06-25  251    info.tail = NULL;
> 1b2a1e63 Pingfan Liu 2018-06-25  252    /* dry out the consumers in (left,right) */
> 1b2a1e63 Pingfan Liu 2018-06-25  253    __device_reorder_consumer(dev, left, right, &info);
> 1b2a1e63 Pingfan Liu 2018-06-25  254
> 1b2a1e63 Pingfan Liu 2018-06-25  255  unlock:
> 1b2a1e63 Pingfan Liu 2018-06-25  256    spin_unlock(&devices_kset->list_lock);
> 1b2a1e63 Pingfan Liu 2018-06-25  257    device_links_read_unlock(idx);
> 1b2a1e63 Pingfan Liu 2018-06-25  258    return 0;
> 1b2a1e63 Pingfan Liu 2018-06-25  259  }
> 1b2a1e63 Pingfan Liu 2018-06-25  260
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

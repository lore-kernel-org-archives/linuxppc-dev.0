Return-Path: <dvhart@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9XY33kCzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 03:51:25 +1000 (AEST)
Date: Tue, 18 Sep 2018 10:51:08 -0700
From: Darren Hart <dvhart@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180918175108.GF35251@wrath>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
 <20180914203506.GE35251@wrath>
 <20180914205748.GC19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180914205748.GC19965@ZenIV.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 09:57:48PM +0100, Al Viro wrote:
> On Fri, Sep 14, 2018 at 01:35:06PM -0700, Darren Hart wrote:
>  
> > Acked-by: Darren Hart (VMware) <dvhart@infradead.org>
> > 
> > As for a longer term solution, would it be possible to init fops in such
> > a way that the compat_ioctl call defaults to generic_compat_ioctl_ptrarg
> > so we don't have to duplicate this boilerplate for every ioctl fops
> > structure?
> 
> 	Bad idea, that...  Because several years down the road somebody will add
> an ioctl that takes an unsigned int for argument.  Without so much as looking
> at your magical mystery macro being used to initialize file_operations.

Fair, being explicit in the declaration as it is currently may be
preferable then.

-- 
Darren Hart
VMware Open Source Technology Center

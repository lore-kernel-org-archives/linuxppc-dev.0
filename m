Return-Path: <linuxppc-dev+bounces-19100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714DE109B481
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:03:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flWZd1Nfvz2yZ6;
	Wed, 01 Apr 2026 02:03:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774969385;
	cv=none; b=Nag1lId6fDjQkn4TIjGM2PuFOMAFJALdj6BY8Xa4+d7K7r5+lLTZPTgv2dExKt7tICHG6D+ce/KXTZhlXccXE4w+slOJeGgapz+Zw0QYE10cFpGY7GXV/psN0/gQsN62cdBK4w1bl2FOem/6BQkCx8AaztVFnsG/bPj81bPP68FfHfX6wjU8VbS25X9rz+PHt+SnCO9Iarmd8c7RMaatEAHwVqFZLnWm45zAxdJMg0lBv1IlfenWk0JWLH7irDa3f1RyQAwawrPM0KNwMJTKJYPKfWe52vMs2vIo0xs7CAM0CrExiZ/nWot4mHOLQXj8v3ENz8nuSnnbk+ROexmJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774969385; c=relaxed/relaxed;
	bh=qq2vYBKP32F0qKKChIwJ/1t2rgt5oWS9aJocMdEsX8I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JlWIMEaa/Vc2lN0p6LKlwBWGt9OWgPeXVNUjmW8hYybYxQYfz+SO/YYwyU9CHAI9NgeHPI17cfZTYYx1rcurCu7kLrdO6jyC2VpVe8WghgFjiznI8sVUkhBCP5TCQHqtM9goLW3yWArhnvmHuABvTTy0cRaBrk2TilZaJYnUYayIQugQ2Ve7/TRFmf1Rsykk7UWURy6ctE092nVB4pzOwU/y8d/VEYVaArj/CUfqATTbDPLDJPl9fWp4tPRQuUtTABwf+vTLBLksWRHnA4i0yz9Nv96vd4af/nZkj096kRYU1qisNTPF/8Y/N0MKsieWElNbWzKAChhS3wvfmlixtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRKkxiJa; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRKkxiJa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flWZZ2XS8z2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:03:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969382; x=1806505382;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lKc0nR0+3UMuWZyWz6l9MjXgdkdLagd8O+NJe9KaxV4=;
  b=SRKkxiJaAWauakhC6tthzObw/vO/bx1kEgZVQtjpgBMwjZ97rhDtCf0Y
   FDfAcQQgXAiUkqCX5oK5hkVntIvbbVjFHgYCOKkcw2mpp9iJZouJaXgeF
   Z57L0hxGSY1i/VBANmWIVAdEZrida8R4qOcLPc4urj5iZFQ+UHHTEy26/
   e0lkfTCI7jDW8I/dJ/FxUfzaEcGwhEuCOL7wbh8GqP8UWfnrndsnPACRZ
   xccwxhraSRAI17Z5HAmFFtI4YeqcvO6osq6x5l+areIPr0A0p21Pbovu8
   T2uOtV83WlI52dtXHZQki/ZcNR8EApceSoGNxjo7XfNelXeZZKBxOVASo
   g==;
X-CSE-ConnectionGUID: hiu+Jhf7SoqO5xnNDxFWNQ==
X-CSE-MsgGUID: buIYwrxTRy6bA2pTJKLRYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86682259"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86682259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:53 -0700
X-CSE-ConnectionGUID: JHiKH3CWRemnPBHhcWS24A==
X-CSE-MsgGUID: Gcx1iYgWQJaJHg3SKbkrBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221527611"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:02:33 +0300 (EEST)
To: Danilo Krummrich <dakr@kernel.org>
cc: Russell King <linux@armlinux.org.uk>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
    Nikhil Agarwal <nikhil.agarwal@amd.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Vineeth Vijayan <vneethv@linux.ibm.com>, 
    Peter Oberparleiter <oberpar@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Harald Freudenberger <freude@linux.ibm.com>, 
    Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
    Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
    =?ISO-8859-15?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>, 
    Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
    virtualization@lists.linux.dev, kvm@vger.kernel.org, 
    xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, 
    Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
In-Reply-To: <20260324005919.2408620-7-dakr@kernel.org>
Message-ID: <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-7-dakr@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Danilo Krummrich wrote:

> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
> 
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
> 
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
> 
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/platform/wmi/core.c | 36 +++++-------------------------------
>  include/linux/wmi.h         |  4 ----
>  2 files changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index b8e6b9a421c6..750e3619724e 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -842,39 +842,11 @@ static ssize_t expensive_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(expensive);
>  
> -static ssize_t driver_override_show(struct device *dev, struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct wmi_device *wdev = to_wmi_device(dev);
> -	ssize_t ret;
> -
> -	device_lock(dev);
> -	ret = sysfs_emit(buf, "%s\n", wdev->driver_override);
> -	device_unlock(dev);
> -
> -	return ret;
> -}
> -
> -static ssize_t driver_override_store(struct device *dev, struct device_attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct wmi_device *wdev = to_wmi_device(dev);
> -	int ret;
> -
> -	ret = driver_set_override(dev, &wdev->driver_override, buf, count);
> -	if (ret < 0)
> -		return ret;
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *wmi_attrs[] = {
>  	&dev_attr_modalias.attr,
>  	&dev_attr_guid.attr,
>  	&dev_attr_instance_count.attr,
>  	&dev_attr_expensive.attr,
> -	&dev_attr_driver_override.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(wmi);
> @@ -943,7 +915,6 @@ static void wmi_dev_release(struct device *dev)
>  {
>  	struct wmi_block *wblock = dev_to_wblock(dev);
>  
> -	kfree(wblock->dev.driver_override);
>  	kfree(wblock);
>  }
>  
> @@ -952,10 +923,12 @@ static int wmi_dev_match(struct device *dev, const struct device_driver *driver)
>  	const struct wmi_driver *wmi_driver = to_wmi_driver(driver);
>  	struct wmi_block *wblock = dev_to_wblock(dev);
>  	const struct wmi_device_id *id = wmi_driver->id_table;
> +	int ret;
>  
>  	/* When driver_override is set, only bind to the matching driver */
> -	if (wblock->dev.driver_override)
> -		return !strcmp(wblock->dev.driver_override, driver->name);
> +	ret = device_match_driver_override(dev, driver);
> +	if (ret >= 0)
> +		return ret;
>  
>  	if (id == NULL)
>  		return 0;
> @@ -1076,6 +1049,7 @@ static struct class wmi_bus_class = {
>  static const struct bus_type wmi_bus_type = {
>  	.name = "wmi",
>  	.dev_groups = wmi_groups,
> +	.driver_override = true,
>  	.match = wmi_dev_match,
>  	.uevent = wmi_dev_uevent,
>  	.probe = wmi_dev_probe,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 75cb0c7cfe57..14fb644e1701 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -18,16 +18,12 @@
>   * struct wmi_device - WMI device structure
>   * @dev: Device associated with this WMI device
>   * @setable: True for devices implementing the Set Control Method
> - * @driver_override: Driver name to force a match; do not set directly,
> - *		     because core frees it; use driver_set_override() to
> - *		     set or clear it.
>   *
>   * This represents WMI devices discovered by the WMI driver core.
>   */
>  struct wmi_device {
>  	struct device dev;
>  	bool setable;
> -	const char *driver_override;
>  };
>  
>  /**
> 

Hi,

I tried applying this to platform-drivers tree but it failed to compile so 
I ended up dropping the changed.

-- 
 i.



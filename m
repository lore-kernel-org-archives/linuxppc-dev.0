Return-Path: <vasilis.liaskovitis@profitbricks.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59D202C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 01:41:19 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so487790vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2012 08:41:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343980161-14254-5-git-send-email-wency@cn.fujitsu.com>
References: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
 <1343980161-14254-5-git-send-email-wency@cn.fujitsu.com>
Date: Thu, 9 Aug 2012 17:41:04 +0200
Message-ID: <CAFEPiEY7gBeLoEJggSjFsF92X1Lw9DzPvEfCxhBx75NKCiL6XQ@mail.gmail.com>
Subject: Re: [RFC PATCH V6 04/19] memory-hotplug: offline and remove memory
 when removing the memory device
From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
To: wency@cn.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> We should offline and remove memory when removing the memory device.
> The memory device can be removed by 2 ways:
> 1. send eject request by SCI
> 2. echo 1 >/sys/bus/pci/devices/PNP0C80:XX/eject
>

[snip]

> +
> +static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
> +{
> +       int result;
> +
> +       /*
> +        * Ask the VM to offline this memory range.
> +        * Note: Assume that this function returns zero on success
> +        */
> +       result = acpi_memory_device_remove_memory(mem_device);
> +

here we should check the result of acpi_memory_device_remove_memory()
and not continue if it failed.

>         /* Power-off and eject the device */
>         result = acpi_memory_powerdown_device(mem_device);
>         if (result) {

thanks,

- Vasilis

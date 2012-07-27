Return-Path: <tony.luck@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59E1B2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 06:17:24 +1000 (EST)
Received: by weyx10 with SMTP id x10so2082832wey.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 13:17:20 -0700 (PDT)
MIME-Version: 1.0
Sender: tony.luck@gmail.com
In-Reply-To: <50126D44.7070608@cn.fujitsu.com>
References: <50126B83.3050201@cn.fujitsu.com> <50126D44.7070608@cn.fujitsu.com>
Date: Fri, 27 Jul 2012 13:17:20 -0700
Message-ID: <CA+8MBbL+G=xqkWU4xGF3_Ra7KoeoHuzL6QYcRiKqtVZoOBfLdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 05/19] memory-hotplug: check whether memory is
 present or not
From: Tony Luck <tony.luck@intel.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 3:28 AM, Wen Congyang <wency@cn.fujitsu.com> wrote:
> +static inline int pfns_present(unsigned long pfn, unsigned long nr_pages)
> +{
> +       int i;
> +       for (i = 0; i < nr_pages; i++) {
> +               if (pfn_present(pfn + 1))

Typo? I think you meant "pfn + i"

> +                       continue;
> +               else
> +                       return -EINVAL;
> +       }
> +       return 0;
> +}

-Tony

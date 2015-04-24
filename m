Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 701B21A0D50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 14:18:37 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 22:18:34 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E7E141FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 22:09:42 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3O4ITPj10813668
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 21:18:29 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3O4IVu5024775
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 22:18:32 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jacek Anaszewski <j.anaszewski81@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
In-Reply-To: <20150423161342.55e9ac8f@ja.home>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
Date: Fri, 24 Apr 2015 14:18:30 +1000
Message-ID: <m3egnama5l.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, cooloney@gmail.com, rpurdie@rpsys.net,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jacek Anaszewski <j.anaszewski81@gmail.com> writes:
>> These device tree comes from out firmware ... which is immutable .
>
> How the firmware is related to kernel? These bindings are for kernel,
> not for the firmware.
>
> DT bindings are compiled to *.dtb file which is concatenated with
> zImage. During system boot device drivers are matched with DT bindings
> through 'compatible' property. A driver should have single matching DT
> node, i.e. no other driver can probe with the same DT node.
> This implies that the node should contain only the properties required
> for configuring the related device.

For OPAL firmware on POWER, firmware hands kernel a flattened device
tree of the machine it's booting on. It's not added to kernel as the
kernels aren't board specific - they're generic.

https://github.com/open-power/skiboot/ is the firmware that generates
the device tree for booting under OPAL.

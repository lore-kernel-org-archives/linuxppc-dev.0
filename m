Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpklZ3v1hzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 00:25:45 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Vivek Goyal <vgoyal@redhat.com>, bhe@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 16:24:10 +0200
Message-ID: <293705810.hBL93OOmOz@wuerfel>
In-Reply-To: <20160712141810.GB30181@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1911992.H2WpLRr2Fi@wuerfel> <20160712141810.GB30181@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 12, 2016 10:18:11 AM CEST Vivek Goyal wrote:
> > 
> > On Open Firmware, the DT is extracted from running firmware and copied
> > into dynamically allocated data structures. After a kexec, the runtime
> > interface to the firmware is not available, so the flattened DT format
> > was created as a way to pass the same data in a binary blob to the new
> > kernel in a format that can be read from the kernel by walking the
> > directories in /proc/device-tree/*.
> 
> So this DT is available inside kernel and running kernel can still
> retrieve it and pass it to second kernel?

The kernel only uses the flattened DT blob at boot time and converts
it into the runtime data structures (struct device_node). The original
dtb is typically overwritten later.

> > - we typically ship devicetree sources for embedded machines with the
> >   kernel sources. As more hardware of the system gets enabled, the
> >   devicetree gains extra nodes and properties that describe the hardware
> >   more completely, so we need to use the latest DT blob to use all
> >   the drivers
> > 
> > - in some cases, kernels will fail to boot at all with an older version
> >   of the DT, or fail to use the devices that were working on the
> >   earlier kernel. This is usually considered a bug, but it's not rare
> > 
> > - In some cases, the kernel can update its DT at runtime, and the new
> >   settings are expected to be available in the new kernel too, though
> >   there are cases where you actually don't want the modified contents.
> 
> I am assuming that modified DT and unmodifed one both are accessible to
> kernel. And if user space can make decisions which modfied fields to use
> for new kernels and which ones not, then same can be done in kernel too?

The unmodified DT can typically be found on disk next to the kernel binary.
The option you have is to either read it from /proc/devicetree or to
read it from from /boot/*.dtb.

	Arnd

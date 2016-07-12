Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpkJJ1m1bzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 00:05:35 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com,
 vgoyal@redhat.com
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 16:02:46 +0200
Message-ID: <1911992.H2WpLRr2Fi@wuerfel>
In-Reply-To: <87furf7ztv.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org>
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

On Tuesday, July 12, 2016 8:25:48 AM CEST Eric W. Biederman wrote:
> AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> 
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> >   
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> >
> > See the background [1].
> >
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> >
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> So this design is wrong.  The kernel already has the device tree blob,
> you should not be extracting it from the kernel munging it, and then
> reinserting it in the kernel if you want signatures and everything to
> pass.
> 
> What x86 does is pass it's equivalent of the device tree blob from one
> kernel to another directly and behind the scenes.  It does not go
> through userspace for this.
> 
> Until a persuasive case can be made for going around the kernel and
> probably adding a feature (like code execution) that can be used to
> defeat the signature scheme I am going to nack this.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> I am happy to see support for other architectures, but for the sake of
> not moving some code in the kernel let's not build an attackable
> infrastructure.
> 

For historic context, the flattened devicetree format that we now use
to pass data about the system from boot loader to kernel was initially
introduced specifically for the purpose of enabling kexec:

On Open Firmware, the DT is extracted from running firmware and copied
into dynamically allocated data structures. After a kexec, the runtime
interface to the firmware is not available, so the flattened DT format
was created as a way to pass the same data in a binary blob to the new
kernel in a format that can be read from the kernel by walking the
directories in /proc/device-tree/*.

There are a couple of reasons for modifying the devicetree:

- For kboot/petitboot, you can have a kernel that is not booted through
  DT at all but hardwired to a particular machine, and that passes
  a DT for the entire hardware to the kernel that you actually want to
  run.

- for kdump, you need to tell the new kernel about the modified location
  of the memory, so the dump kernel doesn't overwrite the contents
  it wants to dump

- we typically ship devicetree sources for embedded machines with the
  kernel sources. As more hardware of the system gets enabled, the
  devicetree gains extra nodes and properties that describe the hardware
  more completely, so we need to use the latest DT blob to use all
  the drivers

- in some cases, kernels will fail to boot at all with an older version
  of the DT, or fail to use the devices that were working on the
  earlier kernel. This is usually considered a bug, but it's not rare

- In some cases, the kernel can update its DT at runtime, and the new
  settings are expected to be available in the new kernel too, though
  there are cases where you actually don't want the modified contents.

	Arnd

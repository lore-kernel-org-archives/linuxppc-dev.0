Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqBCH4c7TzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 18:02:50 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com,
 Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 13 Jul 2016 10:01:33 +0200
Message-ID: <5352106.oQ0Ff9gWJA@wuerfel>
In-Reply-To: <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
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

On Wednesday, July 13, 2016 10:36:14 AM CEST Dave Young wrote:
> On 07/12/16 at 03:50pm, Mark Rutland wrote:
> > On Tue, Jul 12, 2016 at 04:24:10PM +0200, Arnd Bergmann wrote:
> > > On Tuesday, July 12, 2016 10:18:11 AM CEST Vivek Goyal wrote:
> > 
> > /proc/devicetree (aka /sys/firmware/devicetree) is a filesystem derived
> > from the raw DTB (which is exposed at /sys/firmware/fdt).
> > 
> > The blob that was handed to the kernel at boot time is exposed at
> > /sys/firmware/fdt.
> 
> I believe the blob can be read and passed to kexec kernel in kernel code without
> the extra fd.
> 
> But consider we can kexec to a different kernel and a different initrd so there
> will be use cases to pass a total different dtb as well. From my understanding
> it is reasonable but yes I think we should think carefully about the design.

Ok, I can see four interesting use cases here:

- Using the dtb that the kernel has saved at boot time. Ideally this should not
  require an additional step of signing it, since the running kernel already
  trusts it.

- A dtb blob from the file system that was produced along with the kernel image.
  If we require a signature on the kernel, the the same requirement should be
  made on the dtb. Whoever signs the kernel can also sign the dtb.
  The tricky part here is the kernel command line that is part of the dtb
  and that may need to be modified.

- Modifying the dtb at for any of the reasons I listed: This should always
  be possible when we do not use secure boot, just like booting an unsigned
  kernel is.

- kboot/petitboot with all of the user space being part of the trusted boot
  chain: it would be good to allow these to modify the dtb as needed without
  breaking the trust chain, just like we allow grub or u-boot to modify the dtb
  before passing it to the kernel.

	Arnd

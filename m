Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sFMZW4jzWzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 20:21:23 +1000 (AEST)
Date: Thu, 18 Aug 2016 11:21:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] extend kexec_file_load system call
Message-ID: <20160818102112.GB27045@leverpostej>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 08:03:56PM -0300, Thiago Jung Bauermann wrote:
> This patch series is from AKASHI Takahiro. I will use it in my next
> version of the kexec_file_load implementation for powerpc, so I am
> rebasing it on top of v4.8-rc1.

[...]

> Original cover letter:
> 
> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
> 
> This patch extends kexec_file_load system call by adding an extra
> argument to this syscall so that an arbitrary number of file descriptors
> can be handed out from user space to the kernel.
> 
> See the background [1].
> 
> Please note that the new interface looks quite similar to the current
> system call, but that it won't always mean that it provides the "binary
> compatibility."
> 
> [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html

As with the original posting, I have a number of concerns, and I'm
really not keen on this.

* For typical usecases, I do not believe that this is necessary (at
  least for arm64), and generally do not believe that it should be
  necessary for a user to manipulate the DTB (much like the user need
  not manipulate ACPI tables or other FW data structures).

  Other than (potentially) the case of Linux as a flashed-in bootloader,
  I don't see a compelling case for modifying the DTB that could not be
  accomplished in-kernel. For that case, if truly necessary, I think
  that we can get away with something simpler.

* This series adds architecture-specific hooks, but doesn't define what
  the architecture code is expected to do. For example, what is the
  format of the partial DTB? Is it formatted as an overlay, or a regular
  DTB that is expected to be merged somehow?

  I'm afraid that the scope is unbound, and we'll see requests to
  whitelist/blacklist arbitrary nodes or properties in arch code. This
  goes against the original simple design of kexec_file_load. It also
  implies that we're going to have varied architecture-specific
  semantics, and that arch code might not consistently check all that it
  should.
  
* Further, I believe that this offers a lot of scope for unintentionally
  allowing certain modifications to the DTB that we do not want, and
  avoiding that in general is very tricky. e.g. if we allow the
  insertion or modification of nodes, how do we prevent phandle target
  hijacking?

I really don't think that this is a good idea. Please consider this a
NAK from my end.

Thanks,
Mark.

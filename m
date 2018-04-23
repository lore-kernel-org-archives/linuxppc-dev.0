Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VFb731KRzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 04:38:26 +1000 (AEST)
Subject: Re: [PATCH v1 1/1] misc: IBM Virtual Management Channel Driver
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: corbet@lwn.net, seroyer@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 davem@davemloft.net, linus.walleij@linaro.org, akpm@linux-foundation.org,
 mikey@neuling.org, pombredanne@nexb.com, tlfalcon@linux.vnet.ibm.com,
 msuchanek@suse.de, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1524494812-60150-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c07b14b7-8f34-2ba5-536f-85896ff21661@infradead.org>
Date: Mon, 23 Apr 2018 11:38:18 -0700
MIME-Version: 1.0
In-Reply-To: <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/18 07:46, Bryant G. Ly wrote:
> This driver is a logical device which provides an
> interface between the hypervisor and a management
> partition.
> 
> This driver is to be used for the POWER Virtual
> Management Channel Virtual Adapter on the PowerVM
> platform. It provides both request/response and
> async message support through the /dev/ibmvmc node.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Reviewed-by: Steven Royer <seroyer@linux.vnet.ibm.com>
> Reviewed-by: Adam Reznechek <adreznec@linux.vnet.ibm.com>
> Tested-by: Taylor Jakobson <tjakobs@us.ibm.com>
> Tested-by: Brad Warrum <bwarrum@us.ibm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  Documentation/ioctl/ioctl-number.txt  |    1 +
>  Documentation/misc-devices/ibmvmc.txt |  161 +++
>  MAINTAINERS                           |    6 +
>  arch/powerpc/include/asm/hvcall.h     |    1 +
>  drivers/misc/Kconfig                  |   14 +
>  drivers/misc/Makefile                 |    1 +
>  drivers/misc/ibmvmc.c                 | 2415 +++++++++++++++++++++++++++++++++
>  drivers/misc/ibmvmc.h                 |  209 +++
>  8 files changed, 2808 insertions(+)
>  create mode 100644 Documentation/misc-devices/ibmvmc.txt
>  create mode 100644 drivers/misc/ibmvmc.c
>  create mode 100644 drivers/misc/ibmvmc.h

> diff --git a/Documentation/misc-devices/ibmvmc.txt b/Documentation/misc-devices/ibmvmc.txt
> new file mode 100644
> index 0000000..bae1064
> --- /dev/null
> +++ b/Documentation/misc-devices/ibmvmc.txt
> @@ -0,0 +1,161 @@
> +Kernel Driver ibmvmc
> +====================
> +
> +Authors:
> +	Dave Engebretsen <engebret@us.ibm.com>
> +	Adam Reznechek <adreznec@linux.vnet.ibm.com>
> +	Steven Royer <seroyer@linux.vnet.ibm.com>
> +	Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> +
> +Description
> +===========
> +

...

> +
> +Virtual Management Channel (VMC)
> +A logical device, called the virtual management channel (VMC), is defined
> +for communicating between the Novalink application and the hypervisor.
> +This device, similar to a VSCSI server device, is presented to a designated
> +management partition as a virtual device and is only presented when the
> +system is not HMC managed.
> +This communication device borrows aspects from both VSCSI and ILLAN devices
> +and is implemented using the CRQ and the RDMA interfaces. A three-way
> +handshake is defined that must take place to establish that both the
> +hypervisor and management partition sides of the channel are running prior
> +to sending/receiving any of the protocol messages.
> +This driver also utilizes Transport Event CRQs. CRQ messages that are sent

                                                 Drop           "that" ?
otherwise the sentence construction is ... odd.

> +when the hypervisor detects one of the peer partitions has abnormally
> +terminated, or one side has called H_FREE_CRQ to close their CRQ.
> +Two new classes of CRQ messages are introduced for the VMC device. VMC
> +Administrative messages are used for each partition using the VMC to
> +communicate capabilities to their partner. HMC Interface messages are used
> +for the actual flow of HMC messages between the management partition and
> +the hypervisor. As most HMC messages far exceed the size of a CRQ bugger,

what is a bugger?
[reads more]
oh, buffer?

> +a virtual DMA (RMDA) of the HMC message data is done prior to each HMC
> +Interface CRQ message. Only the management partition drives RDMA
> +operations; hypervisors never directly causes the movement of message data.
> +
> +Example Management Partition VMC Driver Interface
> +=================================================

...


Looks pretty good.  In general (IMO), it could use more white space (like blank
lines after section names.)

If you fix those small items (buggers) above, you can add:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy

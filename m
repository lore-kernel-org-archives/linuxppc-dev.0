Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW3rH3FZQzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 15:21:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com <npiggin@gmail.com>
Subject: Re: [PATCH v6 01/17] powerpc/vas: Define macros,
 register fields and structures
In-Reply-To: <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-2-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 15:21:48 +1000
Message-ID: <877ey6sp03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Define macros for the VAS hardware registers and bit-fields as well
> as couple of data structures needed by the VAS driver.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v6]
> 	- Add some fields for FTW windows
>
> Changelog[v4]
> 	- [Michael Neuling] Move VAS code to arch/powerpc; Reorg vas.h and
> 	  vas-internal.h to kernel and uapi versions; rather than creating
> 	  separate properties for window context/address entries in device
> 	  tree, combine them into "reg" properties; drop ->hwirq and irq_port
> 	  fields from vas_window as they are only needed with user space
> 	  windows.
> 	- Drop the error check for CONFIG_PPC_4K_PAGES. Instead in a
> 	  follow-on patch add a "depends on CONFIG_PPC_64K_PAGES".
>
> Changelog[v3]
> 	- Rename winctx->pid to winctx->pidr to reflect that its a value
> 	  from the PID register (SPRN_PID), not the linux process id.
> 	- Make it easier to split header into kernel/user parts
> 	- To keep user interface simple, use macros rather than enum for
> 	  the threshold-control modes.
> 	- Add a pid field to struct vas_window - needed for user space
> 	  send windows.
>
> Changelog[v2]
> 	- Add an overview of VAS in vas-internal.h
> 	- Get window context parameters from device tree and drop
> 	  unnecessary macros.
> ---
>  arch/powerpc/include/asm/vas.h       |  35 ++++
>  arch/powerpc/include/uapi/asm/vas.h  |  25 +++

I thought we weren't exposing VAS to userspace yet?

If we are then we need to get things straight WRT copy/paste abort.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC9nT3XWVzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 13:53:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Subject: Re: [PATCH V9 4/8] pseries/hotplug init: Convert new DRC memory
 property for hotplug runtime
In-Reply-To: <148109488672.193207.10452460636222047460.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
 <148109488672.193207.10452460636222047460.stgit@powerkvm6.aus.stglabs.ibm.com>
Date: Tue, 31 Jan 2017 13:53:46 +1100
Message-ID: <87o9youeh1.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> hotplug_init: Simplify the code needed for runtime memory hotplug and
> maintenance with a conversion routine that transforms the compressed
> property "ibm,dynamic-memory-v2" to the form of "ibm,dynamic-memory"
> within the "ibm,dynamic-reconfiguration-memory" property.  Thus only
> a single set of routines should be required at runtime to parse, edit,
> and manipulate the memory representation in the device tree.  Similarly,
> any userspace applications that need this information will only need
> to recognize the older format to be able to continue to operate.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

This is breaking the ppc64_defconfig build:

  arch/powerpc/platforms/built-in.o: In function `.__machine_initcall_pseries_pseries_memory_hotplug_init':
  hotplug-memory.c:(.init.text+0x8cdc): undefined reference to `.pseries_memory_block_size'


cheers

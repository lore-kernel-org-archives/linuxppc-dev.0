Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07FB91A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 16:13:24 +1100 (AEDT)
Message-ID: <1448514803.9839.9.camel@ellerman.id.au>
Subject: Re: [PATCH v2 5/6] powerpc/pseries: Add CPU dlpar add functionality
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 26 Nov 2015 16:13:23 +1100
In-Reply-To: <562FC21F.3050907@linux.vnet.ibm.com>
References: <562FC0C3.7000303@linux.vnet.ibm.com>
 <562FC21F.3050907@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-27 at 13:27 -0500, Nathan Fontenot wrote:

> Add the ability to hotplug add cpus via rtas hotplug events by either
> specifying the drc index of the CPU to add, or providing a count of the
> number of CPUs to add.

So I just tried running this on my system, without doing anything on the HMC.

I have:

  # lsprop /proc/device-tree/cpus/ibm,drc-indexes 
  /proc/device-tree/cpus/ibm,drc-indexes
  		 00000002 10000000 10000002

So I think that says I have two cpus.

The first one is already added:

  /proc/device-tree/cpus/PowerPC,POWER6@0/ibm,my-drc-index
  		 10000000 (268435456)

But can I add the second one?

  # echo "cpu add count 1" > dlpar 
  RTAS: event: 34, Type: Platform Error, Severity: 2
  pseries-hotplug-cpu: Failed to acquire DRC, rc: -5, drc index: 10000002
  pseries-hotplug-cpu: CPU hot-add failed, removing any added CPUs
  -bash: echo: write error: Invalid argument


Seems not. But I'm not clear why?

Adding by index doesn't work either:

  # echo "cpu add index 10000002" > dlpar
  pseries-hotplug-cpu: Failed to acquire DRC, rc: -1, drc index: 989682
  -bash: echo: write error: Invalid argument

That's a little confusing, drc index is hex obviously.

  [root@p6-10-P5-E0 kernel]# echo "cpu add index 0x10000002" > dlpar 
  RTAS: event: 35, Type: Platform Error, Severity: 2
  pseries-hotplug-cpu: Failed to acquire DRC, rc: -5, drc index: 10000002
  -bash: echo: write error: Invalid argument


So that's probably all PEBKAC, but if we can make it more intutive that would be good.

cheers

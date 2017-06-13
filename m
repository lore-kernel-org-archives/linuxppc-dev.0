Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5xs6WqvzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:45:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
Subject: Re: RESEND Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory
 node assoc
In-Reply-To: <d0027ac9-48cb-2d31-ce26-a29c0fc0a32c@linux.vnet.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
 <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
 <8760g9qwfd.fsf@concordia.ellerman.id.au>
 <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
 <87tw3sdmpj.fsf@concordia.ellerman.id.au>
 <d0027ac9-48cb-2d31-ce26-a29c0fc0a32c@linux.vnet.ibm.com>
Date: Tue, 13 Jun 2017 20:45:04 +1000
Message-ID: <87o9tsgo9b.fsf@concordia.ellerman.id.au>
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

> Here is the information from 2 different kernels.  I have not been able to retrieve
> the information matching yesterday's attachments, yet, as those dumps were
> acquired in April.
>  
> Attached please find 2 dumps of similar material from kernels running with my
> current patches (Linux 4.4, Linux 4.12).

OK thanks.

I'd actually like to see the dmesg output from a kernel *without* your
patches.

Looking at the device tree properties:

ltcalpine2-lp9:/proc/device-tree/ibm,dynamic-reconfiguration-memory # lsprop ibm,associativity-lookup-arrays
ibm,associativity-lookup-arrays
		 00000004 = 4 arrays
                 00000004 = of 4 entries each
                 00000000 00000000 00000000 00000000
		 00000000 00000000 00000001 00000001
                 00000000 00000003 00000006 00000006
                 00000000 00000003 00000007 00000007


Which does tell us that nodes 0, 1, 6 and 7 exist.

So your idea of looking at that and setting any node found in there
online should work.

My only worry is that behaviour appears to be completely undocumented in
PAPR, ie. PAPR explicitly says that property only needs to contain
values for LMBs present at boot.

But possibly we can talk to the PowerVM/PAPR guys and have that changed
so that it becomes something we can rely on.

cheers

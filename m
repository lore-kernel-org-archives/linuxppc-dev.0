Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whn1N3p5TzDqLQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 19:48:08 +1000 (AEST)
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
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
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
Date: Tue, 06 Jun 2017 19:48:06 +1000
Message-ID: <8760g9qwfd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 06/01/2017 04:36 AM, Michael Ellerman wrote:
>> Do you actually see mention of nodes 0 and 8 in the dmesg?
>
> When the 'numa.c' code is built with debug messages, and the system was
> given that configuration by pHyp, yes, I did.
>
>> What does it say?
>
> The debug message for each core thread would be something like,
>
>     removing cpu 64 from node 0
>     adding cpu 64 to node 8
>
> repeated for all 8 threads of the CPU, and usually with the messages
> for all of the CPUs coming out intermixed on the console/dmesg log.

OK. I meant what do you see at boot.

I'm curious how we're discovering node 0 and 8 at all if neither has any
memory or CPUs assigned at boot.

>> Right. So it's not that you're hot adding memory into a previously
>> unseen node as you implied in earlier mails.
>
> In the sense that the nodes were defined in the device tree, that is corr=
ect.

Where are they defined in the device tree? That's what I'm trying to unders=
tand.


> In the sense that those nodes are currently deleted from node_possible_ma=
p in
> 'numa.c' by the instruction 'node_and(node_possible_map,node_possible_map,
> node_online_map);', the nodes are no longer available to place memory or =
CPU.

Yeah I understand that part.

> Okay, I can try to insert code that extracts all of the nodes from the
> ibm,associativity-lookup-arrays property and merge them with the nodes
> put into the online map from the CPUs that were found previously during
> boot of the powerpc code.

Hmm, will that work?

Looking at PAPR it's not clear to me that it will work for nodes that
have no memory assigned at boot.

  This property is used to duplicate the function of the
  =E2=80=9Cibm,associativity=E2=80=9D property in a /memory node. Each =E2=
=80=9Cassigned=E2=80=9D LMB
  represented has an index valued between 0 and M-1 which is used as in
  index into this table to select which associativity list to use for
  the LMB. =E2=80=9Cunassigned=E2=80=9D LMBs are place holders for potentia=
l DLPAR
  additions, for which the associativity list index is meaningless and
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  is given the reserved value of -1. This static property, need only
  contain values relevant for the LMBs presented in the
  =E2=80=9Cibm,dynamicreconfiguration-memory=E2=80=9D node; for a dynamic L=
PAR addition
  of a new LMB, the device tree fragment reported by the
  ibm,configure-connector RTAS function is a /memory node, with the
  inclusion of the =E2=80=9Cibm,associativity=E2=80=9D device tree property=
 defined in
  Section C.6.2.2=E2=80=9A =E2=80=9CProperties of the Children of Root=E2=
=80=9A=E2=80=9D on page 1059.

>> What does your device tree look like? Can you send us the output of:
>>=20
>>  $ lsprop /proc/device-tree

Thanks. I forgot that lsprop will truncate long properties, I actually
wanted to see all of the ibm,dynamic-memory property.

But looking at the code I see the only place we set a nid online is if
there is a CPU assigned to it:

static int __init parse_numa_properties(void)
{
...
	for_each_present_cpu(i) {
        	...
		cpu =3D of_get_cpu_node(i, NULL);
		nid =3D of_node_to_nid_single(cpu);
                ...
		node_set_online(nid);
	}

Or for memory nodes (same function):

	for_each_node_by_type(memory, "memory") {
        	...
		nid =3D of_node_to_nid_single(memory);
                ...
		node_set_online(nid);
                ...
	}

Or for entries in ibm,dynamic-memory that are assigned:

static void __init parse_drconf_memory(struct device_node *memory)
{
	...
	for (; n !=3D 0; --n) {
        	...
		/* skip this block if the reserved bit is set in flags (0x80)
		   or if the block is not assigned to this partition (0x8) */
		if ((drmem.flags & DRCONF_MEM_RESERVED)
		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
			continue;

		...
		do {
                	...
			nid =3D of_drconf_to_nid_single(&drmem, &aa);
			node_set_online(nid);
                        ...
		} while (--ranges);
	}
}


So I don't see from that how we can even be aware that node 0 and 8
exist at boot based on that. Maybe there's another path I'm missing
though.

cheers

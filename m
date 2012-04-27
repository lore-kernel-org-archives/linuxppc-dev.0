Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 60384B701C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 05:25:44 +1000 (EST)
Message-ID: <4F9AF26C.9030808@redhat.com>
Date: Fri, 27 Apr 2012 16:24:28 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ADCE3.2030506@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F170F4A4C@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F170F4A4C@ORSMSX104.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, "Gross, Mark" <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <bp@amd64.org>, Egor Martovetsky <egor@pasemi.com>,
 =?ISO-8859-1?Q?Niklas_S=F6d?= =?ISO-8859-1?Q?erlund?=
 <niklas.soderlund@ericsson.com>, Tim Small <tim@buttersideup.com>,
 "Arvind R." <arvino55@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 27-04-2012 15:11, Luck, Tony escreveu:
>>>> +	for (i = 0; i < dimm->mci->n_layers; i++) {
>>>> +		printk(KERN_CONT "%d", dimm->location[i]);
>>>> +		if (i < dimm->mci->n_layers - 1)
>>>> +			printk(KERN_CONT ".");
>>>> +	}
>>>> +	printk(KERN_CONT "\n");
>>>
>>> This looks hacky but I don't have a good suggestion what to do instead
>>> here. Maybe snprintf into a complete string which you can issue with
>>> debugf4()...
>>
>> This is not hacky. There are several places at the Kernel doing loops like
>> that. Look, for example, at lib/hexdump.c (without KERN_CONT, as this
>> macro was added later - probably to avoid checkpatch.pl complains).
> 
> There is some benefit to "one printk == one output line" ... it means
> that console output will not be (as) jumbled if multiple cpus are
> printk'ing at the same time.

Ok, but this message only appears when all the conditions below are met:
	- the driver is compiled with EDAC_DEBUG;
	- the edac_core is modprobed with edac_debug_level=4;
	- during the driver modprobe, when the EDAC driver is being registered.

Even on several-core machines, those messages won't mangle, in practice.

Let's not over-design a simple debug message.

Regards,
Mauro

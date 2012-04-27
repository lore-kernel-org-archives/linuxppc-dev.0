Return-Path: <tony.luck@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 60823B6FDE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 04:21:45 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@amd64.org>
Subject: RE: [PATCH EDACv16 1/2] edac: Change internal representation to
 work with layers
Date: Fri, 27 Apr 2012 18:11:49 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F170F4A4C@ORSMSX104.amr.corp.intel.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ADCE3.2030506@redhat.com>
In-Reply-To: <4F9ADCE3.2030506@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, "Gross, Mark" <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 =?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Olof Johansson <olof@lixom.net>,
 Doug Thompson <norsk5@yahoo.com>,
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

>>> +	for (i =3D 0; i < dimm->mci->n_layers; i++) {
>>> +		printk(KERN_CONT "%d", dimm->location[i]);
>>> +		if (i < dimm->mci->n_layers - 1)
>>> +			printk(KERN_CONT ".");
>>> +	}
>>> +	printk(KERN_CONT "\n");
>>=20
>> This looks hacky but I don't have a good suggestion what to do instead
>> here. Maybe snprintf into a complete string which you can issue with
>> debugf4()...
>
> This is not hacky. There are several places at the Kernel doing loops lik=
e
> that. Look, for example, at lib/hexdump.c (without KERN_CONT, as this
> macro was added later - probably to avoid checkpatch.pl complains).

There is some benefit to "one printk =3D=3D one output line" ... it means
that console output will not be (as) jumbled if multiple cpus are
printk'ing at the same time.

-Tony

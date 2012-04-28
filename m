Return-Path: <bp@amd64.org>
Received: from mail.x86-64.org (s15943758.onlinehome-server.info
 [217.160.130.188]) by ozlabs.org (Postfix) with ESMTP id B8F77B6FD4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 18:58:39 +1000 (EST)
Date: Sat, 28 Apr 2012 10:58:30 +0200
From: Borislav Petkov <bp@amd64.org>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
Message-ID: <20120428085830.GC26065@aftab.osrc.amd.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com>
 <4F9ADCE3.2030506@redhat.com> <4F9AF26C.9030808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F9AF26C.9030808@redhat.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, "Gross, Mark" <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Olof Johansson <olof@lixom.net>,
 Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, "Luck, Tony" <tony.luck@intel.com>,
 Jiri Kosina <jkosina@suse.cz>,
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

On Fri, Apr 27, 2012 at 04:24:28PM -0300, Mauro Carvalho Chehab wrote:
> Em 27-04-2012 15:11, Luck, Tony escreveu:
> >>>> +	for (i = 0; i < dimm->mci->n_layers; i++) {
> >>>> +		printk(KERN_CONT "%d", dimm->location[i]);
> >>>> +		if (i < dimm->mci->n_layers - 1)
> >>>> +			printk(KERN_CONT ".");
> >>>> +	}
> >>>> +	printk(KERN_CONT "\n");
> >>>
> >>> This looks hacky but I don't have a good suggestion what to do instead
> >>> here. Maybe snprintf into a complete string which you can issue with
> >>> debugf4()...
> >>
> >> This is not hacky. There are several places at the Kernel doing loops like
> >> that. Look, for example, at lib/hexdump.c (without KERN_CONT, as this
> >> macro was added later - probably to avoid checkpatch.pl complains).
> > 
> > There is some benefit to "one printk == one output line" ... it means
> > that console output will not be (as) jumbled if multiple cpus are
> > printk'ing at the same time.
> 
> Ok, but this message only appears when all the conditions below are met:
> 	- the driver is compiled with EDAC_DEBUG;
> 	- the edac_core is modprobed with edac_debug_level=4;
> 	- during the driver modprobe, when the EDAC driver is being registered.

That means nothing.

> Even on several-core machines, those messages won't mangle, in practice.
> 
> Let's not over-design a simple debug message.

No, let's design a simple debug message correctly, regardless of when it
appears.

> 
> Regards,
> Mauro
> 

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551

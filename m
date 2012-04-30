Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 2A68DB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 23:01:36 +1000 (EST)
Message-ID: <4F9E8CFE.1040801@redhat.com>
Date: Mon, 30 Apr 2012 10:00:46 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@amd64.org>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ABCEC.9090807@redhat.com>
 <20120428090523.GD26065@aftab.osrc.amd.com> <4F9D46F8.1020104@redhat.com>
 <20120430081513.GD8182@aftab.osrc.amd.com> <4F9E7059.5070804@redhat.com>
 <20120430111126.GD9303@aftab.osrc.amd.com> <4F9E7B45.8010908@redhat.com>
 <20120430123819.GF9303@aftab.osrc.amd.com>
In-Reply-To: <20120430123819.GF9303@aftab.osrc.amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 =?ISO-8859-1?Q?Niklas_S=F6d?= =?ISO-8859-1?Q?erlund?=
 <niklas.soderlund@ericsson.com>, Tim Small <tim@buttersideup.com>,
 "Arvind R." <arvino55@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 30-04-2012 09:38, Borislav Petkov escreveu:
> On Mon, Apr 30, 2012 at 08:45:09AM -0300, Mauro Carvalho Chehab wrote:
>> Em 30-04-2012 08:11, Borislav Petkov escreveu:
>>> On Mon, Apr 30, 2012 at 07:58:33AM -0300, Mauro Carvalho Chehab wrote:

>>> This way it says "initializing 12 dimms" and the user thinks there are
>>> 12 DIMMs on his system where this might not be true.
>>
>>
>> I'm OK to remove the "initializing 12 dimms" message. It doesn't add anything
>> new.
>>
>> With regards do the other messages, if the debug messages are not clear, 
>> then let's fix them, instead of removing. What if we print, instead,
>> on a message like:
>>
>> 	"row 1, chan 1 will represent dimm5 (1:2:0) if not empty"
> 
> How about the following instead: the specific driver calls
> edac_mc_alloc(), it gets the allocated dimm array in mci->dimms
> _without_ dumping each dimm%d line. Then, each driver figures out which
> subset of that dimms array actually has populated slots and prints only
> the populated rank/slot/...
> 
> This information is much more valuable than saying how many _possible_
> slots the edac core has allocated.
> 
> Then, each driver can decide whether it makes sense to dump that info or
> not.

No, that would add extra complexity at the drivers level just due to debug
messages. I think that the better is to move this printk to the debug-specific
routine that is called only when the dimm is filled (edac_mc_dump_dimm).

With this cange, the message will be printed only for the filled dimms.

This is a cleanup patch, so I'll write it, together with the change that
will get rid of the loop that uses KERN_CONT. It will use a function added
by a latter patch at edac_mc_sysfs so it can't be merged on this patch
anyway.

Regards,
Mauro

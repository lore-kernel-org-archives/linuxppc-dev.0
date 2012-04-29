Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DECCFB6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 00:26:37 +1000 (EST)
Message-ID: <4F9D4F6E.4070106@redhat.com>
Date: Sun, 29 Apr 2012 11:25:50 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@amd64.org>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com>
 <1335535895.25521.7.camel@joe2Laptop> <4F9AC44A.5000509@redhat.com>
 <20120428085223.GB26065@aftab.osrc.amd.com>
In-Reply-To: <20120428085223.GB26065@aftab.osrc.amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 =?ISO-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Joe Perches <joe@perches.com>,
 Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 28-04-2012 05:52, Borislav Petkov escreveu:
> On Fri, Apr 27, 2012 at 01:07:38PM -0300, Mauro Carvalho Chehab wrote:
>> Yes. This is a common issue at the EDAC core: on several places, it calls the
>> edac debug macros (DEBUGF0...DEBUGF4) passing a __func__ as an argument, while
>> the debug macros already handles that. I suspect that, in the past, the __func__
>> were not at the macros, but some patch added it there, and forgot to fix the
>> occurrences of its call.
> 
> The patch that added it is d357cbb445208 and you reviewed it.

And you wrote the patch that caused it.

> 
>> This is something that needs to be reviewed at the entire EDAC core (and likely
>> at the drivers).
> 
> Looks like a job for a newbie to get her/his feet wet with kernel work.

> 
>> I opted to not touch on this at the existing debug logic, as I think that the
>> better is to address all those issues on one separate patch, after fixing the
>> EDAC core bugs.
> 
> No,
> 
> you simply need to remove the __func__ argument in your newly added debug call:
> 
>                 debugf2("%s: %d: dimm%zd (%d:%d:%d): row %d, chan %d\n", __func__,
>                         i, (dimm - mci->dimms),
>                         pos[0], pos[1], pos[2], row, chn);
> 
> And while you're at it, remove the rest of the __func__ arguments from
> your newly added debugfX calls.

A single patch fixing this everywhere at drivers/edac is better and clearer than adding 
an unrelated fix on this patch. This is already complex enough to add more unrelated
things there.

Also, a simple perl/coccinelle script can replace all such __func__ occurrences 
on one shot.

Regards,
Mauro

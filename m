Return-Path: <bp@amd64.org>
Received: from mail.x86-64.org (s15943758.onlinehome-server.info
 [217.160.130.188]) by ozlabs.org (Postfix) with ESMTP id 436C0B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 00:27:02 +1000 (EST)
Date: Thu, 26 Apr 2012 16:26:52 +0200
From: Borislav Petkov <bp@amd64.org>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [EDAC PATCH v13 2/7] edac: move dimm properties to struct
 dimm_info
Message-ID: <20120426142652.GB2793@aftab.osrc.amd.com>
References: <1333039546-5590-1-git-send-email-mchehab@redhat.com>
 <1334607133-30039-1-git-send-email-mchehab@redhat.com>
 <1334607133-30039-3-git-send-email-mchehab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1334607133-30039-3-git-send-email-mchehab@redhat.com>
Cc: Mike Williams <mike@mikebwilliams.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Jason Uhlenkott <juhlenko@akamai.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 James Bottomley <James.Bottomley@parallels.com>,
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

On Mon, Apr 16, 2012 at 05:12:08PM -0300, Mauro Carvalho Chehab wrote:
> On systems based on chip select rows, all channels need to use memories
> with the same properties, otherwise the memories on channels A and B
> won't be recognized.
> 
> However, such assumption is not true for all types of memory
> controllers.
> 
> Controllers for FB-DIMM's don't have such requirements.
> 
> Also, modern Intel controllers seem to be capable of handling such
> differences.
> 
> So, we need to get rid of storing the DIMM information into a per-csrow
> data, storing it, instead at the right place.
> 
> The first step is to move grain, mtype, dtype and edac_mode to the
> per-dimm struct.
> 
> Reviewed-by: Aristeu Rozanski <arozansk@redhat.com>
> Cc: Doug Thompson <norsk5@yahoo.com>
> Cc: Borislav Petkov <borislav.petkov@amd.com>
> Cc: Mark Gross <mark.gross@intel.com>
> Cc: Jason Uhlenkott <juhlenko@akamai.com>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Ranganathan Desikan <ravi@jetztechnologies.com>
> Cc: "Arvind R." <arvino55@gmail.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Egor Martovetsky <egor@pasemi.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Hitoshi Mitake <h.mitake@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: James Bottomley <James.Bottomley@parallels.com>
> Cc: "Niklas Söderlund" <niklas.soderlund@ericsson.com>
> Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
> Cc: Josh Boyer <jwboyer@gmail.com>
> Cc: Mike Williams <mike@mikebwilliams.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

For the amd64_edac and core changes:

Reviewed-by: Borislav Petkov <borislav.petkov@amd.com>

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551

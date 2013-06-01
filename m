Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37B022C0091
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Jun 2013 14:43:51 +1000 (EST)
Message-ID: <1370061811.3766.24.camel@pasglop>
Subject: Re: [PATCH v3 0/8] Nvram-to-pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:43:31 +1000
In-Reply-To: <1370061602.3766.22.camel@pasglop>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
 <1370061602.3766.22.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, ccross@android.com, keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-01 at 14:40 +1000, Benjamin Herrenschmidt wrote:

  .../...

> In fact, this applies to at least all the BookS server platforms...
> 
> Things that come to mind:
> 
>  - nvram_64.c duplicates generic_nvram.c as far as the user accessors
> are concerned, it should be possible to get rid of code there. Either
> the arch or the generic one (*)
> 
>  - The nvram partition management should move to generic. While at it
> factor in the powermac variant (same stuff, mostly duplicated code)
> 
>  - powernv wants all the goodies that pseries has, as does cell.

 - It's stupid for userspace to re-implement the whole partition scheme,
so let's add ioctl's to lookup partitions by name & type. We could turn
the whole thing into sysfs instead too which might be better .... (ie
a file per partition).

> (*) I wonder about that generic stuff... userspace might want to start
> doing things like resizing the common partition if not big enough etc...
> For that we might want to add more specific ioctl's. Is anybody other
> than us using generic_nvram ? I don't like adding ioctl's like that
> to a generic driver, maybe we could just make it call into something
> like arch_nvram_ioctl() and have an empty weak variant instead of the
> current ifdef game.
> 
> Cheers,
> Ben.
> 
> > Changes from v2:
> > 	- Fix renaming of pstore type ids in nvram.c
> > 
> > Changes from v1:
> > 	- Reduce #ifdefs by and remove forward declarations of pstore callbacks
> > 	- Handle return value of nvram_write_os_partition
> > 	- Remove empty pstore callbacks and register pstore only when pstore
> > 	  is configured
> > ---
> > 
> > Aruna Balakrishnaiah (8):
> >       powerpc/pseries: Remove syslog prefix in uncompressed oops text
> >       powerpc/pseries: Add version and timestamp to oops header
> >       powerpc/pseries: Introduce generic read function to read nvram-partitions
> >       powerpc/pseries: Read/Write oops nvram partition via pstore
> >       powerpc/pseries: Read rtas partition via pstore
> >       powerpc/pseries: Distinguish between a os-partition and non-os partition
> >       powerpc/pseries: Read of-config partition via pstore
> >       powerpc/pseries: Read common partition via pstore
> > 
> > 
> >  arch/powerpc/platforms/pseries/nvram.c |  353 +++++++++++++++++++++++++++-----
> >  fs/pstore/inode.c                      |    9 +
> >  include/linux/pstore.h                 |    4 
> >  3 files changed, 313 insertions(+), 53 deletions(-)
> > 
> 

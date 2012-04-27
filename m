Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0064EB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 00:11:50 +1000 (EST)
Message-ID: <1335535895.25521.7.camel@joe2Laptop>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to
 work with layers
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@amd64.org>
Date: Fri, 27 Apr 2012 10:11:35 -0400
In-Reply-To: <20120427133304.GE9626@aftab.osrc.amd.com>
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Shaohui Xie <Shaohui.Xie@freescale.com>,
 Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ericsson.com>,
 Tim Small <tim@buttersideup.com>, "Arvind R." <arvino55@gmail.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Doug Thompson <norsk5@yahoo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-04-27 at 15:33 +0200, Borislav Petkov wrote:
> this patch gives
> 
> [    8.278399] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 0: dimm0 (0:0:0): row 0, chan 0

One too many __func__'s in some combination of the
pr_fmt and/or dbg call and/or the actual call site?

> > diff --git a/drivers/edac/edac_core.h b/drivers/edac/edac_core.h
[]
> > @@ -447,8 +447,13 @@ static inline void pci_write_bits32(struct pci_dev *pdev, int offset,
> >  
> >  #endif				/* CONFIG_PCI */
> >  
> > -extern struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
> > -					  unsigned nr_chans, int edac_index);
> > +struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
> > +				   unsigned nr_chans, int edac_index);
> 
> Why not "extern"?

Using extern function prototypes in .h files
isn't generally necessary nor is extern the
more common kernel style.

> > +static inline void edac_mc_handle_ce(struct mem_ctl_info *mci,
> >  			      unsigned long page_frame_number,
> >  			      unsigned long offset_in_page,
> >  			      unsigned long syndrome, int row, int channel,
> > -			      const char *msg);
> 
> Strange alignment, pls do
> 
> static inline void edac_mc_handle_ce(struct...,
> 				     unsigned...,
> 				     ...,
> 				     ...);
> 

or

static inline
void edac_mc_handle_ce(struct ..., etc)

or

static inline void
edac_mc_handle_ce(...)

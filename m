Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id E924DB7109
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 23:59:03 +1000 (EST)
Date: Fri, 23 Jul 2010 15:58:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc:  fix .data..init_task output section
Message-ID: <20100723135859.GA26879@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
	<20100713095024.GA10494@merkur.ravnborg.org>
	<20100722195008.72fe2e71@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100722195008.72fe2e71@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 07:50:08PM -0400, Sean MacLennan wrote:
> On Tue, 13 Jul 2010 11:50:24 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > From 851e645a7eee68380caaf026eb6d3be118876370 Mon Sep 17 00:00:00 2001
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 13 Jul 2010 11:39:42 +0200
> > Subject: [PATCH] vmlinux.lds: fix .data..init_task output section
> > (fix popwerpc boot)
> > 
> > The .data..init_task output section was missing
> > a load offset causing a popwerpc target to fail to boot.
> > 
> > Sean MacLennan tracked it down to the definition of
> > INIT_TASK_DATA_SECTION().
> > 
> > There are only two users of INIT_TASK_DATA_SECTION()
> > in the kernel today: cris and popwerpc.
> > cris do not support relocatable kernels and is thus not
> > impacted by this change.
> > 
> > Fix INIT_TASK_DATA_SECTION() to specify load offset like
> > all other output sections.
> > 
> > Reported-by: Sean MacLennan <smaclennan@pikatech.com>
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> > 
> > On the assumption that Sean reports that it fixes
> > the warnings/boot issue here is a real patch.
> > 
> > Ben - will you take it via the popwerpc tree
> > or shall I ask Michal to take it via kbuild?
> > 
> > 	Sam

Sorry for the bad initial subject line!
As Sean reported that the patch fixes his isuse it
deserves a:

Tested-by: Sean MacLennan <smaclennan@pikatech.com>

	Sam

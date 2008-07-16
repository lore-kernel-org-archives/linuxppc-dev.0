Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 0D9A5DE691
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 01:46:50 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so407882qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 08:46:49 -0700 (PDT)
Date: Wed, 16 Jul 2008 09:46:46 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Message-ID: <20080716154646.GH24045@secretlab.ca>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
	<200807161646.02306.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200807161646.02306.arnd@arndb.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: fkan@amcc.com, linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 04:46:01PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2008, Grant Likely wrote:
> > 
> > > 
> > > And then you don't need this file at all.  Just add a
> > > "amcc,canyonlands" string to your root node compatible property.
> > 
> > No!  Don't do this because it is not true!
> > 
> > Instead, add your board name to canyonlands.c in canyonlands_probe().
> > It's not the most scalable solution, but it keeps you from lying about
> > your hardware in the .dts file.
> > 
> > I'm working on a more scalable solution for this, but for now just add
> > your specific board to canyonlands_probe().
> 
> Shouldn't it be enough to have a common compatible value in each
> of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
> specific type unless you need to do something special?

This is bad for the same reason that "amcc,44x-<blah>" compatible values
are bad in device nodes.  The definition of '*-44x-*' changes over time as
new parts are added.  Compatible values should always reflect an exact
part number.

g.

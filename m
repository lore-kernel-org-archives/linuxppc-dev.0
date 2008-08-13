Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id A743CDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 15:41:25 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2719802rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:41:24 -0700 (PDT)
Date: Tue, 12 Aug 2008 23:41:21 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Message-ID: <20080813054121.GG17587@secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
	<20080807061254.GB12571@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080807061254.GB12571@yookeroo.seuss>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 04:12:54PM +1000, David Gibson wrote:
> On Wed, Aug 06, 2008 at 11:46:47AM -0500, Timur Tabi wrote:
> > On Wed, Aug 6, 2008 at 1:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > of_lookup_stdout() is useful for figuring out what device to use as output
> > > for early boot progress messages.  It returns the node pointed to by the
> > > linux,stdout-path property in the chosen node.
> > 
> > I thought linux,stdout-path is deprecated are we're supposed to be
> > using the aliases node instead?
> 
> During the ePAPR process this idea came up - standardising a 'stdout'
> alias that would replace linux,stdout-path in chosen.  However that
> was done in ignorance of the history of the linux,stdout-path property
> and its connection to the stdout ihandle in chosen.  In any case, the
> proposed 'stdout' alias didn't make the final cut for ePAPR, so how to
> address this for flat-tree systems is still an open question.

So, seeing as settling on a way to determine stdout still up in the air,
it probably makes sense to condense that code down to a single
authoritative function so that changes in this area are contained in one
place.  For now, I'll stick with decoding linux,stdout-path and on Sparc
decoding the ihandle with the expectation that there will be further
refinements to be made.

g.

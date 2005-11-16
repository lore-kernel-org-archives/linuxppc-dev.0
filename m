Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <1132108490.5646.67.camel@gaston>
References: <1132108490.5646.67.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ad202b87fa52d954e645b05fb45ca13@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Tue, 15 Nov 2005 21:23:13 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 15, 2005, at 8:34 PM, Benjamin Herrenschmidt wrote:
> >
> > BTW, Based on the pile of docs I have here, I think the list of
> > alignment-exception-causing events on FSL's current parts (603, 603e,
> > 750, 74x, 74xx, e500) is:
> >
> > - lmw/stmw (all procs, non-word aligned)
> > - single and double precision floating point ld/st ops (non-E500, non
> > data size aligned)
> > - dcbz to WT or CI memory (all procs)
> > - dcbz with cache disabled (all procs but 603e?)
> > - misaligned little endian accesses (603e)
> > - lwarx/stwcx (all procs)
> > - multiple/string with LE set (750, 603e, 7450, 7400)
> > - eciwx/ecowx (750, 7450, 7400)
> > - a couple of others related to vector processing
> >
> > If anybody knows offhand of something missing there, let me know.
>
> What about lwz/stw cropssing page boundaries ? Is this handled in HW ?
>
> Ben.

Apparently so, much to my surprise - I ran the testcase with those 
instructions misaligned across a page boundary last night and got no 
alignment exception.  I was surprised, and asked my husband about it 
(he worked on the load/store units for a bunch of our parts), and he 
says these guys never cause an exception for any of FSL's current parts 
as far as he knows.  This is supported by our documentation as well - 
the only place I see these listed is on 603e, where they can cause an 
exception if the page is mapped little endian.

-B

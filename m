Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <1132032910.23979.6.camel@gaston>
References: <1132032910.23979.6.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <00eecfdbd5bccc7b293d847033121eee@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Tue, 15 Nov 2005 20:19:58 -0600
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

Ben,

Yeah,  I clearly shouldn't run testcases at 11pm, because I got in a=20
rush and only confirmed that lmw/stmw were actually taking the=20
exception.  Those 2 are working beautifully.  To test the others, I=20
need to run on a different board which, of course,  isn't bootable at=20
the moment.  As soon as I can get that up and running, I'll try some of=20=

the other cases and let you know how it goes......

BTW, Based on the pile of docs I have here, I think the list of=20
alignment-exception-causing events on FSL's current parts (603, 603e,=20
750, 74x, 74xx, e500) is:

- lmw/stmw (all procs, non-word aligned)
- single and double precision floating point ld/st ops (non-E500, non=20
data size aligned)
- dcbz to WT or CI memory (all procs)
- dcbz with cache disabled (all procs but 603e?)
- misaligned little endian accesses (603e)
- lwarx/stwcx (all procs)
- multiple/string with LE set (750, 603e, 7450, 7400)
- eciwx/ecowx (750, 7450, 7400)
- a couple of others related to vector processing

If anybody knows offhand of something missing there, let me know.

Cheers,
B



On Nov 14, 2005, at 11:35 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-11-14 at 23:10 -0600, Becky Bruce wrote:
> > Ben,
> >
> > I've just done some basic testing of lmw/stmw, lwz/stw, lhx/sth,
> > lfs/stfs, and lfd/stfd misaligned across a doubleword boundary, and
> > everything looks good so far.=A0=A0 I'll check out the byte =
reversals=20
> and a
> > few other forms tomorrow.
>
> Excellent, thanks ! BTW. Make sure you test these one CPUs that=20
> actually
> trap on misaligned accesses :) Best is probably to do the misaligned
> access accross a page boundary, that's what most CPUs can do.
>
> Ben.
>

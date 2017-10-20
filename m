Return-Path: <alexander.steffen@infineon.com>
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJPZl247tzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 23:03:26 +1100 (AEDT)
From: <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>
CC: <andriy.shevchenko@linux.intel.com>, <elfring@users.sourceforge.net>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>, <clabbe.montjoie@gmail.com>,
 <jgunthorpe@obsidianresearch.com>, <jsnitsel@redhat.com>,
 <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>, <nayna@linux.vnet.ibm.com>,
 <paulus@samba.org>, <PeterHuewe@gmx.de>, <stefanb@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Fri, 20 Oct 2017 12:03:20 +0000
Message-ID: <ad6ff01976fb4945bc218c43c44f9272@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <20171018144811.klfmzikibuux77pf@linux.intel.com>
 <8afa2fb8d8704aff804cd8da15e931da@infineon.com>
 <20171020090139.l4igyucqxqmgrq7l@linux.intel.com>
 <20171020102351.bfz7s2ihwce7q2iz@linux.intel.com>
In-Reply-To: <20171020102351.bfz7s2ihwce7q2iz@linux.intel.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, Oct 20, 2017 at 12:01:39PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 19, 2017 at 04:58:23PM +0000,
> Alexander.Steffen@infineon.com wrote:
> > > > On Tue, Oct 17, 2017 at 11:50:05AM +0000,
> Alexander.Steffen@infineon.com
> > > > wrote:
> > > > > > > Replace the specification of data structures by pointer
> dereferences
> > > > > > > as the parameter for the operator "sizeof" to make the
> corresponding
> > > > > > > size
> > > > > > > determination a bit safer according to the Linux coding style
> > > > > > > convention.
> > > > > >
> > > > > >
> > > > > > This patch does one style in favor of the other.
> > > > >
> > > > > I actually prefer that style, so I'd welcome this change :)
> > > > >
> > > > > > At the end it's Jarkko's call, though I would NAK this as I thi=
nk some
> > > > > > one already told this to you for some other similar patch(es).
> > > > > >
> > > > > >
> > > > > > I even would suggest to stop doing this noisy stuff, which keep=
s
> people
> > > > > > busy for nothing.
> > > > >
> > > > > Cleaning up old code is also worth something, even if does not ch=
ange
> > > > > one bit in the assembly output in the end...
> > > > >
> > > > > Alexander
> > > >
> > > > Quite insignificant clean up it is that does more harm that gives a=
ny
> > > > benefit as any new change adds debt to backporting.
> > > >
> > > > Anyway, this has been a useful patch set for me in the sense that I=
 have
> > > > clearer picture now on discarding/accepting commits.
> > >
> > > Indeed. I have now a better understanding for why some code looks as
> > > ugly as it does.
> > >
> > > > One line minor
> > > > clean up will be from now on automatic NAK unless it causes a compi=
ler
> > > > warning or some other visible side-effect.
> > >
> > > Not a nice policy, but at least a policy. I have deleted the tasks
> > > that I had still planned for other cleanup activities.
> > >
> > > Alexander
> >
> > 1/4 and 2/4 are sensible clean ups as long as the commit message is
> > refined.
> >
> > Moving more functions to use tpm_buf instead of nasty tpm_cmd_t are
> > also welcome changes.
> >
> > Documenting functions (exported mainly) is also welcome. Or refining
> > documentation.
> >
> > It's really case by case. The important thing in small clean ups is
> > a clearly written commit message that explains rationale.
> >
> > /Jarkko
>=20
> It's easy to say in retroperpective that code is "ugly". I would use
> strong consideration before using that adjective for mainline code.
> Rarely when you do something new first the form will be polished.

(Let's not argue over words, not being a native speaker, I'll probably not =
choose the perfect expression all the time.)

My assumption is that in many cases the code was not like that from the beg=
inning. Over time, new functionality got added, interfaces expanded, etc. B=
ut when the goal tends to be to keep the changes minimal, then it is only n=
atural for everyone to be focused on their small parts of the code, and not=
 clean up the surrounding areas (or better integrate with them).

> I was too steep with the policy above. It's not exactly like that in the
> strict sense. It's always case by case like for any commit. However, it
> is good to remember that "ugliness" does not cause regressions.

Not by itself, no. But it causes cognitive strain while working with the co=
de, and that might lead to bugs.

Alexander

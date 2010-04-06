Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 2DCB3B7D60
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 06:05:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
Date: Tue, 6 Apr 2010 14:03:38 -0600
In-Reply-To: <k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
	<1270573233.2081.47.camel@edumazet-laptop>
	<bf8eac92-5008-4c1f-9b99-0199e62436fa@SG2EHSMHS010.ehs.local>
	<k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <86f149a4-088a-4c37-ba6f-a49dbc9acbeb@VA3EHSMHS033.ehs.local>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, John Tyner <jtyner@cs.ucr.edu>,
	michal.simek@petalogix.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Tuesday, April 06, 2010 12:54 PM
> To: John Linn
> Cc: Eric Dumazet; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; jwboye=
r@linux.vnet.ibm.com;
> john.williams@petalogix.com; michal.simek@petalogix.com; John Tyner
> Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
> =

> On Tue, Apr 6, 2010 at 11:11 AM, John Linn <John.Linn@xilinx.com> wrote:
> >> -----Original Message-----
> >> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> >> Sent: Tuesday, April 06, 2010 11:01 AM
> >> To: John Linn
> >> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; grant.likely@secr=
etlab.ca;
> >> jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com; michal.simek@=
petalogix.com; John Tyner
> >> Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
> >>
> >> Le mardi 06 avril 2010 =E0 10:12 -0600, John Linn a =E9crit :
> >> > > -----Original Message-----
> >> > > From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> >> > > Sent: Monday, April 05, 2010 3:30 PM
> >> > > To: John Linn
> >> > > Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; grant.likely@=
secretlab.ca;
> >> > > jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com; michal.si=
mek@petalogix.com; John Tyner
> >> > > Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC dri=
ver
> >> > >
> >> > > Le lundi 05 avril 2010 =E0 15:11 -0600, John Linn a =E9crit :
> >> > > > This patch adds support for using the LL TEMAC Ethernet driver o=
n
> >> > > > non-Virtex 5 platforms by adding support for accessing the Soft =
DMA
> >> > > > registers as if they were memory mapped instead of solely throug=
h the
> >> > > > DCR's (available on the Virtex 5).
> >> > > >
> >> > > > The patch also updates the driver so that it runs on the MicroBl=
aze.
> >> > > > The changes were tested on the PowerPC 440, PowerPC 405, and the=

> >> > > > MicroBlaze platforms.
> >> > > >
> >> > > > Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
> >> > > > Signed-off-by: John Linn <john.linn@xilinx.com>
> >> > > >
> >> > > > ---
> >> > >
> >> > > > +/* Align the IP data in the packet on word boundaries as MicroB=
laze
> >> > > > + * needs it.
> >> > > > + */
> >> > > > +
> >> > > > =A0#define XTE_ALIGN =A0 =A0 =A0 32
> >> > > > -#define BUFFER_ALIGN(adr) ((XTE_ALIGN - ((u32) adr)) % XTE_ALIG=
N)
> >> > > > +#define BUFFER_ALIGN(adr) ((34 - ((u32) adr)) % XTE_ALIGN)
> >> > > >
> >> > >
> >> > > Very interesting way of doing this, but why such convoluted thing =
?
> >> >
> >> > This is trying to align for a cache line (32 bytes) before my change=
.
> >> >
> >> > My change was then also making it align the IP data on a word bounda=
ry.
> >> >
> >> > >
> >> > > Because of the % 32, this is equivalent to :
> >> > >
> >> > > #define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)
> >> > >
> >> >
> >> > Yes, but I'm not sure that's clearer IMHO.
> >> >
> >> > > But wait, dont we recognise the magic constant NET_IP_ALIGN ?
> >> >
> >> > Yes it could be used. =A0I'm struggling with how to make this all be=
 clearer.
> >> >
> >>
> >> I am not saying its clearer, I am saying we have a standard way to
> >> handle this exact problem (aligning rcvs buffer so that IP header is
> >> aligned)
> >>
> >> There is no need to invent new ones, this makes reviewing of this driv=
er
> >> more difficult.
> =

> Hold on.... BUFFER_ALIGN is being used to align the DMA buffer on a
> cache line boundary.  I don't think netdev_alloc_skb() makes any
> guarantees about how the start of the IP header lines up against cache
> line boundaries.  The amount of padding needed is not known until an
> skbuff is obtained from netdev_alloc_skb(), and
> netdev_alloc_skb_ip_align() can only handle a fixed size padding,
> =

> It doesn't look like netdev_alloc_skb_ip_align() is the right thing in
> this regard.
> =

> >> > How about this?
> >> > #define BUFFER_ALIGN(adr) (((XTE_ALIGN + NET_IP_ALIGN) - ((u32) adr)=
) % XTE_ALIGN)
> >> >
> >>
> >> Sorry, I still dont understand why you need XTE_ALIGN + ...
> >>
> >> ((A + B) - C) % A =A0 is equal to (B - C) % A
> >>
> >> Which one is more readable ?
> >
> > I'm fine with your suggestion.
> >
> > #define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)
> >
> >>
> >> Please take a look at existing and clean code, no magic macro, and we
> >> can understand the intention.
> >>
> >> find drivers/net | xargs grep -n netdev_alloc_skb_ip_align
> >>
> >>
> >
> > Yes I see how it's used, but it only allows you to reserve 2 bytes in t=
he skb with no options.
> =

> Eric is here.  The mod operation means that BUFFER_ALIGN using either
> 2 or 34 is equivalent.
> =

> g.

I can spin another patch with the following and with Grant's Kconfig change=
s, just looking for confirmation that's acceptable.

#define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)

Thanks,
John




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

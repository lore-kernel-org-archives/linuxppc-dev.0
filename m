Return-Path: <ryanarn@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78E972C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 00:38:58 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ryanarn@us.ibm.com>;
 Mon, 6 May 2013 08:38:55 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 50CB93E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 08:38:36 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46EceIY112632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 08:38:46 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46EfWel014675
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 08:41:32 -0600
In-Reply-To: <20130503234019.GE8561@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR,
 EBB and ISEL bits in HWCAP2
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Message-ID: <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Mon, 6 May 2013 09:38:34 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF1F0DFDD51388f9e8a93df938690918c09BBF1F0DFDD5138"
Cc: Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Peter Bergner <bergner@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF1F0DFDD51388f9e8a93df938690918c09BBF1F0DFDD5138
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote on 05/03/2013 06:40=
:19
PM:

> Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 05/03/2013 06:40 PM
>
> To
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> cc
>
> Michael Neuling <michael.neuling@au1.ibm.com>, Michael R Meissner/
> Cambridge/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS, Peter
> Bergner/Rochester/IBM@IBMUS, Ryan Arnold/Rochester/IBM@IBMUS,
> linuxppc-dev@lists.ozlabs.org
>
> Subject
>
> Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
> bits in HWCAP2
>
> On 04.05.2013 [09:23:51 +1000], Benjamin Herrenschmidt wrote:
> > On Fri, 2013-05-03 at 16:19 -0700, Nishanth Aravamudan wrote:
> > > +/* in AT_HWCAP2 */
> > > +#define PPC_FEATURE2_ARCH_2_07         0x80000000
> > > +#define PPC_FEATURE2_HTM               0x40000000
> > > +#define PPC_FEATURE2_DSCR              0x20000000
> > > +#define PPC_FEATURE2_EBB               0x10000000
> > > +#define PPC_FEATURE2_ISEL              0x08000000
> >
> > Should we "adjust" (ie filter out) some of these based
> > on CONFIG_ options (such as transactional memory enabled,
> > EBB supported by the hypervisor, etc...) ?
>
> Err, yeah, that seems reasonable :) However, it seems like glibc uses=

> these values rather directly so it knows what bits to check for each
> feature. Therefore, it seems like it would be better to do the
> ifdeffery/checking in the user in cputable.c, but that seems like it
> could get quite complicated.
>
> Would it be ok (I guess I'm asking Ryan & co. here) to have an #ifdef=
 in
> the definition that may or may not mean the bit is set in the aux
> vector, but the bit, if set, would always be the same bit?

My understanding was that these bits being 'on' is an indication of wha=
t
features the hardware supports (or what the kernel emulates) and a not =
an
indication of whether that facility is currently enabled or not.  If th=
e
hardware supports a particular feature but it is not enabled I'd expect=

that user-space usage of that feature would cause the kernel to trap on=
 a
facility availability exception (which is how Altivec/VMX is implemente=
d,
being defaulted to turned off).

Otherwise there's no way I could know whether an ISA [optional] feature=
 is
actually available on a particular machine.

And yes, the bits can't change.  My usage of hwcap.h has to coincide wi=
th
the kernel's asm/cputable.h
Ryan=

--0__=09BBF1F0DFDD51388f9e8a93df938690918c09BBF1F0DFDD5138
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt><font size=3D"2">Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com=
&gt; wrote on 05/03/2013 06:40:19 PM:<br>
<br>
&gt; Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com&gt; </font></tt><b=
r>
<tt><font size=3D"2">&gt; 05/03/2013 06:40 PM</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; To</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt;</font></tt=
><br>
<tt><font size=3D"2">&gt; <br>
&gt; cc</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; Michael Neuling &lt;michael.neuling@au1.ibm.com&gt;, Michael R Mei=
ssner/<br>
&gt; Cambridge/IBM@IBMUS, Steve Munroe/Rochester/IBM@IBMUS, Peter <br>
&gt; Bergner/Rochester/IBM@IBMUS, Ryan Arnold/Rochester/IBM@IBMUS, <br>=

&gt; linuxppc-dev@lists.ozlabs.org</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; Subject</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and IS=
EL<br>
&gt; bits in HWCAP2</font></tt><br>
<tt><font size=3D"2">&gt; <br>
&gt; On 04.05.2013 [09:23:51 +1000], Benjamin Herrenschmidt wrote:<br>
&gt; &gt; On Fri, 2013-05-03 at 16:19 -0700, Nishanth Aravamudan wrote:=
<br>
&gt; &gt; &gt; +/* in AT_HWCAP2 */<br>
&gt; &gt; &gt; +#define PPC_FEATURE2_ARCH_2_07 &nbsp; &nbsp; &nbsp; &nb=
sp; 0x80000000<br>
&gt; &gt; &gt; +#define PPC_FEATURE2_HTM &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; 0x40000000<br>
&gt; &gt; &gt; +#define PPC_FEATURE2_DSCR &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;0x20000000<br>
&gt; &gt; &gt; +#define PPC_FEATURE2_EBB &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; 0x10000000<br>
&gt; &gt; &gt; +#define PPC_FEATURE2_ISEL &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;0x08000000<br>
&gt; &gt; <br>
&gt; &gt; Should we &quot;adjust&quot; (ie filter out) some of these ba=
sed<br>
&gt; &gt; on CONFIG_ options (such as transactional memory enabled,<br>=

&gt; &gt; EBB supported by the hypervisor, etc...) ?<br>
&gt; <br>
&gt; Err, yeah, that seems reasonable :) However, it seems like glibc u=
ses<br>
&gt; these values rather directly so it knows what bits to check for ea=
ch<br>
&gt; feature. Therefore, it seems like it would be better to do the<br>=

&gt; ifdeffery/checking in the user in cputable.c, but that seems like =
it<br>
&gt; could get quite complicated.<br>
&gt; <br>
&gt; Would it be ok (I guess I'm asking Ryan &amp; co. here) to have an=
 #ifdef in<br>
&gt; the definition that may or may not mean the bit is set in the aux<=
br>
&gt; vector, but the bit, if set, would always be the same bit?<br>
</font></tt><br>
<tt><font size=3D"2">My understanding was that these bits being 'on' is=
 an indication of what features the hardware supports (or what the kern=
el emulates) and a not an indication of whether that facility is curren=
tly enabled or not. &nbsp;If the hardware supports a particular feature=
 but it is not enabled I'd expect that user-space usage of that feature=
 would cause the kernel to trap on a facility availability exception (w=
hich is how Altivec/VMX is implemented, being defaulted to turned off).=
</font></tt><br>
<br>
<tt><font size=3D"2">Otherwise there's no way I could know whether an I=
SA [optional] feature is actually available on a particular machine.</f=
ont></tt><br>
<br>
<tt><font size=3D"2">And yes, the bits can't change. &nbsp;My usage of =
hwcap.h has to coincide with the kernel's asm/cputable.h</font></tt><br=
>
<tt><font size=3D"2">Ryan</font></tt></body></html>=

--0__=09BBF1F0DFDD51388f9e8a93df938690918c09BBF1F0DFDD5138--

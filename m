Return-Path: <tanderson@curtisswright.com>
Received: from mail152.messagelabs.com (mail152.messagelabs.com
	[216.82.253.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail152.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9B817B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:27:15 +1000 (EST)
From: "Anderson, Trevor" <tanderson@curtisswright.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>, Andrew Morton
	<akpm@linux-foundation.org>
Date: Wed, 15 Sep 2010 14:27:02 -0400
Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 switches
Message-ID: <1682399277683944B902B3657D2FCE216544F4A1F0@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-10-git-send-email-alexandre.bounine@idt.com>
	<20100914152049.8d42783f.akpm@linux-foundation.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520130321F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520130321F@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Keep it in please. We lurkers in the embedded community do use the per-por=
t routing tables.
One of the problems with SRIO switch tables is that access to routes is no=
t atomic; we can use
restricted access to per-port routing tables to reduce the risk of interfe=
rence. And we still use
the Global table during enumeration.




> -----Original Message-----
> From: linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.or=
g [mailto:linuxppc-dev-
> bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.org] On Behalf Of Bou=
nine, Alexandre
> Sent: Wednesday, September 15, 2010 8:31 AM
> To: Andrew Morton
> Cc: linux-kernel@vger.kernel.org; Thomas Moll; linuxppc-dev@lists.ozlabs=
.org
> Subject: RE: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 swit=
ches
>
> Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > The handling of `table' is strange.  One would expect the caller of
> > this function to provide the correct table index, and for the caller
> to
> > increment that index at an appropriate time.
>
> Handling of the 'table' parameter is hardware-dependent.
> RIO switches (at least all that I know) have a per-port routing tables
> (RT)
> which can be configured independently. The 'table' parameter is expected=

> to match
> to the port number (or broadcast if GLOBAL).
> The route set/get routines in this file use the standard route setting
> registers
> defined by RapidIO spec, but switches have internal mapping into an
> individual
> port RT or broadcast capability into all port RTs.
> Unfortunately, this HW design uses index 0 as a broadcast option that
> offsets
> per-port RT numbering by +1 (port 0 =3D=3D table index 1, etc.).
>
> > So I take a look around but cannot find any means by which
> > ->add_entry() is called with anything other than RIO_GLOBAL_TABLE.
> > Maybe I missed something.  Is this all dead code?
>
> The current RIO enumeration uses only the global routing table concept.
> In the past, I had a temptation to remove the 'table' parameter and make=

> RT settings simpler. But now I see scenarios when per-port routing
> tables
> may be configured by usermode apps. This capability may be implemented
> through sysfs attributes (probably I have to add them to make standard).=

> Example: system that uses dual-port endpoints which can be enumerated by=

> the host through one RIO port (management) and have individual routes
> configured for the second port (data path).
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

_______________________________________________________________________
This e-mail and any files transmitted with it are proprietary and intended=
 solely for the use of the individual or entity to whom they are addressed=
. If you have reason to believe that you have received this e-mail in erro=
r, please notify the sender and destroy this email and any attached files.=
 Please note that any views or opinions presented in this e-mail are solel=
y those of the author and do not necessarily represent those of the Curtis=
s-Wright Corporation or any of its subsidiaries.  Documents attached heret=
o may contain technology subject to government export regulations. Recipie=
nt is solely responsible for ensuring that any re-export, transfer or disc=
losure of this information is in accordance with applicable government exp=
ort regulations.  The recipient should check this e-mail and any attachmen=
ts for the presence of viruses. Curtiss-Wright Corporation and its subsidi=
aries accept no liability for any damage caused by any virus transmitted b=
y this e-mail.

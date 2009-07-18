Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D302CB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jul 2009 04:37:57 +1000 (EST)
Received: by gxk4 with SMTP id 4so2496771gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 11:37:54 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090718180448.GA3252@oksana.dev.rtsoft.ru>
References: <20090717065220.15652.93331.stgit@localhost.localdomain>
	<20090718180448.GA3252@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 18 Jul 2009 12:37:34 -0600
Message-ID: <fa686aa40907181137v4a0ed1ednfed3194d1308296a@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: Revive fixed link support
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: leoli@freescale.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	afleming@freescale.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 18, 2009 at 12:04 PM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> On Fri, Jul 17, 2009 at 01:31:25AM -0600, Grant Likely wrote:
> [...]
>> Part of the problem I think is that the phylib code merges two separate
>> constructs; the construct of an MDIO bus (on which many device may
>> reside, not all of them PHYs), and the construct of an MII link whose
>> speed and configuration need to be manipulated. =A0I've run into problem=
s
>> myself on how best to handle things like Ethernet switches which
>> definitely do not behave like PHYs and the phylib state machine cannot
>> be used on them. =A0It seems to me that the whole 'dummy phy' approach
>> is just an artifact of the phylib model not being quite right yet.
>
> Yep. With a bit of phylib rework we can remove all the MDIO emulation
> stuff from phy/fixed.c driver, and leave there just speed/duplex/pause
> assignments.
>
> Though, I still believe that we should avoid two code paths in the
> drivers. One of the code paths will be constantly broken if we do so.

Yes, I agree.  Splitting the concepts also has the added advantage
that non-phy devices will have an interface to manipulate the link
speed without modifying drivers.

>> Anton, once again I don't have hardware to test this, so I rely on you
>> to tell be if I screwed it up. =A0It has been compile tested.
>
> Works fine here, thanks!

Awesome.  Dave, can you please pick up this series?

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

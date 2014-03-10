Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id DF73E2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Mar 2014 20:54:32 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28445-01 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Mar 2014 09:54:23 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'josh@joshtriplett.org'" <josh@joshtriplett.org>, Joe Perches
 <joe@perches.com>
Subject: RE: rfc: checkpatch logical line continuations (was IBM Akebono:
 Add support for a new PHY interface to the IBM emac driver)
Date: Mon, 10 Mar 2014 09:53:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6D8E55@AcuExch.aculab.com>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
 <20140307.154142.488351276799532264.davem@davemloft.net>
 <1394226164.16156.96.camel@joe-AO722> <20140307213017.GA18769@cloud>
In-Reply-To: <20140307213017.GA18769@cloud>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dan Carpenter <error27@gmail.com>,
 "alistair@popple.id.au" <alistair@popple.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: josh@joshtriplett.org
> On Fri, Mar 07, 2014 at 01:02:44PM -0800, Joe Perches wrote:
> > On Fri, 2014-03-07 at 15:41 -0500, David Miller wrote:
> > > From: Alistair Popple <alistair@popple.id.au>
> > > Date: Thu,  6 Mar 2014 14:52:25 +1100
> > >
> > > > +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> > > > +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);
> > >
> > > When an expression spans multiple lines, the lines should end with
> > > operators rather than begin with them.
> >
> > That's not in CodingStyle currently.
>=20
> It's also not even remotely consistent across existing kernel code, and
> it isn't obvious that there's a general developer consensus on the
> "right" way to write it.

My personal preference (which counts for nothing here) is to put
the operators at the start of the continuation like in order to
make it more obvious that it is a continuation.

The netdev rules are particularly problematical for code like:
        if (tst(foo, foo2, foo3, ...) && ....... &&
                tst2(......) && tst3()) {
                baz(....);
where a scan read of the LHS gives the wrong logic.

At least we don't have a coding style that allows very long lnes
an puts } and { on their own lines - leading to:
                ...
        }
        while (foo(...) && bar(...) && ..... /* very long line falls off sc=
reen */
        {
                int x;
Is that the top or bottom of a loop?

	David

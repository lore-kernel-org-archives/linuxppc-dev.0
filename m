Return-Path: <n.eicker@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 7914ADDDF2
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 20:45:55 +1100 (EST)
From: Norbert Eicker <n.eicker@fz-juelich.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] spidernet: Fix problem sending IP fragments
Date: Mon, 12 Mar 2007 10:45:48 +0100
References: <20070308231556.GE30703@austin.ibm.com>
	<200703100016.58469.n.eicker@fz-juelich.de>
	<Pine.LNX.4.62.0703120927570.15144@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0703120927570.15144@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <200703121045.49211.n.eicker@fz-juelich.de>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, 12. March 2007 09:28, Geert Uytterhoeven wrote:
> On Sat, 10 Mar 2007, Norbert Eicker wrote:
> > On Friday, 9. March 2007 17:53, Jeff Garzik wrote:
> > > Linas Vepstas wrote:
> > > > Please apply. The rather long patch description is from the
> > > > submitter, Norbert Eicker, I don't know if that's alright, or
> > > > if I should ask to have it trimmed.
> > > >
> > > > Thanks,
> > > > --linas
> > > >
> > > > From: Norbert Eicker <n.eicker@fz-juelich.de>
> > > >
> > > >
> > > > Signed-off-by: Norbert Eicker <n.eicker@fz-juelich.de>
> > > > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> > >
> > > are you sure it can't send out fragmented IP frames?  what's
> > > really going on here?
> >
> > Pretty sure that fragmented IP frames are not send out. Here's a
> > small test using ttcp and tcpdump reproducing the problem (I assume
> > a MTU of 1500):
>
> Hence if I understand that correctly, NFS over UDP doesn't work at
> all as NFS uses 8 KiB UDP packets by default?

NFS seems to work but considering what I saw in tcpdump it uses TCP 
instead of UDP. I have not yet found out why NFS seems to default to 
TCP on Cell (the man-pages claims that UDP is the default).

If I explicitely demand to use UDP it indeed does not work at all.

Again if I use tcpdump on both sides, I see that the NFS-server claims 
to send out IP fragments containing the UDP datagrams (larger than 
MTU). The NFS-client does not see any of these fragments.

Using the patched spidernet module makes NFS work like a charm.


Norbert
-- 
Fon ++49-(0)2461/61-1492
http://www.fz-juelich.de

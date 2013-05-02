Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF3172C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 03:02:43 +1000 (EST)
Date: Thu, 2 May 2013 12:02:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
To: Alan Modra <amodra@gmail.com>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
In-Reply-To: <20130501035425.GD5221@bubble.grove.modra.org> (from
 amodra@gmail.com on Tue Apr 30 22:54:25 2013)
Message-ID: <1367514145.24411.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Eric Dumazet <eric.dumazet@gmail.com>, netdev <netdev@vger.kernel.org>,
 Ambrose Feinstein <ambrose@google.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2013 10:54:25 PM, Alan Modra wrote:
> On Tue, Apr 30, 2013 at 07:24:20PM -0700, Eric Dumazet wrote:
> > 	li 11,1
> > 	ld 0,0(9)
> > 	rldimi 0,11,31,32
> > 	std 0,0(9)
> > 	blr
> > 	.ident	"GCC: (GNU) 4.6.3"
> >
> > You can see "ld 0,0(9)" is used : its a 64 bit load.
>=20
> Yup.  This is not a powerpc64 specific problem.  See
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D52080
> Fixed in 4.8.0 and 4.7.3.

FWIW (especially if a GCC version check is added), it seems to have =20
been fixed as far back as 4.7.1, not just 4.7.3.

-Scott=

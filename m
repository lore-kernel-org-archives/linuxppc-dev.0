Return-Path: <matthias@kaehlcke.net>
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net
	[217.70.178.78]) by ozlabs.org (Postfix) with ESMTP id BD825B7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 21:26:27 +1100 (EST)
Date: Wed, 20 Jan 2010 11:21:45 +0100
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
Message-ID: <20100120102145.GV16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Johnny Hung <johnny.hacking@gmail.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Wed, Jan 20, 2010 at 08:57:44AM +0100 Marco Stornelli ha dit:

> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
> > 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
> >> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
> >>
> > I consider to use ramdisk as rootfs because worry about wrong
> > operation in rootfs (is use jffs2 rootfs) and it will cause system
> > boot up failed.
> > Another query, does the syslogd/klogd log files also store in jffs2
> > rootfs? Write to jffs2 frequently will reduce flash life cycle.
> >
> > BRs, H. Johnny
> >>
> >> --
> 
> In general a good splitting for rootfs could be: squashfs for rootfs,
> tmpfs for volatile data (/tmp), ubifs (with a flash partition) for
> "strong" permanent data (/etc, ....) and pramfs for "light" permanent
> data (/var/log, .....).

if ubifs is a good choice depends on the size of the partition, iirc
it has a significant overhead for very small partitions.

once using ubi it could be interesting to set up the read-only rootfs
partition upon ubi in order to spread the wear out over a maximum of blocks.

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

            You can chain me, you can torture me, you can even
          destroy this body, but you will never imprison my mind
                            (Mahatma Gandhi)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-

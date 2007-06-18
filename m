Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 72235DDEF6
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 22:25:51 +1000 (EST)
Subject: Re: [PATCH] rheap: eliminates internal fragments caused by alignment
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
In-Reply-To: <03F6FDB0-3D7B-4272-AC1C-8E06F82DD815@gmail.com>
References: <46766C91.6090903@freescale.com>
	<03F6FDB0-3D7B-4272-AC1C-8E06F82DD815@gmail.com>
Content-Type: text/plain
Date: Mon, 18 Jun 2007 14:25:49 +0200
Message-Id: <1182169549.2969.20.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-18 at 15:14 +0300, Pantelis Antoniou wrote:
> Hi Li,
> 
> The patch appears fine at first glance.
> 
> I'm really curious what kind of alignment do you use in order to have so
> much wasted space that re-inserting the leftovers makes so much of a
> difference.
This I what you get for eth0 with patch,
all hex, decimal within()
MURAM alloc, start:400, size:200(512), align:8(8)
MURAM alloc, start:600, size:208(520), align:8(8)
MURAM alloc, start:880, size:80(128), align:80(128)
MURAM alloc, start:900, size:1a0(416), align:100(256)
MURAM alloc, start:aa0, size:40(64), align:20(32)
MURAM alloc, start:b00, size:100(256), align:100(256)
MURAM alloc, start:c00, size:a0(160), align:100(256)
MURAM alloc, start:cc0, size:c(12), align:40(64)
MURAM alloc, start:cd0, size:30(48), align:8(8)
MURAM alloc, start:d00, size:80(128), align:80(128)
MURAM alloc, start:d80, size:80(128), align:80(128)
MURAM alloc, start:e00, size:80(128), align:80(128)
MURAM alloc, start:e80, size:80(128), align:80(128)
MURAM alloc, start:f00, size:40(64), align:40(64)
MURAM alloc, start:f40, size:40(64), align:40(64)
MURAM alloc, start:f80, size:40(64), align:40(64)
MURAM alloc, start:fc0, size:40(64), align:40(64)
MURAM alloc, start:1000, size:5d(93), align:4(4)

And this is what you get without patch:
MURAM alloc, start:1400, size:200(512), align:8(8)
MURAM alloc, start:1608, size:208(520), align:8(8)
MURAM alloc, start:1880, size:80(128), align:80(128)
MURAM alloc, start:1a00, size:1a0(416), align:100(256)
MURAM alloc, start:1bc0, size:40(64), align:20(32)
MURAM alloc, start:1d00, size:100(256), align:100(256)
MURAM alloc, start:1f00, size:a0(160), align:100(256)
MURAM alloc, start:1fc0, size:c(12), align:40(64)
MURAM alloc, start:2000, size:30(48), align:8(8)
MURAM alloc, start:2080, size:80(128), align:80(128)
MURAM alloc, start:2180, size:80(128), align:80(128)
MURAM alloc, start:2280, size:80(128), align:80(128)
MURAM alloc, start:2380, size:80(128), align:80(128)
MURAM alloc, start:2440, size:40(64), align:40(64)
MURAM alloc, start:24c0, size:40(64), align:40(64)
MURAM alloc, start:2540, size:40(64), align:40(64)
MURAM alloc, start:25c0, size:40(64), align:40(64)
MURAM alloc, start:262c, size:5d(93), align:4(4)

 Jocke

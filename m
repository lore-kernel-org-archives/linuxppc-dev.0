Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Date: Tue, 24 Oct 2006 21:58:32 +0200
References: <20061024160140.452484000@arndb.de>
	<200610242107.44115.arnd@arndb.de>
	<1161719603.8946.84.camel@farscape>
In-Reply-To: <1161719603.8946.84.camel@farscape>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610242158.33069.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 October 2006 21:53, Will Schmidt wrote:
> Hey Arnd,
> =C2=A0 =C2=A0just curiosity.. =C2=A0 What was the behavior before this pa=
tch? =C2=A0 just
> leaving a few (0 - 3) characters behind?

It transfers more bytes than requested on a read. If you asked for
four bytes, you got eight.

Note: one nasty property of this file in spufs is that you can only
read multiples of four bytes in the first place, there is no way to
atomically put back a few bytes into the hardware register, so reading
less than four bytes returns -EINVAL. Asking for more than four
should return the largest possible multiple of four.

	Arnd <><

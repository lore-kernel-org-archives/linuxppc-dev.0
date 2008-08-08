Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [PATCH 2/2] Cell OProfile: SPU mutex lock fix, version 4
Date: Fri, 8 Aug 2008 15:26:20 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
In-Reply-To: <1217620879.15667.145.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808081526.21405.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 01 August 2008, Carl Love wrote:
> If an error occurs on opcontrol start, the event and per cpu buffers=20
> are released. =A0If later opcontrol shutdown is called then the free
> function will be called again to free buffers that no longer=20
> exist. =A0This results in a kernel oops. =A0The following changes
> prevent the call to delete buffers that don't exist.
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
>=20

vfree(NULL) is defined to be legal, so you don't need to check the
argument for being non-NULL, just set it to NULL after the free.

	Arnd <><

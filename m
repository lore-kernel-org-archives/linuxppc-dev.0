Return-Path: <galak@kernel.crashing.org>
Message-Id: <21BA9149-6948-42C0-9F76-033185BB5296@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: subrata@linux.vnet.ibm.com
In-Reply-To: <1239285022.5188.63.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [BUILD FAILURE 01] Next April 9 : PPC64 randconfig
	[drivers/net/fs_enet/fs_enet-main.c]
Date: Thu, 9 Apr 2009 09:28:13 -0500
References: <1239285022.5188.63.camel@subratamodak.linux.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, linux-net@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2009, at 8:50 AM, Subrata Modak wrote:

> Observed the following build error:
>
> drivers/net/fs_enet/fs_enet-main.c: In function =91fs_enet_probe=92:
> drivers/net/fs_enet/fs_enet-main.c:1096: error: =91struct net_device=92 =
=20
> has
> no member named =91open=92
> drivers/net/fs_enet/fs_enet-main.c:1097: error: =91struct net_device=92 =
=20
> has
> no member named =91hard_start_xmit=92
> drivers/net/fs_enet/fs_enet-main.c:1098: error: =91struct net_device=92 =
=20
> has
> no member named =91tx_timeout=92
> drivers/net/fs_enet/fs_enet-main.c:1100: error: =91struct net_device=92 =
=20
> has
> no member named =91stop=92
> drivers/net/fs_enet/fs_enet-main.c:1101: error: =91struct net_device=92 =
=20
> has
> no member named =91get_stats=92
> drivers/net/fs_enet/fs_enet-main.c:1102: error: =91struct net_device=92 =
=20
> has
> no member named =91set_multicast_list=92
> drivers/net/fs_enet/fs_enet-main.c:1111: error: =91struct net_device=92 =
=20
> has
> no member named =91do_ioctl=92
> make[3]: *** [drivers/net/fs_enet/fs_enet-main.o] Error 1
> make[2]: *** [drivers/net/fs_enet] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
>
> Regards--
> Subrata
>
> <randconfig1-ppc64-next20090409.txt>

This is because CONFIG_COMPAT_NET_DEV_OPS isnt set and needs to be for =20=

this driver to build.  I've asked the netdev guys about either fixing =20=

the driver or adding the proper thing to Kconfig to select =20
CONFIG_COMPAT_NET_DEV_OPS.

- k=

Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 735FFDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 02:33:33 +1100 (EST)
Message-ID: <45B62AA7.4020306@freescale.com>
Date: Tue, 23 Jan 2007 09:32:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andre Haupt <haupt.andre@gmx.de>
Subject: Re: nfs mounting problem
References: <OFEEBC95A7.C19B5826-ON6525726C.004962C8-6525726C.00497146@lntemsys.com>
	<45B61459.1030507@gmx.de>
In-Reply-To: <45B61459.1030507@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org,
	Manjunath AM <Manjunath.AM@Lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andre Haupt wrote:
> Also what seems a bit odd to me is that your dmesg shows no rootpath
> 
>  IP-Config: Complete:
>       device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
> gw=192.168.178.47,
>      host=cashel, domain=, nis-domain=(none),
>      bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=
> 
> On my system the complete root path is printed here.

I don't think I've ever seen the root path printed there (with nfsroot 
otherwise working), so I don't think that's the problem...  From looking 
at the code, it seems that the root path received from BOOTP is stored 
in a different variable than the path from the nfsroot boot option, and 
it's the former that gets printed there.

To Manjunath AM: does the ethernet work from U-Boot?  Can you verify 
that packets are being successfully sent and received under Linux?  If 
the only variable is the board, then the problem is probably not with 
NFS itself; there's probably something different in how the ethernet is 
hooked up on your board, or in how the board is being initialized.

-Scott

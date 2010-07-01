Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C0361007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 03:42:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o61HgkS6022347
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jul 2010 10:42:47 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o61Hr68O010060
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jul 2010 12:53:06 -0500 (CDT)
Message-ID: <4C2CD395.90409@freescale.com>
Date: Thu, 01 Jul 2010 12:42:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>	<20100629185617.GA24285@schlenkerla.am.freescale.net>	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>	<4C2B6DF5.7030403@freescale.com>	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
In-Reply-To: <AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2010 02:50 AM, Shawn Jin wrote:
> Hi Scott,
>
>> How do I find the address, reg, and range for nodes like localbus,
>> soc, eth0, cpm, serial etc.?

If your CCSRBAR is 0xfa200000, then pretty much anywhere you see 
0xff0xxxxx change it to 0xfa2xxxxx.

> I managed to proceed a little bit further.
>      Memory<-<0x0 0x8000000>  (128MB)
>      ENET0: local-mac-address<- 00:09:9b:01:58:64
>      CPU clock-frequency<- 0x7270e00 (120MHz)
>      CPU timebase-frequency<- 0x393870 (4MHz)
>      CPU bus-frequency<- 0x3938700 (60MHz)
>
>      zImage starting: loaded at 0x00400000 (sp: 0x07d1ccd0)
>      Allocating 0x186bdd bytes for kernel ...
>      gunzipping (0x00000000<- 0x0040c000:0x00591c30)...done 0x173b18 bytes
>
>      Linux/PowerPC load: root=/dev/ram
>      Finalizing device tree... flat tree at 0x59e300
>
> The gdb showed deadbeef.
>      (gdb) target remote ppcbdi:2001
>      Remote debugging using ppcbdi:2001
>      0xdeadbeef in ?? ()
>      (gdb)
>
> The kernel doesn't seem to start. What could go wrong here?

Pretty much anything. :-)

Make sure that you've got Linux platform code enabled that matches the 
top-level compatible of your device tree.  Try enabling 
PPC_EARLY_DEBUG_CPM, making sure to update PPC_EARLY_DEBUG_CPM_ADDR to 
0xfa202008.

-Scott

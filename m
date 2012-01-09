Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4926BB6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 01:59:28 +1100 (EST)
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com>
References: <OF5FE90C20.B5971F88-ONC1257980.004EAA90-C1257980.004EC4DA@transmode.se>
 <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com>
Subject: RE: Mac address in the DT
To: <smitha.vanga@wipro.com>
Message-ID: <OFD20D0CBF.F9E1F602-ONC1257980.0051D919-C1257980.005257BD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 9 Jan 2012 15:59:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<smitha.vanga@wipro.com> wrote on 2012/01/09 15:28:54:
>
>
> Hi Joakim,
>
> I have tried it but it doesn't work.
>
> Just now found that with single ' quotes the entire sequence it works.
> >Setenv set_mac 'cp 0xffec0000 0x100000 1024;fdt addr 0xc00000 8192;fdt set /soc8272@f0000000/ethernet@24000 mac-address "[00 44 00 55 00 66]";erase 0xffec0000 0xffec4000;cp 0xc00000 0xffec0000 1024;bootm 0xfe060000 - 0xffec0000'
>
> > run set_mac
>
> For the above command I want to replace the mac address with the ethaddr> How do I do that. I tried $ethaddr but I get extra : characters.
>
> >Setenv set_mac 'cp 0xffec0000 0x100000 1024;fdt addr 0xc00000 8192;fdt set /soc8272@f0000000/ethernet@24000 mac-address $ethaddr;erase 0xffec0000 0xffec4000;cp 0xc00000 0xffec0000 1024;bootm 0xfe060000 - 0xffec0000'

Of course you do, ethaddr has a different syntax and contains :

Anyway you should not have to set mac address manually like you do, u-boot will do it for you if you
have configured u-boot correctly and have a proper dtb tree. Check the u-boot code and the many dts files in linux
under arch/powerpc/boot/dts

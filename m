Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 48D74B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 03:20:23 +1000 (EST)
In-Reply-To: <929D3CED81F34E43887A393170D66FB9065B79F5@GBRSUN01MS002.eu.xerox.net>
References: <OFDFDC3B6C.CE37E2BC-ONC1257A1A.00698754-C1257A1A.0069E657@transmode.se>
 <929D3CED81F34E43887A393170D66FB9065B79F5@GBRSUN01MS002.eu.xerox.net>
Subject: RE: reserving memory using OF rsvmap feature?
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Message-ID: <OFE7DCDFFE.1933014B-ONC1257A1B.005F1894-C1257A1B.005F3E40@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 Jun 2012 19:20:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Jenkins, Clive" <Clive.Jenkins@xerox.com> wrote on 2012/06/12 17:48:15:
>
> > Is it possible to reserve some memory using OF rsvmap such that Linux
> > will not touch this area at all? Think of is as warm start stash area
> > were one could store data which should survive a reboot.
>
> Yes, I guess it should be possible, but you need to take care where you
> place this block so it does not get overwritten during the boot process.
> This depends on how your bootloader is set up to place images in memory,
> decompress them etc.
>
> I don't know about OF, but in U-Boot use the function fdt_add_mem_rsv()
> in file
> http://git.denx.de/?p=u-boot.git;a=blob;f=lib/libfdt/fdt_rw.c
>
> // Reserve the memory location of the framebuffer + descriptor page.
> if (fdt_add_mem_rsv(working_fdt, fbinfo->smem_start,
>                     (fbinfo->smem_len + 0x1FFF) & 0xFFFFF000))
>    printf("ERROR: could not reserve FB memory in device tree\n");
>
> In my powerpc_e500v2 systems this block is located at 64MiB
> (0x04000000).

Thanks, this was what I was looking at too. I plan to use u-boots PRAM feature
and reserve memory at the end of RAM.

 Jocke

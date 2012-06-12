Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR001.ACS-INC.COM (usa7109mr001.acs-inc.com
 [63.101.151.9])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com",
 Issuer "USERTrust Legacy Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBDDEB6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 01:58:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: reserving memory using OF rsvmap feature?
Date: Tue, 12 Jun 2012 16:48:15 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB9065B79F5@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <OFDFDC3B6C.CE37E2BC-ONC1257A1A.00698754-C1257A1A.0069E657@transmode.se>
References: <OFDFDC3B6C.CE37E2BC-ONC1257A1A.00698754-C1257A1A.0069E657@transmode.se>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Is it possible to reserve some memory using OF rsvmap such that Linux
> will not touch this area at all? Think of is as warm start stash area
> were one could store data which should survive a reboot.

Yes, I guess it should be possible, but you need to take care where you
place this block so it does not get overwritten during the boot process.
This depends on how your bootloader is set up to place images in memory,
decompress them etc.

I don't know about OF, but in U-Boot use the function fdt_add_mem_rsv()
in file
http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Dlib/libfdt/fdt_rw.c

// Reserve the memory location of the framebuffer + descriptor page.
if (fdt_add_mem_rsv(working_fdt, fbinfo->smem_start,
                    (fbinfo->smem_len + 0x1FFF) & 0xFFFFF000))
	printf("ERROR: could not reserve FB memory in device tree\n");

In my powerpc_e500v2 systems this block is located at 64MiB
(0x04000000).


Clive

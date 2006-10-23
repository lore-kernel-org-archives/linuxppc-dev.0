Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4CD1567BE7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 04:57:17 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 23 Oct 2006 20:57:14 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1161474692.10524.266.camel@localhost.localdomain>
Message-ID: <20061023185714.22630@gmx.net>
MIME-Version: 1.0
References: <20060628202753.198630@gmx.net>	<s5hfyhopb0s.wl%tiwai@suse.de>	
	<20060629211513.64980@gmx.net> <s5hwtaz9fdr.wl%tiwai@suse.de>	
	<20060630182144.27980@gmx.net>  <20061019132423.270440@gmx.net>
	<1161474692.10524.266.camel@localhost.localdomain>
Subject: Crash with highmem support enabled
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get highmem support working on my AmigaOne. The machine is equipped with 1.5G RAM. Unfortunately the kernel crashes early in the boot process, so I couldn't save the crash log. But it seems to crash during the initialization of the radeonfb driver.

I guess this has something to do with the IO block mapping, which is implemented in the amigaone_setup.c file and looks like this:

{
/* Remap ISA/PCI IO space first to get it mapped by BATs. */
io_block_mapping(0xfe000000, 0xfe000000, 0x01000000, _PAGE_IO);
/* Remap ISA memory for framebuffer (U-boot framebuffer). */
io_block_mapping(0xfd000000, 0xfd000000, 0x01000000, _PAGE_IO);
/* Remap PROM I/O space to 0xfc000000, to get a window for non
 * cache coherent DMA support at 0xff100000.
 */
io_block_mapping(0xfc000000, 0xff000000, 0x01000000, _PAGE_IO);
}

The addresses below 0xfc000000 belong to the PCI memory space (0x80000000-0xfbffffff).

Thus I moved the highmem base to 0xfc000000, since the PCI memory is not ioremap'd. But the kernel still crashes.

Can somebody give me a hint how to get highmem working? I'm not sure what the real problem is, as also other platforms (PReP, sandpoint) ioremap the address space from 0xfe000000 to 0xffffffff.

Gerhard

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

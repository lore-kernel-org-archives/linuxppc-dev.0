Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AD48F2E.2C713B89@snmc.com>
Date: Wed, 11 Apr 2001 12:06:54 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Alan Wang <wung_y@sina.com>
Cc: Linuxppc-EmbeddedMaillist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem when read internal memory
References: <EBEGJCKFJMJLDPEKGAKJOEBGCAAA.wung_y@sina.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan,

It sounds as though you have already changed the value of IMAP_ADDR in
the header file for your specific board (found in linux/include/asm).
You must also make sure that your processor's boot code sets the IMMR
register to this same value before booting the Linux kernel.  Your boot
code should also setup an MMU entry for the IMMR's address by writing to
the MD_EPN register (MMU Data Effective Page Number Reg) of the PPC.
For an example of how this is done you can refer to the boot code for
the QS850 (MPC850-based board).  The source is located at
ftp://qslinux.org.  Once you uncompress the tarball you can go to
snmc/qslinux/qs850boot and view the file init_qs850.s.  Hope this helps.

Regards,
Daris Nevil
SNMC


Alan Wang wrote:
>
> Hi, all
>   we're porting linux-2.2.13 to our customized board(MPC823e). I modified some head file according
> the specification of our board such as memory map. the IMMR is set to 0xff000000. now, the kernel
> can be loaded by bootloader(written by ourselves). but inm8xx_cpm_reset() which is called in
> setup_arch:
> void m8xx_cpm_reset(uint host_page_addr)
> {
>         volatile immap_t         *imp;
>         volatile cpm8xx_t       *commproc;
>         pte_t                   *pte;
>
>         imp = (immap_t *)IMAP_ADDR;
>         commproc = (cpm8xx_t *)&imp->im_cpm;
>  this line generates a machine check exception when write/read to internal memory.
>
> why? any suggestion and comment are welcome. thank you.
>
> A.W.
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

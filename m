From: "Alan Wang" <wung_y@sina.com>
To: "Linuxppc-EmbeddedMaillist" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem when read internal memory
Date: Thu, 12 Apr 2001 00:41:45 +0800
Message-ID: <EBEGJCKFJMJLDPEKGAKJOEBGCAAA.wung_y@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all
  we're porting linux-2.2.13 to our customized board(MPC823e). I modified some head file according
the specification of our board such as memory map. the IMMR is set to 0xff000000. now, the kernel
can be loaded by bootloader(written by ourselves). but inm8xx_cpm_reset() which is called in
setup_arch:
void m8xx_cpm_reset(uint host_page_addr)
{
	volatile immap_t	 *imp;
	volatile cpm8xx_t	*commproc;
	pte_t			*pte;

	imp = (immap_t *)IMAP_ADDR;
	commproc = (cpm8xx_t *)&imp->im_cpm;
 this line generates a machine check exception when write/read to internal memory.

why? any suggestion and comment are welcome. thank you.

A.W.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

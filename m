Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "okisoftxman" <okisoftxman@hotmail.com>
To: "linux-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: about  flash_port_width
Date: Fri, 28 Feb 2003 16:52:55 +0900
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <OE14y3UiIMbhiv9sFU300001b52@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I read the flash manual about INTEL 28F640J3A.I know it has two
programming operations:Byte or Word.Byte is 8 bits and the Word is 16 bits.
    but I refer some source code in PPCBOOT(/board/nx823/flash.c),I find a
strange thing:

#define FLASH_PORT_WIDTH  ulong
#define FLASH_PORT_WIDTHV  vu_long
#endif

#define FPW  FLASH_PORT_WIDTH
#define FPWV FLASH_PORT_WIDTHV
............................

/*-----------------------------------------------------------------------
 * Write a word or halfword to Flash, returns:
 * 0 - OK
 * 1 - write timeout
 * 2 - Flash not erased
 */
static int write_data (flash_info_t *info, ulong dest, FPW data)
{
 FPWV *addr = (FPWV *)dest;
 ulong status;
 ulong start;
 int flag;

.........................

 flag = disable_interrupts();

 *addr = (FPW)0x00400040;  /* write setup */
 *addr = data;

 /* re-enable interrupts if necessary */
 if (flag)
  enable_interrupts();

........................

 return (0);
}

    Here,"data" is ulong and "*addr" is vu_long ,they are both 32 bits.Does
this mean programming operation is 32 bits?If so,it is opposition to the
FLASH manual.Why?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

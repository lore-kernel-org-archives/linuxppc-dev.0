Message-ID: <3CE0C9AE.20D27DBA@datentechnik.com>
Date: Tue, 14 May 2002 10:24:14 +0200
From: Stuerke <stefan.stuerke@datentechnik.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: TQM8260, Problems writing AMD flashes
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have a problem with the kernel driver from Wolfgang Denk,
for AMD-compatible flashes (amd_flash.c)
My configuration is the following:

Hardware: TQM8260-board (8MB of AMD-compatible flash, 64bit bus)
Kernel: linux-2.4.4-2002-03-21 (from the denx ftp server)
Kernel configuration:
...
CONFIG_FLASH=y
CONFIG_AMD_FLASH=y

If I try to copy a big image to the flash:
# flash_erase /dev/flasha2
# cp /tmp/Kernel.img /dev/flasha2

I get: "Flash write error, not fully erased at 0x....."
with variing adresses.
If I look at the flash at the failed address, I see that it is
erased correct.

I think the problem is in the following lines of amd_flash.c:

static int do_write_int(struct embedded_flash *flash, off_t offset,
u_int data)
{
  vu_char *ptr;
  int wait, wait1;
  u_int old;
...
...
  write_amd_command(flash, 0, 0xA0);
  *(vu_int *)&ptr[offset] = data;
  if (flash->bit_width == 3)    /* satisfy the remaining chips */
    *(vu_int *)&ptr[offset^4] = *(vu_int *)&ptr[offset^4];

  wait1 = wait = 0;
  while ((old = *(vu_int *)&ptr[offset]) != data) {
...
...
    }
    /* Busy wait */
  }
  return (0);
}

In the case of 64 bit bus width, the check for completion of the
write process is done only for one 32 bit word. In the case of
two parallel 32-bit flashes (like in my configuration), it is
possible that the second 32 bit word is not completely written
when the busy waiting loop is left. (Especially when you get an
interrupt between the writing of the first and the second 32 bit
word). In this case it's also possible that the function is
re-entered before the write process is completed. This will leed to
the described error.

I tried to fix the code in the way that I write the 32 bit word,
which is tested, at last. In this way an Interrupt between the
writing of the two words will not delay the writing of the untested
word. I know that this fix may not work for flash devices with
different timings.

....
  write_amd_command(flash, 0, 0xA0);
  if (flash->bit_width == 3)    /* satisfy the remaining chips */
    *(vu_int *)&ptr[offset^4] = *(vu_int *)&ptr[offset^4];
  *(vu_int *)&ptr[offset] = data;
....

My fix works after a short dirty test. But I'm not sure if this is
really sufficiant. Any comments are welcome,

thanks,
Stefan

--
-------------------------------------------------------------------------
Dipl.-Ing. Stefan Stürke        Datentechnik Intercom GmbH
Entwicklung                     Postfach 170109, 30842 Langenhagen
                                Frankenring 14, 30855 Langenhagen
-------------------------------------------------------------------------
Tel.:  +49 511 978197-635       <http://www.datentechnik.com/>
Fax.: +49 511 978197-670        <mailto:stefan.stuerke@datentechnik.com>
-------------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <scotto2hot-green@yahoo.com>
Received: from web33312.mail.mud.yahoo.com (web33312.mail.mud.yahoo.com
	[68.142.206.127]) by ozlabs.org (Postfix) with SMTP id E4F6567B56
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 03:35:21 +1000 (EST)
Message-ID: <20060728173519.55388.qmail@web33312.mail.mud.yahoo.com>
Date: Fri, 28 Jul 2006 10:35:19 -0700 (PDT)
From: scott <scotto2hot-green@yahoo.com>
Subject: using /dev/mem to talk to peripherals on VIIP system
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1827274702-1154108119=:54274"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1827274702-1154108119=:54274
Content-Type: text/plain; charset=us-ascii

Hello again,
well i didn't get any responses at all to my last post so I thought i'd try this again.

I have kernel 2.4.26 installed on a Xilinx XUP board and everything works well except I can't seem to communicate with peripherals on the OPB or PLB bus through devfs.  devfs is on and mounted and everything, and I'm able open a file handle to it w/ the following code:

int main (int argc, char *argv[]) {
  int fd;
  int *ptr;

  fd = open("/dev/mem", O_RDWR);
  if(fd == -1) {
    printf("Err: cannot open /dev/mem\n");
    return -1;
  }

  ptr = MAP_FAILED; // Initialize to bad value
  ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd, USER_LOGIC_BASEADDR);

  if(ptr==MAP_FAILED) {
    printf("Err: cannot access address!\n");
    return -1;
  }

  *ptr = 0xA0000000;
  ...


mmap also seems to work, and returns a virtual address that is supposed to point to the location in physical memory at USER_LOGIC_BASEADDR.  when I try to use ptr, however, I either get 
bus error

or

do_wp_page: bogus page at address 3001a000 (page 0xc2c4c004)
VM: killing process led_test.o

depending on whether I use MAP_SHARED or MAP_PRIVATE.

These errors occur if I try to access any device on either PLB or OPB - even the OPB UART (which i KNOW is working).  This technique DOES work, however, for address ranges in RAM.  This indicates to me that it's some sort of higher level memory management problem w/ linuxppc such that it doesn't realize these address ranges are valid.  I assume this is a function of the BSP that gets generated in EDK?  Anybody have any idea how I can tell linux to let me use these addresses?  Any other thoughts?

If I'm being too vague or something please let me know and I'll resolve it immediately...

Thanks much, --scott


Other details:
linuxppc-2.4.26
busybox 1.1.0
powerpc-405-linux-gnu-gcc 3.4.1



--0-1827274702-1154108119=:54274
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hello again,<br>well i didn't get any responses at all to my last post so I thought i'd try this again.<br><br>I have kernel 2.4.26 installed on a Xilinx XUP board and everything works well except I can't seem to communicate with peripherals on the OPB or PLB bus through devfs.&nbsp; devfs is on and mounted and everything, and I'm able open a file handle to it w/ the following code:<br><br>int main (int argc, char *argv[]) {<br>&nbsp; int fd;<br>&nbsp; int *ptr;<br><br>&nbsp; fd = open("/dev/mem", O_RDWR);<br>&nbsp; if(fd == -1) {<br>&nbsp;&nbsp;&nbsp; printf("Err: cannot open /dev/mem\n");<br>&nbsp;&nbsp;&nbsp; return -1;<br>&nbsp; }<br><br>&nbsp; ptr = MAP_FAILED; // Initialize to bad value<br>&nbsp; ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd, USER_LOGIC_BASEADDR);<br><br>&nbsp;
 if(ptr==MAP_FAILED) {<br>&nbsp;&nbsp;&nbsp; printf("Err: cannot access address!\n");<br>&nbsp;&nbsp;&nbsp; return -1;<br>&nbsp; }<br><br>&nbsp; *ptr = 0xA0000000;<br>&nbsp; ...<br><br><br>mmap also seems to work, and returns a virtual address that is supposed to point to the location in physical memory at USER_LOGIC_BASEADDR.&nbsp; when I try to use ptr, however, I either get <br>bus error<br><br>or<br><br>do_wp_page: bogus page at address 3001a000 (page 0xc2c4c004)<br>VM: killing process led_test.o<br><br>depending on whether I use MAP_SHARED or MAP_PRIVATE.<br><br>These errors occur if I try to access any device on either PLB or OPB - even the OPB UART (which i KNOW is working).&nbsp; This technique DOES work, however, for address ranges in RAM.&nbsp; This indicates to me that it's some sort of higher level memory management problem w/ linuxppc such that it doesn't realize these address ranges are valid.&nbsp; I assume this is a function of the BSP that gets generated in
 EDK?&nbsp; Anybody have any idea how I can tell linux to let me use these addresses?&nbsp; Any other thoughts?<br><br>If I'm being too vague or something please let me know and I'll resolve it immediately...<br><br>Thanks much, --scott<br><br><br>Other details:<br>linuxppc-2.4.26<br>busybox 1.1.0<br>powerpc-405-linux-gnu-gcc 3.4.1<br><br></div></div></body></html>
--0-1827274702-1154108119=:54274--

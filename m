Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 3BCB02BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 14:52:47 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64741E@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'paul.bilke'" <listmail@conspiracy.net>
Date: Mon, 27 Dec 2004 22:52:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks - yes, I have 885 !
 
>Moving things around in the kernel sometimes 
>makes this go away but really its just hidden.
>In my case it would explode in zlib_inflate also.  Putting some output 
>in the routine would move it ...

Yes that is exactly what I have observed (but I did'nt have the correct
explanation for it) 
That is what I wrote recently as an observation for myself (but did not
posted it):

"I could see very few debugging outputs.
For example, I need to comment out the section of the load_kernel()
....
      while ( *cp )
              putc(*cp++);
      while (timer++ < 5*1000) {
              if (tstc()) {
                      while ((ch = getc()) != '\n' && ch != '\r') {
                              if (ch == '\b' || ch == '\177') {
                                      if (cp != cmd_line) {
                                              cp--;
                                              puts("\b \b");
                                      }
                              } else if (ch == '\030'         /* ^x */
                                         || ch == '\025') {   /* ^u */
                                      while (cp != cmd_line) {
                                              cp--;
                                              puts("\b \b");
                                      }
                              } else {
                                      *cp++ = ch;
                                      putc(ch);
                              }
                      }
                      break;  /* Exit 'timer' loop */
              }
              udelay(1000);  /* 1 msec */
      }
....
which prints command line string - in order to see my further down debugging
puts() statements in gunzip() ..."

>I hired Wolfgang to implement the suggested work around and I believe he 
>has put the necessary code into his 2.4 tree already.

Could this code be used for 2.6 ?
Could someone point me to it, please ?

Thanks,
Best Regards,
Alex

-----Original Message-----
From: paul.bilke [mailto:listmail@conspiracy.net]
Sent: Monday, December 27, 2004 10:31 PM
To: Povolotsky, Alexander
Cc: 'Tom Rini'; 'wd@denx.de'; 'Kumar Gala'; dan@embeddededge.com;
linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx


This sounds extremely  familiar to me, and wd has already fixed it for 
me, and I suspect for you to.
If you are running a duet variant (870,880,885) there is a CPU errata 
which was the cause in my case.
Look here http://www.freescale.com/files/32bit/doc/errata/MPC885CE.pdf
and at the CPU15 section.  Moving things around in the kernel sometimes 
makes this go away but really its just hidden.
In my case it would explode in zlib_inflate also.  Putting some output 
in the routine would move it so it did not fail but since
these loops were executed 1000's of times it would take many minutes to 
boot.
I hired Wolfgang to implement the suggested work around and I believe he 
has put the necessary code into his 2.4 tree already.
It should be possable to port to you kernel, whatever it is.  As I 
remember it would fail with the instruction pointer always ending in 000.


Hopefully this will help

Paul Bilke

Povolotsky, Alexander wrote:

>Hi,
>
>I have in .config
>...
>CONFIG_ADVANCED_OPTIONS=y
>CONFIG_HIGHMEM_START=0xfe000000
># CONFIG_LOWMEM_SIZE_BOOL is not set
>CONFIG_LOWMEM_SIZE=0x30000000
>CONFIG_KERNEL_START_BOOL=y
>CONFIG_KERNEL_START=0xc0000000
># CONFIG_TASK_SIZE_BOOL is not set
>CONFIG_TASK_SIZE=0x80000000
># CONFIG_CONSISTENT_START_BOOL is not set
>CONFIG_CONSISTENT_START=0xff100000
># CONFIG_CONSISTENT_SIZE_BOOL is not set
>CONFIG_CONSISTENT_SIZE=0x00200000
>CONFIG_BOOT_LOAD_BOOL=y
>CONFIG_BOOT_LOAD=0x00400000
>...
>
>I get (I did not include ramdisk/initrd into the image loaded) :
>
>loaded at:     00180000 00268160
>relocated to:  00400000 004E8160
>board data at: 004E6124 004E6140
>relocated to:  0040509C 004050B8
>zimage at:     00405891 004E5926
>avail ram:     004E9000 02000000
>
>Is above dispostion looks correct ?
>
>Then load_kernel() (in arch/ppc/boot/simple/misc-embedded.c) fails during
>uncompressing kernel whithin: 
>
>gunzip(0, 0x400000, zimage_start, &zimage_size);
>
>Specifically within gunzip() (in arch/ppc/boot/common/misc-common.c) it
>fails after successfully passing 
>through zlib_inflateInit2() .  I think it fails in in zlib_inflate() .
>
>Any ideas/advise ?
>Why second argument while calling gunzip() is set to 0x400000 ?
>
>Thanks,
>Alex 
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>

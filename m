Message-ID: <B25E2E5A003CD311B61E00902778AF2A039C3543@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
	Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU and BDI2000 
Date: Wed, 12 Dec 2001 18:43:17 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have kernel 2.4.4 and I do have MMU XLAT and latest BDI firmware from
Abatron
and I am  not able to get translation to work. I have tried the following

target remote bdi:2001
b start_here

p &swapper_pg_dir

then at BDI2000 telnet prompt,

mm 0xf0 <address_swapper_pg_dir>

that didn't help.

I got the latest 2.4 _devel kernel and there are lot of changes that I need
to merge into my source, I was looking for a short term fix to get
translation
to work. Has anybody gotten gdb to work correctly with Abatron 2000 on linux
2.4.4 kernel?


/Subodh

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, September 14, 2001 4:30 AM
To: Michael Habermann
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU and BDI2000



In message <5.1.0.14.0.20010914174808.026db880@pop.gmx.de> you wrote:
>
> I've not found a BDI newsgroup or FAQ so I'm sorry

Maybe we should start a mailing list.

> But I get problems debugging variables. The BDI often prints:
> '*** MMU: address translation for 0xC100B288 failed',
...
> [TARGET]
> CPUTYPE	    MPC800
> CPUCLOCK    25000000    ;the CPU clock rate after processing the init list
> BDIMODE     AGENT       ;the BDI working mode (LOADONLY | AGENT)
> BREAKMODE   HARD        ;SOFT or HARD, HARD uses PPC hardware breakpoints
> MMU XLAT

Are you using latest BDI2000 firmware?

I'm missing a PTBASE definition in this section  -  without  it  only
default  translation  is  enabled.  See  the  BDI2000  user's manual,
Section "3.2.2 Part [TARGET]" (Entries "MMU XLAT  [kb]"  and  "PTBASE
addr") and Section "3.3.4 Embedded Linux MMU Support".

Please note that the 2.4.4 kernel on our  FTP  server  does  not  yet
include  the  automatic  update  of  the  BDI  page table information
structure mentioned in the BDI2000 manual. We will have this  in  the
next version (as soon as it's running stable).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Is a computer language with goto's totally Wirth-less?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

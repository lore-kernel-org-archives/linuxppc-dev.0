Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 130BD2BF14
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Jan 2005 16:58:41 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64743E@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'wd@denx.de'" <wd@denx.de>,
	"'Jeff Angielski'" <jangiels@speakeasy.net>
Date: Sun, 2 Jan 2005 00:58:18 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: inflate returned FFFFFFFD - what does this error exactly mean ? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Try storing the compressed image at  a  higher  address
>(like 0x400000 or so).

Originally I had relocation address be 0x00400000;
I also tried 0x00500000 and finally 0x00600000 (shown below)
- all 3 cases give the same error.


loaded at:     00180000 00268160
relocated to:  00600000 006E8160
board data at: 006E6124 006E6140
relocated to:  0060509C 006050B8
zimage at:     0060587D 006E5F82
avail ram:     006E9000 02000000

Linux/PPC load: console=ttyCPM0 panic=3 root=/dev/ram
Uncompressing Linux...
in gzip
after zalloc
after zlib_inflateInit2
after zlib_inflate
inflate returned FFFFFFFD
exit
-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Thursday, December 30, 2004 6:09 PM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly
mean ? 


Hi Alex,

in message
<313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.co
m> you wrote:
> 
> After few days of wondering through debugging (and with 
> great help) I fixed (by inserting watch dog resets into 
> beginning of while loops in zlib functions) my first problem > - strange
reboot failures during decompression of

You know why I recommended U-Boot :-)

> Now I am getting "controlled" failure (during the same 
> decompression as described above):
> 
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
> 
> what does this error exactly mean ?

Most probably it means that the areas where the compressed  image  is stored
and   to  where  you  copy  the  uncompressed  code  to  are over-lapping.
Try storing the compressed image at  a  higher  address
(like 0x400000 or so).

Best regards,

Wolfgang Denk
-----Original Message-----
From: Nigel Cunningham [mailto:Nigel.Cunningham@cyclades.com]
Sent: Thursday, December 30, 2004 5:45 PM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@ozlabs.org; linuxppc-embedded-bounces@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?

Hi.

linuxppc-embedded-bounces@ozlabs.org wrote on 31/12/2004 09:27:53:

> Hi,
>
> After few days of wondering through debugging (and with
> great help) I fixed (by inserting watch dog resets into 
> beginning of  while loops in zlib functions) my first 
> problem -strange reboot failures during decompression of
> the kernel image by the bootloader.
> However my luck expired beyond this fix so far ... ;-).
> Now I am getting "controlled" failure (during the same 
> decompression as described above):
>
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
>
> what does this error exactly mean ?

Going from include/linux/zlib.h, it is a data error: your compressed stream
has somehow been corrupted?

Regards,

Nigel
-- 

Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 919D72BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jan 2005 03:09:22 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64743F@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Date: Sun, 2 Jan 2005 11:07:54 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: 'Jeff Angielski' <jangiels@speakeasy.net>, linuxppc-embedded@ozlabs.org
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

>You need to load the
>image into memory at a higher address like 0x400000.

Where the initial load address is getting set ?

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Sunday, January 02, 2005 10:33 AM
To: Povolotsky, Alexander
Cc: 'Jeff Angielski'; 'wd@denx.de'; linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?


On Jan 2, 2005, at 12:58 AM, Povolotsky, Alexander wrote:

> Originally I had relocation address be 0x00400000;
> I also tried 0x00500000 and finally 0x00600000 (shown below)
> - all 3 cases give the same error.
>
>
> loaded at:     00180000 00268160
> relocated to:  00600000 006E8160

You are doing this backward.  You need to load the
image into memory at a higher address like 0x400000.
According to this message, you are loading at 0x180000.
Don't change the relocation address for the build, just
the address where you initially load it into memory.


	-- Dan
-----Original Message-----
From: Povolotsky, Alexander 
Sent: Sunday, January 02, 2005 12:58 AM
To: 'wd@denx.de'; 'Jeff Angielski'
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: inflate returned FFFFFFFD - what does this error exactly
mean ? 


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
-- 

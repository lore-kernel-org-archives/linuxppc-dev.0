Message-Id: <200008031837.UAA10890@denx.local.net>
To: yuval <yuval@jungo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Upload an image file 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-13827739990"
Date: Thu, 03 Aug 2000 20:37:42 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_-13827739990
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2000 19:37:38 +0200."
             <4.3.1.2.20000803192448.00adb470@pop3>
Content-Transfer-Encoding: 8bit

In message <4.3.1.2.20000803192448.00adb470@pop3> you wrote:
>
> I'm trying to install linux on ppc.
> I've compiled the kernel and trying to take the image (in
> arch/ppc/mbxboot/zImage) and transfer it to the "box", but if I'm using
> objcopy to transform it to srecords, the outcome is a file without the
> compressed linux image and when the gunzip start, it crash.

I think this is a FAQ, isn't it.

Anyway - the easiest way is to fool  all  tools  about  the  internal
structure  of  the image by removing all ELF headers; it also has the
beneficial side effect to save 64 kB of memory.

Try this:

    dd if=arch/ppc/mbxboot/zImage of=/tmp/image bs=64k skip=1
    powerpc-linux-objcopy -I binary -O srec /tmp/image /tmp/srec

Then download the S-record file "/tmp/srec".

You can go a step further and use specialized tools to  do  the  same
job:  the  attached  source  (provided by Ruedi Dummermuth at Abatron
with their BDI2000 BDM debugger) is such a tool - it  takes  care  to
also  exclude some other unnecessary data at the end of the image, so
it's especially useful when you need to minimize the memory footprint
of your image.

Maybe you should talk to your tool vendor  to  provide  similar  good
Linux support like Abatron.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895


--==_Exmh_-13827739990
Content-Type: application/x-gzip ; name="img2srec.c.gz"
Content-Description: img2srec.c.gz
Content-Disposition: attachment; filename="img2srec.c.gz"
Content-Transfer-Encoding: base64

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

--==_Exmh_-13827739990--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

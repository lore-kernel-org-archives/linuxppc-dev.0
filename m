To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash Device Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_3743727000"
Date: Sat, 24 Mar 2001 02:37:42 +0100
Message-Id: <20010324013748.59BB7281DC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_3743727000
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 24 Mar 2001 10:13:10 +0900."
             <H00002af04b2e173@MHS>
Content-Transfer-Encoding: 8bit

In message <H00002af04b2e173@MHS> kingseft wrote:
>
>  I found Flash Device driver related files in linux-2.4.3-pre3-2001-03-11
>  I have Intel TE28F160B3(2MBytes, 16bit port size, bottom boot type) flash memory.
>
>  Question1:
>  Can I use my intel flash memory for your flash device driver?

I think it should run without any modifications.

>  I got flash vendor id : CFI_VENDOR_INTEL_STANDARD
>  so , I modified your code like this.
>   } else if ((primary_vendor == CFI_VENDOR_INTEL_SHARP_EXTENDED) ||
>            (primary_vendor == CFI_VENDOR_INTEL_STANDARD) ) {
>  Is it possible ??

Where did you modify code? Please show the  output  of  a  "diff  -u"
command!

>  Question2:
>  when kernel booted, I found this messages.
>  Found 1x16bit 2MBytes CFI Flash device of type Intel Standard at 0xFFE00000
>  registered flash device /dev/flasha (minor 0, 4 partitions)
>  and when I got shell prompt. I made like this.

This looks good, the flash has correctly been recognized.

>  I tried like this.
>  ls -al >> result.txt
>  cat result.txt >> /dev/flasha4

To use the auto-erase feature of the driver, you must  write  with  a
blocksize  that  is  a  multiple of the erase block size of the flash
chips.

Try something like

	dd if=result.txt of=/dev/flasha4 bs=128k conv=sync

>  cat /dev/flasha4
>  but I coudn't find my result.txt contents..
>  Is it impossible??

Probably the flash was not erased? Were there any error messages?

>  Questions3:
>  I read your README but I had a question.
>  Where can I find flash_erase ??
>  W. Denx wrote flash_erase /dev/flasha start_addr end_addr
>  Thanks for any comments and replyings...

See attachment.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Not one hundred percent efficient, of course ... but nothing ever is.
	-- Kirk, "Metamorphosis", stardate 3219.8


--==_Exmh_3743727000
Content-Type: application/x-bzip2 ; name="flash_tools.tar.bz2"
Content-Description: flash_tools.tar.bz2
Content-Disposition: attachment; filename="flash_tools.tar.bz2"
Content-Transfer-Encoding: base64

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
E/eLuSKcKEg0etybAA==

--==_Exmh_3743727000--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <200101080252.f082qVP12117@denx.local.net>
To: Micael balow <micaelbalow@yahoo.com.cn>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: new PPC Questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Jan 2001 10:10:03 +0800."
             <20010108021003.92030.qmail@web11708.mail.yahoo.com>
Date: Mon, 08 Jan 2001 03:52:31 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Micael,

in message <20010108021003.92030.qmail@web11708.mail.yahoo.com> you wrote:
>
> >AfterI ported a image into the board,when I used the
> >following commmand
>
>    => bootm 10020000
>
> >to boot that image,the message just like the one
> >listed below was displayed.
>
>    => # Booting  Linux kernel at 10020000
>    =>  Bad Header Checksum

The linuxppc-embedded mailing listy is not exactly the right place to
ask this question; what you see is an error message from the  PPCBoot
firmware  on your board, so if you have to ask the ppcboot-users list
is probably a better place.

>     I think,the reason for this has something to do
> with the way I compile the image. What do you think?
> Please give a hint.Thank you!

Well, I think the error message is  pretty  clear:  the  one  of  the
checksums stored with your image is not what PPCboot expects (PPCBoot
images   have  two  checksums:  the  first  to  validate  the  header
information, the second to check the data payload).

Either the image you stored at address 0x10020000 is  not  a  PPCBoot
image  at  all, or it got corrupted during download or in memory. You
can try to dump the memory region using

	md 10020000

This might give an indication what happened.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are three things I always forget. Names, faces -  the  third  I
can't remember.                                         - Italo Svevo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

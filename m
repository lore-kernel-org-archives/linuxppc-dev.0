Message-ID: <40B35372.9080201@intracom.gr>
Date: Tue, 25 May 2004 17:08:50 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6 on 8xx (was [PATCH] Driver for FECs on motorola DUET (87x/88x))
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr> <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com> <40B1FB42.1040306@intracom.gr> <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com> <40B327EF.2090903@intracom.gr> <Pine.LNX.4.58.0405250954480.28787@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0405250954480.28787@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert P. J. Day wrote:

>On Tue, 25 May 2004, Pantelis Antoniou wrote:
>
>
>>Hi there
>>
>>Success!!!
>>
>>  netvia-ppc root # uname -a
>>  Linux netvia-ppc 2.6.6 #54 Tue May 25 13:53:27 EEST 2004 ppc ppc ppc
>>GNU/Linux
>>
>>Everything works now, the problem was with the uart driver, had a
>>problem with
>>the interrupts.
>>
>
>i'm definitely interested in what it took for you to get this to work.
>currently, i've got a perfectly working system, booting a 2.4-based
>kernel, compiled with ELDK 3.0, on a customized 8xx board.  this system
>uses the now-deprecated "devfs".
>
I used an NFS mounted root ELDK 3.0 filesystem. By mistake I booted with
devfs and everything worked except the telnet networked logins.
Did not have time to check why though.

>
>i bk-cloned the linuxppc-2.5 tree, did "make menuconfig" as best i could
>(guessing every so often at some of the new features), compiled a new
>kernel and, glory be, actually got the new kernel to boot up to the point
>of trying to start "init", at which point it hung.
>
Well you wont get any further than this using the stock kernel.

I had to use my own ethernet and a ported over serial uart driver for CPM2
boards.

Also some tweaking is needed to the irq dispatch and defining out
some mmu staff which do not apply for 8xx.

>
>i'm using embedded planet's planet core bootloader and, although i'd love
>to make the switch to u-boot, given that planet core seems to be doing the
>job at the moment, i think i won't tempt the gods just yet.  that's a
>later project.
>
>
My condolences :)

>given that "devfs" is now technically obsolete, i'm wondering what you did
>in terms of the kernel configuration, and what you had to do in your root
>filesystem to effect the switch over to (i'm assuming) sysfs+udev.
>
I did nothing special; it appeared to just work.

>
>mind sharing your .config file for this?  i'm not interested in getting
>every feature of this board to work at the moment -- just getting to the
>command line prompt would make me happy.
>
Patience, I'll clean the stuff up and post them here.

>
>rday
>
>
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

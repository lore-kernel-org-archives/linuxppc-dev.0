To: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cramfs Limitations 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Aug 2004 09:35:50 +0800."
             <20040827013550.73877.qmail@web15605.mail.cnb.yahoo.com>
Date: Fri, 27 Aug 2004 09:38:33 +0200
Message-Id: <20040827073838.E2DD9C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040827013550.73877.qmail@web15605.mail.cnb.yahoo.com> you wrote:
>
> > Are you really surprised that opening a file for
> > writing fails  on  a read-only filesystem???
>
> So only for this reason, I cannot choose Cramfs for my
> application deployment??? Then I have nearly no other

Why not? Of course you can. You just cannot write to it.

> choice but use JFFS2 for deployment, which performance
> couldn't compare with RAMDISK.It's a pity that RAMDISK
> cannot update some info permanently. EXT2 seems not a

You can use any filesystem, including one on a RAMDISK.

If the root filesystem happens to be  read-only,  you  just  need  to
provide  a  writable  filesystem  for  those  things that need to get
written. In case of data that may get lost  at  reboot  you  can  use
tmpfs, and for persistent storage you can use JFFS2.

If  you  are  concerned  about  updating  individual  files  in  your
read-only  filesystem  (instead  of updating the whole image (*)) you
can use an overlay filesystem. For example,  you  can  use  "mini_fo"
which  was  specifically  tailored  for  such  purposes;  please  see
http://atlas.denx.de/denx/e/news.php#MINI_FO

(*) Updating the whole image is not a bad idea -  this  way  you  can
    guarantee  that all files int he image are really compatible with
    each other; keeping the system in a consisten state is much  more
    difficult when individual files can get replaced at random.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"UNIX was not designed to stop you from doing stupid things,  because
that would also stop you from doing clever things."       - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

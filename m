Message-ID: <20040826101003.70248.qmail@web15605.mail.cnb.yahoo.com>
Date: Thu, 26 Aug 2004 18:10:03 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Does ext2 based on MTD acceptable for Embedded Development?
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040816162120.6403FC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Although I made ext2 on RPXlite DW board and worked,I
still want to consult with you such a question.Dose
ext2 filesystem besed on MTD a acceptable option?
Compared with JFFS2 and Cramfs,it's really hard to
create on FLASH.I mean the case of 30MB filesystem.I
just did succeed once but the performance was
unacceptable at all.Boot time could last
3'39"00,longer than 2-3 times than other
filesystem.Where did I go wrong,in method itself or
some detailes?

[Target]
root@172.16.115.12:/# eraseall /dev/mtd3
root@172.16.115.12:/# mkfs.ext2 /dev/mtdblock3
root@172.16.115.12:/# ls test/tmp/
bin  dev  etc  home  lib  lost+found  mnt  opt  proc
root  sbin  tmp  usr  var

root@172.16.115.12:/# (cd /test/tmp; tar cf - .) | (cd
/mnt; tar xf -)
tar: ./usr/local/lib/minigui/res/bmp/title.gif: time
stamp 2005-06-25 15:48:36 is 26989356 s in the future
tar: ./home/622/mginit/res/hotkey/help.gif: time stamp
2005-06-24 14:20:34 is 26897657 s in the future
tar: ./home/622/mginit/res/hotkey/advert.gif: time
stamp 2005-06-24 14:19:12 is 26897575 s in the future
tar: ./home/622/mginit/res/hotkey/city.gif: time stamp
2005-06-24 14:16:02 is 26897385 s in the future
tar: ./home/622/mginit/res/hotkey/email.gif: time
stamp 2005-06-24 14:15:38 is 26897361 s in the future
tar: ./home/622/mginit/res/hotkey/phone.gif: time
stamp 2005-06-24 14:14:20 is 26897283 s in the future
tar: ./home/622/mginit/res/hotkey/surf.gif: time stamp
2005-06-24 14:15:12 is 26897335 s in the future
tar: ./home/622/mginit/res/hotkey/ch-en.gif: time
stamp 2005-06-24 14:20:06 is 26897629 s in the future
tar: ./home/622/mginit/res/hotkey/accept.gif: time
stamp 2005-07-15 14:50:24 is 28713847 s in the future

or

root@172.16.115.12:/# cp -a /test/tmp /mnt

Often after that system would hang when using
'reboot'.A hard reset could see kernel crashed by 'no
init' message.

Thanks in advance!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

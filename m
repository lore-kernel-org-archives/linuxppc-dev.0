Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15603.mail.cnb.yahoo.com (web15603.mail.cnb.yahoo.com
	[202.165.102.57]) by ozlabs.org (Postfix) with SMTP id A81B92BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Nov 2004 20:28:13 +1100 (EST)
Message-ID: <20041114092806.76018.qmail@web15603.mail.cnb.yahoo.com>
Date: Sun, 14 Nov 2004 17:28:06 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Any possibility of common mini test kernel for 8xx/82xx/85xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all

I got a very encouraging hint from the conversation
among anonya and Dan and kumar.

Dan wrote:
> Depending upon your software
> requirements and implementation, you are likely
> able to run many of the same binaries across all
> of the PowerPC cores.

I have had a silly idea for some time. Could we have
the same mini test kerenl for demo board and custom
board? I made a 2.4 8xx kernel which only supported
monitor port/RAMDISK/EXT2 in size of 250KB. And the
mini test kernel can run right on my custom board and
demo board at the same time. From the Dan's words,
could I deduce a possibility that we can make a common
mini test kerenl which only support
Monitor/RAMDISK/EXT2 for 8xx/82xx/85xx? Or even better
work on all PowerPC boards?

There are two advantages of common mini test kernel. 
1) We can use it to test ported boards whether they
are in a workable state once they are in an unexpected
situation. 
2) We could use the mini kernel to make monitor port
work at first. Anyway, monitor port is a vary
important and first port we need most time. Also we
can test a custom board whether there is any hardware
or configuration default in boot loader like SDRAM
init, which would help a newbie and port process a
lot.

Following is my downsized result of a 2.4.18 kernel on
a PPC 8xx board. Just support Monitor Port, RAMDISK
and EXT2. No Ethernet/NFS/ etc. 13 items only. I
cannot trim down it anymore. :-)

CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_8xx=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_RPXLITE=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y

The final size is 258660 Bytes = 252.60 kB = 0.25 MB
in compressed format. It worked fine on demo board and
custom board. Could this one work for other 8xx boards
or even 82xx/85xx boards? Or at least this mini
configuration could work commonly for PowerPC board?
I'd like to know how far my silly idea would go.

Suggestion and comment, pls.

=====
Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/

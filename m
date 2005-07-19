Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3907867C61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 18:21:57 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id C4EE94052
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 10:22:02 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 19 Jul 2005 10:21:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507191021.52063.david.jander@protonic.nl>
Subject: How reliable is jffs2 really (denx cvs devel kernel)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I have seen some strange problems with jffs2. I have been victim of the BUG() 
in fs/jffs2/gc.c, line 139. I have been battling with kgdb to see what 
happens there. Here are my findings until now (I am still working on this):

c->checked_ino starts counting from 0
c->highest_ino is 92 (????)

Isn't this a little low?

Flash partition size is 15Mbyte, it probably has been mistreated by writing 
large files (logfiles) line by line, wasting a lot of space until it gets 
almost full.
When debugging the for(;;) loop, used size starts from a few kb counting up, 
dirty size is around 5 Mb and unchecked size is about 9.9Mb, so when it gets 
past inode 92 it most probably has still a lot of unchecked space.===> BUG().

Googleing for this bug, I have found discouraging e-mails (luckily most of 
them from 2003 or older) saying that this is common and nobody (back then) 
seemed to know where it came from. Bugs in fjjs2 code, etc....

This is scaring me.

Anybody knows more about this problem, why it is caused, and hopefully how to 
prevent this?

Thanks,

-- 
David Jander

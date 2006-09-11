Return-Path: <gun_raj@yahoo.com>
Received: from web52414.mail.yahoo.com (web52414.mail.yahoo.com
	[206.190.48.177]) by ozlabs.org (Postfix) with SMTP id EA86A67B6F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Sep 2006 19:46:23 +1000 (EST)
Message-ID: <20060911093940.3052.qmail@web52414.mail.yahoo.com>
Date: Mon, 11 Sep 2006 02:39:39 -0700 (PDT)
From: ganesh subramonian <gun_raj@yahoo.com>
Subject: upgrade cramfs rootfs while running
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i have a cramfs image, which is my rootfs(/ partition)
on flash. in an earlier thread i found some replies
saying that upgrading it while mounted was prone to
errors. however if i am doing the upgrade only in my
shutdown scripts (so that most applications are killed
by this time) like this:
mount -o loop -t cramfs rootfs.img /tmp/somedir
eraseall /dev/mtd2
cp rootfs.img /dev/mtd2
export PATH=/tmp/somedir/bin:/tmp/somedir/sbin...
export LD_LIBRARY_PATH=/tmp/somedir/lib
reboot
is there anything that could go wrong? All further
programs(with their libs) should be executed from the
loop mounted rootfs. 
or else can i do something like
mount -o loop ...
cd /tmp/somedir
pivot_root . tmp
eraseall, copy
reboot
Since i am upgrading just before reboot only these
scripts would be running. Is there a risk in
either/both of these methods.

Thanks
Ganesh

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

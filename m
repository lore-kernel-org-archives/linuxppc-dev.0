Date: Wed, 15 Sep 1999 12:03:29 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Apple OF patches: Open source
Message-Id: <19990915120329.005173@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I missed this until today, but it appears that Apple's OF patches
included in System Disk control panel are actually Open Source (Thanks
Peter). So that means that we can include them in quik, provided that we
handle the subtle licence issues with Apple's public sources licence. 

With those patches, we should be able to have clean OF-based boot on all
OF machines.

The remaining issue is for making bootable install CDs and floppies. My
current work on miBoot shoud help.

One remaining question is: do we need the CD to be HFS or not. I think I
read that OF implementation of ISO was too buggy to allow proper loading
of the bootinfo script and secondary booter. Also, we currently didn't
manage to get the new OF to load the primary booter from the boot blocs.

Also, for miBoot (since i don't beleive old OFs can boot from CDs unless
manually hacking into OF), we can move most of the code to the 68k boot
blocs of the partition and then use Device Manager code to load the rest
from raw blocs. However, the underlying driver may not mount the
partition at all unless it's an Apple_HFS.

I still have to look more closely at how the bootable CD mecanism is
done. Unfortunately, I think it's not documented at all... We may be able
to turn miBoot into a fake driver on the CD and have the MacOS ROM load that.



-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

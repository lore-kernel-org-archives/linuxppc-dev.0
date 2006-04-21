Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id AA3AA67B24
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 16:51:12 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Date: Fri, 21 Apr 2006 08:53:32 +0200
References: <200604062238.17972.antonio.dibacco@aruba.it>
	<20060420221801.55331e15@White64>
	<200604202303.21680.antonio.dibacco@aruba.it>
In-Reply-To: <200604202303.21680.antonio.dibacco@aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604210853.32860.david.jander@protonic.nl>
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

On Thursday 20 April 2006 23:03, Antonio Di Bacco wrote:
> Yes, I also thought this too. Anything important should stay already in RAM
> but there is a chance that something bad could happen. Probably the best

What do you mean with "something bad could happen"?
The only thing I can think of is pulling the power plug while flash is being 
erased or written. What else could go wrong?
We do the following: system running from read-only jffs2 partition. Sometimes 
that partition is remounted read-write and single files are replaced, but in 
some occasions we need to upgrade the whole fs. In that case a CGI lodas the 
image into a ramdisk, and the upgrade process is started. For upgrade, 
'eraseall' and 'dd' (from busybox) are needed. First, all unnecessary 
processes are killed (the webserver stays alive to be able to report the 
status when finished), then "dd" is called for a dummy operation (to have it 
cached). After that the upgrade tool calls "eraseall" on the rootfs 
partition, and then "dd" again to copy the image. At that point no critical 
flash-read access should be requested since dd is already in cache (it's 
busybox, so it's almost always in RAM anyway). When dd is finished, the only 
other thing that's needed is to either be able to send some last html strings 
to the web-server to complete the progress page and tell the user, that it's 
ok to pull the plug, or reset the system, we don't care if the rest of the 
system goes belly-up, since the fs was mounted read-only anyway, and the 
upgrade is finished.

Of course this isn't failsafe, so there should always be a way to recover if 
the rootfs gets trashed, but most of the time it's acceptable that service 
personel is required in that situation. Until now, it has never been required 
though.

> thing is what you suggested as second option but I have not so much ram. My
> CGI writes the downloaded new software in RAM and then I should directly
> jump to u-boot without leaving Linux the chance to mix things up and then
> u-boot should copy the RAM to the flash. It seems a strange procedure but
> what else could be done with 4MB flash and 16 MB ram?

Run from initrd? Maybe an uncomressed filesystem on a ramdisk to be able to do 
XIP (execute in place)?

Greetings,

-- 
David Jander

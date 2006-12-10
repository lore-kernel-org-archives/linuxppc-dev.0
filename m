Return-Path: <jianlinz_2000@yahoo.com>
Received: from web56713.mail.re3.yahoo.com (web56713.mail.re3.yahoo.com
	[66.196.97.72]) by ozlabs.org (Postfix) with SMTP id 2D4CB67B6D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Dec 2006 11:02:40 +1100 (EST)
Date: Sat, 9 Dec 2006 16:02:39 -0800 (PST)
From: Jianlin Zeng <jianlinz_2000@yahoo.com>
Subject: Re: reboot problem with MPC8248 based board
To: Jeff Angielski <jeff@theptrgroup.com>
In-Reply-To: <1165628833.25443.10.camel@jaalaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <285062.23366.qm@web56713.mail.re3.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jeff,

Thanks a lot for your information! That's indeed the
reason for the hang. Now I read through all flash
sectors before reboot and it works fine.

Regards,
Jianlin



--- Jeff Angielski <jeff@theptrgroup.com> wrote:

> On Fri, 2006-12-08 at 17:25 -0800, Jianlin Zeng
> wrote:
> > Hi,
> > 
> > I have a MPC8248 based board running with linux
> kernel
> > 2.6.11. I mounted jffs2 FS on a NOR flash devices.
> The
> > jffs2 FS works fine. But whenever I modify any
> files
> > in jffs2 FS and soft reboot the board, the reboot
> > hangs. If I don't modify any files in jffs2 FS and
> > just do flashcp to mtd char device, the soft
> reboot
> > works fine.
> > 
> > I tried doing "reboot" through "m8260_gorom" or a
> > mechanism similar to what is used in u-boot. The
> > result is the same. I don't understand why jffs2
> write
> > causes reboot to hang but MTD char device write
> does
> > not. Does anybody have similar experience? Can
> anybody
> > give me some help?
> > 
> > Thanks,
> > Jianlin
> 
> I have seen strange reboot behavior like this when
> the flash chips were
> left in write mode.  After reboot, you are unable to
> read the flash and
> the system just hangs.  
> 
> In 2.4 days, we solved this with a reboot_notifier
> that just went
> through the sectors and reset them back to read
> mode.
> 
> Not sure if that helps but at least it gives you
> something to look into.
> 
> 
> 
> -- 
> Jeff Angielski
> The PTR Group
> 
> 



 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com

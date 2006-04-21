Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 09F55679F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 06:23:11 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Apr 2006 08:53:32 +0200."
	<200604210853.32860.david.jander@protonic.nl>
Date: Fri, 21 Apr 2006 22:23:08 +0200
Sender: wd@denx.de
Message-Id: <20060421202308.D508F3526B7@atlas.denx.de>
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

In message <200604210853.32860.david.jander@protonic.nl> you wrote:
> 
> What do you mean with "something bad could happen"?

System crashes.

> The only thing I can think of is pulling the power plug while flash is being 
> erased or written. What else could go wrong?

The kernel may try to (re-) load some pages of a  running  executable
or  library  which  is  no  longer  available  (at  least  not at the
addresses where they used to be). The kernel will either stumble over
what it believes to be a corrupted file system,  or  load  the  wrong
data -> kaboom.

> We do the following: system running from read-only jffs2 partition. Sometimes 
> that partition is remounted read-write and single files are replaced, but in 
> some occasions we need to upgrade the whole fs. In that case a CGI lodas the 
> image into a ramdisk, and the upgrade process is started. For upgrade, 

You *have* to unmount the old file system here.

> partition, and then "dd" again to copy the image. At that point no critical 
> flash-read access should be requested since dd is already in cache (it's 

The kernel might reload any page of any running executable or library.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Logic and practical information do not seem to apply here."
"You admit that?"
"To deny the facts would be illogical, Doctor"
	-- Spock and McCoy, "A Piece of the Action", stardate unknown

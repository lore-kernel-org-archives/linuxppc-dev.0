Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id C979C67A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 07:01:19 +1100 (EST)
To: srinivas.surabhi@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Feb 2005 08:48:58 +0530."
	<EF9B29C78F41FA488927FCBC7750AF0E011DA5D1@hyd-mdp-msg.wipro.com>
Date: Wed, 16 Feb 2005 21:00:45 +0100
Sender: wd@denx.de
Message-Id: <20050216200050.23252C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EF9B29C78F41FA488927FCBC7750AF0E011DA5D1@hyd-mdp-msg.wipro.com> you wrote:
> 
> cramfs is 2.7MB where as the RAM size is 32MB. While building ofcourse
> the RAMDISK size was told as 8MB. This I mentioned in the devrocket

What has the ramdisk to do  here?  Either  you  are  using  a  cramfs
filesystem, or a ramdisk (probably with an ext2 filesystem in it).

Putting cramfs filesystem in a ramdisk image is a pretty bad idea.

> Here I have one doubt while building the uBoot image using mkImage with
> multi option where was the FileSystem image getting downloaded ? and how

A multi-file image in U-Boot indeed requires a  ramdisk  image.  Then
you  should  not  use a cramfs filesystem. The method for loading tha
ramdisk image is described in the U-Boot "README"  file;  search  for
"positioning of initrd images".

> the downloaded location was known to the kernel Image for pointing out
> the File System image location. The options -a and -e are applicable
> only for first image, isn't it? First image I mean the kernel Image. I

Yes. Only the kernel is executable code and has an entry point.

> YES. You are right I am building the image on x86 (Windows platform).
> But I checked the build log it used the -r option. The default build was
> cpio format and after that using fstool converting to CRAMS and the
> option -r was present .I believe that devrocket of MountaVista has
> makefiles specific to OS i.e for Windows, because while installation it
> asks for what type of OS do you want to have the Image Development
> environment.

Maybe you should ask MV support, then. 

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is clear that the individual who persecutes a  man,  his  brother,
because he is not of the same opinion, is a monster.       - Voltaire

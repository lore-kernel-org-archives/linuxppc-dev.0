Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3DE2B67A76
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 18:52:59 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: "HappyPhot" <happyphot@gmail.com>
Date: Thu, 5 Jan 2006 08:52:44 +0100
References: <000701c60fab$9fdca6a0$0760120a@photon>
	<200601031410.55884.david.jander@protonic.nl>
	<004701c611a8$557dbf00$0760120a@photon>
In-Reply-To: <004701c611a8$557dbf00$0760120a@photon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601050852.45616.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 05 January 2006 04:29, you wrote:
> Hi, David,
>   I get the complete bootlog and .config here. Please see the
> attached files. I copy the bootlog into .config.
>   And my NFS can mount root file system ok, but can not
> execute any program. Once the program load into system and
> run, the system crash.
>   I am new in this field and thank you for your help.
> Regards,
> /HappyPhot

in your .config:

> CONFIG_JFFS2_FS=m

This is wrong. You have to choose "y", not "m" (for module).
This way jffs2 is compiled as a module. That means, that jffs2 filesystem will 
not be available until the module is loaded with "insmod jffs2" of something 
similar. That in turn means that your system has to start up first in order 
to be able to do this, but since you can't start because your root filesystem 
is on jffs2, you have created yourself a "chicken and egg" problem.
If you choose "y" then jffs2 support will be compiled into the kernel, and 
thus be available before booting.

In your bootlog:

> Linux version 2.6.14.2 (happy@sddlinux1) (gcc version 3.3.3 (DENX ELDK 3.1.1 
> 3.3.3-10)) #29 Sun Jan 1 22:34:28 CST 2006
> Motorola SPS Sandpoint Test Platform

I see you are using DENX ELDK 3.1.1 and a kernel which AFAIK is not supported 
by this version of ELDK. Are you sure this is supposed to work? It probably 
will, but I don't know what the "Sandpoint" is (it looks like a PowerPC 
processor of the MPC7xx series to me), so I couldn't tell.

Greetings,

-- 
David Jander

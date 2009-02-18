Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE002.bigfish.com (wa4ehsobe002.messaging.microsoft.com
	[216.32.181.12]) by ozlabs.org (Postfix) with ESMTP id 48C8FDDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 11:35:48 +1100 (EST)
Message-ID: <499B544D.3020704@am.sony.com>
Date: Tue, 17 Feb 2009 16:20:29 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: gt bradley <baykelper@yahoo.com>
Subject: Re: nfs booting PS3, mount failed.
References: <719599.32884.qm@web56204.mail.re3.yahoo.com>
In-Reply-To: <719599.32884.qm@web56204.mail.re3.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/16/2009 09:22 PM, gt bradley wrote:
> I'm trying to set up my PS3 to netboot (with an nfsroot).
> 
> I'm using instructions at
> http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-howto/ps3-nfs-root-howto.txt
> 
> I've passed section 3 (using tftp) to verify network /dhcp etc.   (i.e.
> I'm able to tftp-get a file to ps3 from kboot's ash shell (busybox).
> 
> i'm trying to mount the nfs server as per section 4. with
> 
>  ~# mount -t nfs -o nolock 192.168.99.1:/target /mnt/remote
> 
> I get the following error message:
>   mount: mounting 192.168.99.1:/target on /mnt/remote failed
> 
> if I boot the PS3 from the HD, then I am able to mount the nfs directory.
> Using wireshark, I can see the initial dhcp traffic, (and when present the tftp traffic).
> the mount command doesn't open a network connection to the server, 
> So I have pretty much ruled out server
>  configuration.
> 
> running "strings" on the decompressed kboot image yeilds serveral nfs symbols, so it 
> appears to still support nfs mounting.  (using version kboot-20080609.bld from geoff's dir at kernel.org)

I have sometimes seen nfs problems with kboot.  You could you
try petitboot.  Get the latest 'experimental' one from here:

  http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-petitboot/

Another thing to try is to use a 'rescue' disk/mode to copy the files.
Most distros have them.  Fedora has a rescue mode in their installer:

  http://download.fedora.redhat.com/pub/fedora/linux/releases/10/Fedora/ppc/iso/Fedora-10-ppc-netinst.iso

Just select 'rescue' instead of 'install', or you can add
these to the boot options: 'text rescue video=720p'.

You don't need kboot/petitboot to do nfs.  To load the kernel
they just need to do tftp.

-Geoff

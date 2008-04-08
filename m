Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id D7F0FDDFC0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 07:32:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so500952anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Apr 2008 14:32:26 -0700 (PDT)
Message-ID: <fa686aa40804081432k6b126485w289669a214cadeb9@mail.gmail.com>
Date: Tue, 8 Apr 2008 15:32:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: Booting a Xilinx board
In-Reply-To: <10fd01c89974$57a0c830$f52f9e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
	<fa686aa40804072055i1f7036afn4d453e968cc625d6@mail.gmail.com>
	<10d401c8995a$1a63beb0$f52f9e86@LPSC0173W>
	<10fd01c89974$57a0c830$f52f9e86@LPSC0173W>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 8, 2008 at 6:30 AM, Guillaume Dargaud <dargaud@lpsc.in2p3.fr> wrote:
> I'm making progress, thanks in no small part to this list, but I still need
> coaching, if you don't mind. The current boot is currently going as such:
>
>
>  loaded at:     00400000 005A819C
>  board data at: 005A6120 005A619C
<snip>
>  [    4.897987] RPC: Registered udp transport module.
>  [    4.953147] RPC: Registered tcp transport module.
>  [    5.011138] RAMDISK: Compressed image found at block 0
>  [    5.905538] VFS: Mounted root (ext2 filesystem).
>  [    5.945703] Freeing unused kernel memormdev: /etc/mdev.conf: No such
> file
>  or directory
>  mdev: /etc/mdev.conf: No such file or directory
<snip>
>  mdev: /etc/mdev.conf: No such file or directory
>  mdev: /etc/mdev.conf: No such file or directory
>  mount: mounting configfs on /config failed: No such device
>  Initializing random number generator... done.
>  Starting network...
>  ip: RTNETLINK answers: File exists
>
>
>  And then it stops, although I still have echo when I type.
>  Now there's no /etc/mdev.conf file in my root fylesystem and I understand I
> need to create the devices.
>  I've been reading docs/mdev.txt and
> http://www.lfs-matrix.org/clfs/view/clfs-embedded/mips/bootscripts/mdev.html
> and I'm a bit confused.

Congratulations, your kernel is in good shape.  Now you're dealing
with userspace issues.  You can try bypassing most of the init process
to see if you can get a prompt.  Add init=/bin/sh to the kernel
command line.

>
>  - do the devices need to be created in the FS before building the ramdisk
> and subsequent ACE file ?

Yes, you can statically create the device files.  MAKEDEV will do this
for you.  You can even just copy them from a working Linux system (any
arch).

>  - are they created dynamically by /bin/mdev on boot based on a manually
> written /etc/mdev.conf table as the error messages seem to imply ?

That depends on your rootfs.  Where did you get your rootfs image?

>  - can they be generated automagically by a MAKEDEV script ?
>
>  In the second case, how do I know which devices and what names I'm supposed
> to define ?

Easiest way: copy from the /dev tree in a running Linux machine.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

To: "PAULO SELEME CORREA PAULO" <paulo.correa@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk initrd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Oct 2001 10:15:11 -0300."
             <sbcfef39.080@siemens.com.br>
Date: Fri, 19 Oct 2001 15:52:35 +0200
Message-Id: <20011019135240.502D510CCC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Paulo,

in message <sbcfef39.080@siemens.com.br> you wrote:
>
>       I made the ram disk image with the following script :
>
>      dd if=/dev/zero of=/dev/ram bs=1k count=4096
>      mke2fs -vm0 /dev/ram 4096
>      mkdir -p /mnt/ram
>      (cd file_system; cp -a * /mnt/ram)

It would have been a  good  idea  to  veryfy  the  contents  of  your
/mnt/ram  directory  now.  You  could have seen that "cp -a" does not
copy special files.

Use something like this instead:

	( cd file_system; find . -depth -print | cpio -pdum /mnt/ram )

>      umount /mnt/ram
>      rmdir /mnt/ram
>      dd if=/dev/ram of=fs_images/ramdiskimage bs=1k count=4096
>      gzip -v9f ramdisk.image
>
>      I copied the ramdisk.image.gz to /opt/hardhat/devkit/ppc/8xx/target/boot
>      and
>      executed ./mkimage -n "ramdiskimage"-d  ramdisk.image.gz ramdiskimage

It is really important that you list the PRECISE commands  you  used;
it  is  obvious  that  this is not the case here; there is not only a
space missing, you are also missing some other options (-T).

>      I set the boot parameters to download the kernel via tftp to the target board so when I reset the board it runs ppcboot download the kernel uncompress it and then try to mout the root file system.

It probably _did_ mount the root filesystem, but then it died because
there was no /dev/console in your root filesystem.

>       What I didn't understand is how can I download the RAMDISK image to a specific memory area during the boot so when mounting the root filesystem it can find the ramdisk image in memory.

You are worrying about the wrong things.  Everything  is  fine,  it's
just that your ramdisk image is incomplete.

>       And I don't know how to download the RAMDISK image to the memory to execute the bootm command as explained in PPcboot README  :

How do you download other images? There  is  the  "tftp"  command  to
download  over  ethernet,  and  there  are  the  "loads"  and "loadb"
commands to download over serial line.

Where exactly is the problem?

>        I tried the loads command but had no success

I really hate this sort of problem descriptions.

Which EXACT command did you use? Why didn't it work? Were  there  any
error messages? Which?

And why did you use "loads"? Download over  ethernet  is  simple  and
fast - why don't you use it?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The number  of  Unix  installations  has  grown  to  10,  with  more
expected."    - The Unix Programmer's Manual, 2nd Edition, June, 1972

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

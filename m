Message-ID: <3A966727.B5E50F07@raleigh.ibm.com>
Date: Fri, 23 Feb 2001 08:35:35 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Cc: Tulika Pradhan <tulikapradhan@hotmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk for initrd
References: <LAW2-F77fTJ9w9wPzJ000001e45@hotmail.com> <3A96709D.481683D4@dspace.de>
Content-Type: multipart/mixed;
 boundary="------------6032D2F879793D332B0A3F63"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6032D2F879793D332B0A3F63
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas

I think this is better for making a ramdisk.

dd if=/dev/zero of=./ramdisk.img bs=1k count=1000
/sbin/mke2fs -q -F -m 0 ./ramdisk.img
mkdir /mnt/foo
mount -o loop ./ramdisk.img /mnt/foo
cd /mnt/foo
tar xzf ~-/ram.tgz

Andreas Schreckenberg wrote:
>
> Tulika Pradhan wrote:
> >
> > hi !
>
> Hi,
>
> > i need a minimal ramdisk image for booting up linux on a embedded ppc board.
> > i tried monteVista site (as i saw a mail in the mailing list archive), but i
> > already have a development platform so, how can i download a ramdisk image
> > without downloading CDK. I use Red Hat linux v6.2 and ppc 603e processor.
> >
> > Any help would be great.
>
> I use the following script for a 4MB ramdisk:
> You must be "root" and have ramdisk support
>
> dd if=/dev/zero of=/dev/ram bs=1k count=4096
> mke2fs -vm0 /dev/ram 4096
> mkdir -p /mnt/ram
> mount /dev/ram /mnt/ram
> (cd file_system; cp -a * /mnt/ram)
> umount /mnt/ram
> rmdir /mnt/ram
> dd if=/dev/ram of=fs_images/ramdisk.image bs=1k count=4096
> gzip -v9f ramdisk.image
>
> First create a directory called "file_system"
> and copy the files you need into it.
>
> you create a initial console in file_system/dev with
> mknod c 5 1 file_system/dev
>
> and a shell in file_system/bin, file_system/etc, or file_system/sbin...
> (I use the static sash from MontaVista, rename it as init)
>
> hope you can use this
>
> bye
> Andreas
> --
>           Life's not fair. But the root password helps ! :-)
>                    http://schrecky.home.pages.de
>                Open minds. Open sources. Open future.
>
--------------6032D2F879793D332B0A3F63
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;15936
fn:Ralph Blach
end:vcard

--------------6032D2F879793D332B0A3F63--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

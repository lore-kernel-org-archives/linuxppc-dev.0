From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBDFF@helios.gnv.tcc.thomson-csf.com>
To: yong_guo@scomcenter.com, callebaut@mailandnews.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: RE :how to do:root filesystem on flash?
Date: Fri, 13 Jun 2003 10:19:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> > I,
> > 1 : Create a cramfs filesystem with the right endianess
> from your nfs
> > filesystem using mkcramfs.
> > Burn it into the flash( at the start of the flash).
> Is it must be burned from the start of the flash?  My u-boot
> bin code is
> burned at the start of the flash.
>

No it is not necessary to burn your fs at the beginning of the flash.
But if you don't, you must use partitions.
First select the option to use partitions in the kernel.
Then give a look in sources of /drivers/mtd/... to see how to declare your
own partition for your custom board. ( there are somes files for custom
boards that you will give you ideas...)
I had to change the config.in to add my own board.
Then you will have
/dev/mtdblock/0 mapping UBoot.
&
/dev/mtdblock/1 mapping your fs.

So you will have to use
root=/dev/mtdblock/1

> >
> > 2 : In your kernel config set the "root=" option to :
> "/dev/mtdblock0"
> In my system, the flash is registered as /dev/flasha, should
> i pass the
> parameter "root=/dev/flasha" to kernel?
>

?
I don't know.
Selecting MTD in the kernel config gave me /dev/mtdblock/x...

> > Enable Flash MTDBlock support and the right options like CFI,...
> > Set up the start of the flash and its length
> > Enable Cramfs in filesystem
> > Disable NFS as root filesystem.
> >
> > Rebuild your kernel and flash it.
> > Reboot the board en enjoy.
> >
> > PS : This question was already a 100 times answered. Search
> in the mailing
> > list before asking such a question.
> > Or maybe a better idea : One may build a FAQ or a list of
> Howtos on such
> > common questions.
> >
> > Benoit Callebaut
> >
> >
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3CFF82BB.6080100@thales-bm.com>
Date: Thu, 06 Jun 2002 17:41:47 +0200
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Re: kernel command line for CRAMFS root filesystem]
References: <OEEHJMIIDJHHMFGGDNGDIEGLCOAA.fischi@epygi.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> we use cramfs here and it works without additional parameter. How do you
> generate the cramfs and on which kind of system are you using it? The
> mkcramfs tool has an endianess problem so if you do mkcramfs on 86x platform
> to use it on ppc it wont work. (maybe there is some newer version i am not
> aware of where that is fixed)



Well it seems it is the problem ... i have generated cramfs on my x86
and my target is ppc .
is there a simple trick to make my cramfs image correct for ppc ?
should i build my cramfs image on the target ?

thanks,

Julien.


details
-------
ok i boot my target over nfs, and i try to mount my cramfs with :

# mount -t cramfs /dev/mtdblock/2 /mnt/temp
wrong magic
......

# dd if=/dev/mtdblock/2 of=/root/toto.dat bs=1024 count=1


then i switch to my PC (x86) to look at what i have :

#hexdump /root/toto.dat | more
0000000 3d45 28cd 0000 0001 0000 0000 0000 0000
0000010 6f43 706d 6572 7373 6465 5220 4d4f 5346
0000020 6344 2423 98f1 b87f daf3 58a0 b74a a046
0000030 6f43 706d 6572 7373 6465 0000 0000 0000

in cramfs.h :
#define CRAMFS_MAGIC		0x28cd3d45	/* some random number */



--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

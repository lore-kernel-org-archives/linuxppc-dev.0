Message-Id: <387A7B30.3B8ED86C@ict.ac.cn>
Date: Tue, 11 Jan 2000 08:37:04 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem with gunzip()
References: <38799BA3.269E8869@ict.ac.cn> <3879F9E6.EF018D4E@mvista.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:

I made zImage first of course. Then I wrote a little program to
extract the image section which is vmlinux.gz from zImage.
I use visionPROBE which is emulator of EST to debug the linux.
I downloaded the program to my board with emulator, then downloaded
the vmlinux.gz to the position of ZIMAGE_OFFSET. I ran the program,
I can see the following message:

loaded at:     00800000 0080B1C8
board data at: 00800158 00800180
relocated to:  007F0100 007F0128
zimage at:     00830263 0088A2AF
avail ram:     0088B000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

So I think the vmlinux.gz that I downloaded to the board is correct.
I also compared vmlinux.gz with contents in RAM ZIMAGE_OFFSET, they
are same. But after gunzip, the contents in RAM 0x0 are different
with vmlinux.
Any other suggestions?
Thanks!

LiuTao 

Jim Lewis wrote:
> 
> Hi,
> 
> I have had a problem such as yours that was caused by corruption in the
> compressed s-record image once it was on the target. I had thought that
> Gunzip would catch this, but it did not. How is your image being
> transmitted to the target? Is it over a serial link? In my case, the
> S-record loader was not checking checksums and occasionally, a serial
> transmission error went undetected. Gunzip did not complain, but the
> uncompressed image would end up being skewed by a few bytes.
> Hope this helps.
> 
> LiuTao wrote:
> 
> > Hi
> >
> > When I ported linux to a board with MPC860, 16M RAM and 2M Flash,
> > I met a problem.
> > After the program gunzip()(misc.c) the vmlinux image to address 0x0,
> > the contents from 0x0 to IMAGE_SIZE should be as same as that in
> > linux/vmlinux, right? I found that they are not same. Only from 0x0
> > to about 0xb500, they are same.
> > I don't think gunzip() has any problem.
> > Do you have any suggestions?
> > Thanks!
> >
> > LiuTao
> 
> --
> Jim Lewis
> Sr. Field Applications Engineer
> MontaVista Software, Inc.
> (817)261-9088 http://www.mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

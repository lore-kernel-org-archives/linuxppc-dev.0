Message-ID: <294FD9D3403A0340BDAC38E48DCEFFDCA75E@RES-EXCH>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: Lokesh Kumar <kumar.lokesh@wrx-us.com>,
	"'Wolfgang Denk '" <wd@denx.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: cramfs mpc8xx 2.4.18 
Date: Fri, 5 Mar 2004 08:31:46 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have cramfs working now. There was a problem with MTD in 2.4.18 kernel, in
mtdblock_release function. It calles invalidate_device, and I went through
mtd mailing list and found that problem and that fixed the hang at the end
part of booting.

However, when I enable the tmpfs support in kernel, it still crashes. Need
to find that problem still.

Lokesh

-----Original Message-----
From: Lokesh Kumar
Sent: Monday, March 01, 2004 2:19 PM
To: Lokesh Kumar; 'Wolfgang Denk '
Cc: 'linuxppc-embedded@lists.linuxppc.org '
Subject: RE: cramfs mpc8xx 2.4.18


What are the options of MTD which I have to enable for cramfs? There is
something called MTD for read only and when I enable that, the kernel starts
crashing in inet_add_protocol. Does that function try to write something to
any location? What about /etc/mtab?

Lokesh

-----Original Message-----
From: Lokesh Kumar
Sent: Sunday, February 29, 2004 7:58 PM
To: 'Wolfgang Denk '; Lokesh Kumar
Cc: 'linuxppc-embedded@lists.linuxppc.org '
Subject: RE: cramfs mpc8xx 2.4.18



Yes, I can boot the system with initrd, and mount the cramfs and access all
the files. I also did use -r option to build the filesystem image.

I do not have proc built inside the kernel and no /proc directory. I do not
have any /var and /tmp directories in the cramfs. How do I mount /var or
/tmp inside the ram?

What else should I check? I have 2.4.18 stock kernel. Am I supposed to apply
any patch for cramfs to work?

Lokesh

-----Original Message-----
From: Wolfgang Denk
To: Lokesh Kumar
Cc: linuxppc-embedded@lists.linuxppc.org
Sent: 2/29/04 11:31 AM
Subject: Re: cramfs mpc8xx 2.4.18

In message <294FD9D3403A0340BDAC38E48DCEFFDCA751@RES-EXCH> you wrote:
>
> Kernel command line: root=/dev/mtdblock1 rootfstype=cramfs
console=ttyS0,9600
...
> ok
> mtdblock_open
> mtdblock: read on "cramfs" at 0x0, size 0x1000
> mtdblock: read on "cramfs" at 0x1000, size 0x1000
> mtdblock: read on "cramfs" at 0x2000, size 0x1000
> mtdblock: read on "cramfs" at 0x3000, size 0x1000
> mtdblock_release
>
> And after this, I do not get the prompt back, and the target hangs. My
> cramfs rootfilesystem has
>
> /bin, /dev, /etc, /sbin, /lib and /usr/sbin

Are you sure? Can you mount the same  filesystem  when  running  with
root filesystem mounted over NFS or from a ramdisk?

Did you remember  that  you  might  need  the  "-r"  option  (reverse
endian-ness of filesystem) when creating the filesystem?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I distrust all systematisers, and avoid them. The will  to  a  system
shows a lack of honesty.
- Friedrich Wilhelm Nietzsche _Götzen-Dämmerung [The Twilight of  the
Idols]_ ``Maxims and Missiles'' no. 26

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

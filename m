Mime-Version: 1.0
Message-Id: <v04210106b3c7ff057f2a@[192.168.0.1]>
Date: Fri, 30 Jul 1999 17:39:28 -0800
To: linuxppc-dev@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Open Firmware booting on a Blue G3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello,

this discussion I started on LinuxPPC-users, and it has pretty much 
been decided there that the problem with OF booting on Blue G3s lies 
in proper OF support in quik and the kernel.  I am thus porting the 
discussion here to see if we can get those items fixed, and figure 
out exactly what needs to be done where.

summary of discussion that occurred on the users list:

On 27/7/99 puetzk6715@uni.edu wrote:
>It's our kernel that's inadequate - it needs some additional header
>fields. Macos actually uses OF on these machines, so the OF drivers are
>finally reliable!

At 14:39 -0800 27/7/99, Ethan Benson wrote:
>and to publicly answer those who have said its impossible, I would 
>just say that I find it exceedingly hard to believe Apple is so 
>tremendously shortsighted and utterly stupid as to build a crippled 
>firmware ONLY capable of booting an OS they themselves are in the 
>process of phasing out and replacing with a completely different 
>UN*X based OS that has nearly nothing in common with the Macos8* 
>variety.

At 19:54 -0700 27/7/99, Joel Klecker wrote:
>Apple is none of those things in this instance, Apple finally chose 
>to adopt a sane standard for its OF, and Linux/pmac has fallen 
>behind.
>OSes with properly CHRP-compliant kernel images (such as 
>NetBSD/macppc) can be booted just fine from New World OF.

  puetzk6715@uni.edu mentioned that OF has filesystem support, so quik 
would not be needed and OF could be configured to boot the kernel 
directly.  I responded that this approach would require a separate 
ISO, HFS, HFS+, or FAT filesystem either in a /boot partition or the 
entire root partition would have to be formatted in those formats.  I 
mentioned that I do not like the idea of having to maintain non ext2 
filesystems to support my kernel. I also mentioned the following 
arguments for retaining and improving quik:

At 16:16 -0800 28/7/99, Ethan Benson wrote:
>well one reason that would be good to have quik around is quik makes 
>setting up kernel images much easier then mucking around in OF 
>(something people seem to have a problem with given all the 
>slobbering over BootX) and quik could be given the same security and 
>password controls that LILO has, with OF being totally unprotectable 
>it is difficult to prevent someone from booting linux into single 
>user mode, if the only way to enter single user mode was by passing 
>'single' at the quik prompt then quik can be set to ask a passwd 
>when arguments are given (just like restricted lilo)
>
>this would not be as secure as a intel box with passworded BIOS and 
>LILO but its better then what we have...  (combine with a few OF 
>tricks it can make it even more difficult to bypass security)
>
>if we dump quik then the only way to boot into single user mode is 
>BootX (yuk) or adding a argument to OF when booting.
>
>I would say keep quik around and add the same passwd support to it 
>as LILO this way we can setup OF once (with maybe a script that has 
>a boot menu) with a nice config tool and use quik in the same way we 
>use LILO on intel machines, it can help increase security options, 
>and help reduce the need for hacking OF variables.

At 16:51 -0800 29/7/99, Ethan Benson wrote:
>I have been researching this issue for the last week and found this 
>technote from Apple:
>
>http://developer.apple.com/technotes/tn/tn1167.html  in particular 
>they mention the need for a "bootfile" which is a file containing an 
>OpenFirmware script to finish the bootstrap process, it can 
>optionally contain additional data as well.  On Macos this file is 
>the MacOSROM image, which contains the OpenFirmware script and the 
>additional data is the actual ROM image for MacOS.
>
>so my slightly educated theory is that quik needs to have a 
>OpenFirmware script in either its first or second level bootstraps 
>to work with OF (probably first) and if booting kernel directly 
>(only possible from ISO, thus not preferable from root filesystem) 
>then the kernel image itself would probably have that OF header, 
>which I am not sure could be done, so instead it would probably be a 
>different file which has the additional code to load the kernel.

NetBSD have OF booting of there kernel (on iMac, which has nearly 
identical boot ROM to blueG3) but only from the network, I suspect 
(but have not confirmed) this is because they have no quik to deal 
with their UFS filesystems, but do have the proper headers in place 
so that OF accepts it.

comments?



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

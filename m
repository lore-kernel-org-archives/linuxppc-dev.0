Date: Tue, 13 Jul 1999 09:59:46 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Simone Piccardi <piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A little trouble for MVME2400 boot from HD
In-Reply-To: <37852989.5F3D914A@fi.infn.it>
Message-ID: <Pine.LNX.3.96.990713095257.19708A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Jul 1999, Simone Piccardi wrote:

> I would like to boot linux on a MVME2400 from a SCSI HD; I set a primary
> partition (it was /dev/sda3, about 3Mb) as 0x041 and made it bootable;
> then and I copied a zImage file on it using dd. 

<snip>

> Loading: Operating
> System                                                       
>                                                                                 
> IPL Size Exceeds Free-Available
> Memory:                                         
> IPL Size              =AC444000
> (&-1404813312)                                  
> Free-Available Memory =01F74000
> (&32980992)                                     

Wow, that IPL Size is huge...no wonder BUG is upset.  The only time I've
seen this is when I've hacked up the PReP header info to make bootable
CD's.  If the sector offset is pointing to the wrong area to get the image
then the load image length field would be wrong and result in BUG trying
to read an immense amount of information in.  See the PPCBUG user's manual
for details on what PBOOT looks for in a boot image...it is on
http://www.mcg.mot.com.  Look at your zImage and see if the sector offset
in the PReP header partition table points at the 2nd 512 byte block and
that the 2nd block has a valid entry offset point and load image length
for your image.

> I'm missing something on the kernel image preparation? Or I have to use
> another command?

You are building a zImage with "make zImage" and not applying any post
image processing, right?  MVME2400 have no known problems loading kernels,
in that case.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Mon, 19 Jul 2004 17:34:35 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Linh Dang <linhd@nortelnetworks.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <20040719205835.AA851C109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0407191731390.24783@dell.enoriver.com>
References: <20040719205835.AA851C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Jul 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com> you wrote:
>>
>>> initramfs is convenient. you don't need root access nor special tools
>>> to create the root-fs. it very easy when you want to
>>> version-controlled you root-fs.
>>
>> ah, that would be convenient since, as it is, i'm using a hacked
>> version of "genext2fs" that allows me to create the initial root fs as
>> a regular user.  i *definitely* have to look into initramfs, then.
>
> What do you mean with "hacked"? Standard  "genext2fs"  will  do  this
> just fine.

sadly for me, the version floating around doesn't build FIFOs (even
though the command-line options suggest it does).  and i need FIFOs to
support minit.  so i merged a couple different versions to get one
that handles the extended device file format (erik andersen's??), and
a small patch to handle FIFOs.

> And as usual, there is two sides to initramfs. It may  be  convenient
> for some cases, where you can use the very same root filesystem image
> bundled  with the kernel image, but exactly thsi convenience may hurt
> you in other cases where it's much better  when  you  have  separated
> images which can be updated independently of each other.
>
> Speaking for myself: I don't see advantages in it. None.

i most likely wouldn't use it for the final build, but it would still
be more efficient for testing, rather than reflashing the root
filesystem on the unit every time.  once the image is finalized, then
i can flash the kernel and rootFS separately.

rday

p.s.  of course, this assumes GNU cpio can handle FIFOs.  oops, better
check that.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

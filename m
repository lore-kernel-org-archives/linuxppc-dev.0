Message-ID: <400C455A.3080603@mvista.com>
Date: Mon, 19 Jan 2004 15:00:10 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stable File System for embedded product
References: <A3240F62EF3C2749B1A25D3BC9548F410309BE@ExchWENZ02.wenz.global.vpn>
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F410309BE@ExchWENZ02.wenz.global.vpn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just from the FHS perspective (the file system standard for Linux)

everything on linux can (and should be) read-only mounted, with the
following exceptions:

   /etc/mtab -- It can be a symlink to /proc/mounts (or a link to a
writable location)

   /tmp  -- mount as a tmpfs (or link to /var/tmp)
   /var  -- mount again as a tmpfs, or a read-write storage

Of course each distribution varies and applications, distributions, etc
have bugs when it comes to FHS compliance..  but this should be the
end-goal for all systems to be standards based.

(For my own systems, usually I have /etc on a read-write capable disk..
but mount read-only..  /etc/mtab is a symlink to /proc/mounts, /tmp is a
symlink to /var/tmp.  /var/tmp is tmpfs.. the rest of var is either
tmpfs or a read-write disk depending on the application.)

--Mark

Rod Boyce wrote:
> I would much more strongly suggest not mounting this partition
> read-write as this is most likely what is corrupting the partition also
> try noatime as well.  /etc is required for boot up so I would suggest
> changing the way you use /etc.  We have soft links to another location
> on another file system and keep /etc combined with the root file system.
> Upwards of 10K power cycles can't be wrong.
>
>
> Rod
>
>
>>-----Original Message-----
>>From: Alex Zeffertt [mailto:ajz@cambridgebroadband.com]
>>Sent: Monday, 19 January 2004 11:04 p.m.
>>To: S. Hebbar
>>Cc: linuxppc-embedded@lists.linuxppc.org
>>Subject: Re: Stable File System for embedded product
>>
>>
>>Are you using a flash device (i.e. /dev/mtdblockN) for /etc?  If so,
>>then I would recommend JFFS for this partition.  JFFS2 is (supposedly)
>>more reliable, but we have found that you can't fit it on a flash
>>partition of only 4 flash sectors since it needs more than that for
>>scratch.
>>
>>If it's not flash then maybe you should consider ext3 - a journalling
>>extension to ext2.
>>
>>Alex
>>
>>On Mon, 2004-01-19 at 06:23, S. Hebbar wrote:
>>
>>>Hello,
>>>
>>>I am trying to find which file system is the best for
>>>/etc partition on an embedded linux platform.
>>>
>>>I am using the following file systems for linux & rootfs:-
>>>Linux: CramFS (linux 2.4.20 denx) (read-only)
>>>RootFS: CramFS  (read-only)
>>>
>>>At the moment, I am using ext2 partition for /etc (read-write)
>>>But, 1 out of  4 power-cycles of the board corrupts the
>>>/etc partition.
>>>
>>>Any information related to the above topic is
>>>grately appreciated.
>>>
>>>Regards,
>>>S. Hebbar.
>>>
>>>
>>
>>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3E848479.2030405@mvista.com>
Date: Fri, 28 Mar 2003 11:20:57 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: Jaap-Jan Boor <jjboor@lucent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash File System Concerns
References: <20030328171108.15068.qmail@web41213.mail.yahoo.com>
In-Reply-To: <20030328171108.15068.qmail@web41213.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash kanthi wrote:
> Folks,
>
> I have one concern regarding FFS. If you use flash for
> your entire filesystem including /var/log, /proc,
> etc.., you will be accessing flash too many times.
>
> And there is good chance that, your flash on the board
> reaches maximum number of accesses/writes limited by
> flash technology.
>
> How do people generally handle that in the industry.
> Especially, if you have on-board (non-replaceable)
> flash?

/proc is mounted from teh system and does not use flash.

Under the rules of the FHS, /var and /tmp should be mounted as a Read-Write
filesystem, the rest of the system (depending on options and distribution) can
be mounted Read-Only.

Now then, if you need things preserved between system reboots then you need to
have /var mounted on a "perminant" storage system.  /tmp can be mounted w/ the
"tmpfs" filesystem.  (Basically a ramdisk.)

The way that I generally recommend this stuff to customers is to symbolically
link /tmp to /var/tmp, mount /var as a tmpfs filesystem and then create the log,
spool, lock, etc directories as required for the system during the initscripts.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

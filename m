Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04103c34b2bf2769a22d@[206.163.71.146]>
In-Reply-To: <199901101714.SAA00311@piglet.cpu.lu>
Date: Sun, 10 Jan 1999 20:05:22 -0800
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: Strange tar hang....
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:14 +0100 1999-01-10, Michel Lanners wrote:
>Anybody can help with this?
>
>For many kernel versions now, I have problems with tar. On extraction
>of any archive, tar will regularly 'hang', and only continue extraction
>after a few seconds of doing nothing.
>Could this be a problem in the networking code of the kernel?

tar tries to look up UIDs and GIDs in the tar file and match them to 
local users. With the default /etc/nsswitch.conf, it will end up 
trying NIS and other services.
You probably want something like:
<<
passwd:         db files
group:          db files
shadow:         db files

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       db files
>>

Try `info libc "Name Service Switch"' for more info on NSS.
--
Joel Klecker (aka Espy)                     <URL:http://web.espy.org/>
<URL:mailto:jk@espy.org>                  <URL:mailto:espy@debian.org>
Debian GNU/Linux PowerPC -- <URL:http://www.debian.org/ports/powerpc/>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Thu, 4 Mar 1999 17:35:53 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: MVME 2306 almost up and running
Message-ID: <Pine.SO4.4.05.9903041715480.4479-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just reporting some progress for those who are interested...

The kernel, v2.2.1, correctly boots, but was unable to mount its
NFS root fs. I have tracked the problem down to BOOTP. I do not
know whether this a flaw in the Linux kernel BOOTP method or an
error made by me (if you can clear this up, please do. My ego
can take a couple more hits ;-).

Because I wanted to separate the root fs from the tftpboot directories,
I have to use both the 'hd' tag as the 'rp' (remote path) tag in BOOTP.

The problem was located at the 'rp' tag. I used a full NFS-style name,
'nfshost:/path', while Linux will want to mount 'nfshost:/path' on 
host 'nfshost', instead of '/path' on 'nfshost'. After changing the
'rp' value to '/path', it works fine. My question : then how do I
set an other NFS server than the BOOTP server for the client ?
(I know : nfsaddr can do the job - for Linux clients).

I always thought it was possible to use different hosts.

BTW, the Linux BOOTP kernel sequence doesn't seem to recognize
the domain name, "domain=(none)", any ideas on that ? 

My final question : our board now finally boots, it can mount an
NFS partition as root fs, but does anybody know where on the Internet
I can find a file system tree with the binaries for LinuxPPC ? I mean,
like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
machines, so I need a full binary file tree to set up on the NFS fs).

Kind regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"- His high exaltedness the great Jabba the Hutt has decreed that you are
   to be terminated immediately.
 - Good. I hate long waits."
 Han Solo, 'Star Wars : Return of the Jedi'




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

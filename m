Date: Fri, 5 Mar 1999 12:49:26 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <Pine.SO4.4.05.9903041715480.4479-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990305120205.3871C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 4 Mar 1999, David De Ridder wrote:

> 
> Hi,
> 
> just reporting some progress for those who are interested...
> 
> The kernel, v2.2.1, correctly boots, but was unable to mount its
> NFS root fs. I have tracked the problem down to BOOTP. I do not
> know whether this a flaw in the Linux kernel BOOTP method or an
> error made by me (if you can clear this up, please do. My ego
> can take a couple more hits ;-).
> 
> Because I wanted to separate the root fs from the tftpboot directories,
> I have to use both the 'hd' tag as the 'rp' (remote path) tag in BOOTP.
> 
> The problem was located at the 'rp' tag. I used a full NFS-style name,
> 'nfshost:/path', while Linux will want to mount 'nfshost:/path' on 
> host 'nfshost', instead of '/path' on 'nfshost'. After changing the
> 'rp' value to '/path', it works fine. My question : then how do I
> set an other NFS server than the BOOTP server for the client ?
> (I know : nfsaddr can do the job - for Linux clients).

AFAICT, there is no provision to use a different host for the loaded
file (the kernel image) and the root path. You may use the sa tag in your
bootptab file to tell which TFTP server to use and which NFS host to mount
the root file system. 

> I always thought it was possible to use different hosts.

2 hosts, yes, but not 3 (bootp server+ TFTP server for image to download +
server to mount root on NFS). The last 2 must be the same if I understand
correctly, or at least from the code in the current linux implementation. 
(Although the RFC are quite nebulous in this respect, see RFC1533 and tell
me if you understand it differently). 

> BTW, the Linux BOOTP kernel sequence doesn't seem to recognize
> the domain name, "domain=(none)", any ideas on that ? 

Don't mix up DNS domain names and YP domain names. Yes, I know it's
confusing and I'm not yet sure to have understood all the subtleties
(I'm not a network guru by any stretch of the imagination):
hostname 
hostname -d <=> dnsdomainname
hostname -f <=> hostname.dnsdomainname
hostname -y <=> ypdomainname

which is/are used it depends on your /etc/nsswitch.conf file.

> NFS partition as root fs, but does anybody know where on the Internet
> I can find a file system tree with the binaries for LinuxPPC ? I mean,
> like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
> machines, so I need a full binary file tree to set up on the NFS fs).

I would recommend for now Linux/PPC R4, but with some compiler/libraries
upgrade. Find a well stocked mirror nearby, for me it's Spain or
Switzerland (I never got to upload even a minimal R5 release since it 
seems RPM formats have changed, but I did not try very hard). 

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Fri, 5 Mar 1999 14:47:13 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <Pine.HPP.3.96.990305120205.3871C-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9903051439290.20952-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 5 Mar 1999, Gabriel Paubert wrote:

> On Thu, 4 Mar 1999, David De Ridder wrote:
> > 
> > The problem was located at the 'rp' tag. I used a full NFS-style name,
> > 'nfshost:/path', while Linux will want to mount 'nfshost:/path' on 
> > host 'nfshost', instead of '/path' on 'nfshost'. After changing the
> > 'rp' value to '/path', it works fine. My question : then how do I
> > set an other NFS server than the BOOTP server for the client ?
> > (I know : nfsaddr can do the job - for Linux clients).
> 
> AFAICT, there is no provision to use a different host for the loaded
> file (the kernel image) and the root path. You may use the sa tag in your
> bootptab file to tell which TFTP server to use and which NFS host to mount
> the root file system. 

 I see.

> > I always thought it was possible to use different hosts.
> 
> 2 hosts, yes, but not 3 (bootp server+ TFTP server for image to download +
> server to mount root on NFS). The last 2 must be the same if I understand
> correctly, or at least from the code in the current linux implementation. 

 You might be right : I may have mixed up those two. It has been a couple
 of months since I last read the RFCs.

> (Although the RFC are quite nebulous in this respect, see RFC1533 and tell
> me if you understand it differently). 

 I'll reread the concerning RFCs, and try to find a conclusive answer.

> > BTW, the Linux BOOTP kernel sequence doesn't seem to recognize
> > the domain name, "domain=(none)", any ideas on that ? 
> 
> Don't mix up DNS domain names and YP domain names. Yes, I know it's
> confusing and I'm not yet sure to have understood all the subtleties
> (I'm not a network guru by any stretch of the imagination):
> hostname 
> hostname -d <=> dnsdomainname
> hostname -f <=> hostname.dnsdomainname
> hostname -y <=> ypdomainname
> 
> which is/are used it depends on your /etc/nsswitch.conf file.

 Thanks for the explanation. Aside from that, it showed an error
 on my server : seems like I did not set the DNS domainname correctly.
 (The bootp server does have a tag for it, but the server doesn't know
  its own domain - stupid me).

> > NFS partition as root fs, but does anybody know where on the Internet
> > I can find a file system tree with the binaries for LinuxPPC ? I mean,
> > like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
> > machines, so I need a full binary file tree to set up on the NFS fs).
> 
> I would recommend for now Linux/PPC R4, but with some compiler/libraries
> upgrade. Find a well stocked mirror nearby, for me it's Spain or
> Switzerland (I never got to upload even a minimal R5 release since it 
> seems RPM formats have changed, but I did not try very hard). 

 OK, I'll start with an R4, and then upgrade when necessary.

 Kind regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"I want another cup of coffffeeee !"
 - drunk in 'Some like it hot' (1959)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Tue, 9 Mar 1999 17:33:20 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: On the BOOTP ``root path'' option
Message-ID: <Pine.SO4.4.05.9903091703410.10681-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[A few days ago, there was some confusion on how the root path option
 provided by BOOTP was supposed to be interpreted by the BOOTP sequence
 of a kernel. I promised to do some research in the RFCs. This is the
 result.]

The main question was : should the BOOTP ``rp'' (root path) option be
NFS-style, e.g. nfsserver:/export/path, or does the kernel have to
expect /export/path, and contact its TFTP server as NFS server ?

(Note : this discussion was unrelated to the ``nfsaddrs'' kernel boot
        argument ; so we'll disregard it here. Only BOOTP, TFTP and
        NFS are involved).

1) RFC 1395, which defines the root path option, didn't prove very 
   useful on defining its correct syntax. This is stated :

   "A string to specify a pathname to mount as a root disk."
   
   Not much, heh ?

2) RFC 1533, isn't very conclusive either :

   "This option specifies the path-name that contains the client's root
    disk.  The path is formatted as a character string consisting of
    characters from the NVT ASCII character set."

    BTW, ``NVT ASCII'' seems to be (Network Virtual Terminal) 7-bit ASCII. 

3) RFC 2132 has the same info (or lack of) as RFC 1533.

So, still searching for a conclusive answer. However, I also looked for
a positive statement that root path should be resident on the TFTP
server. This was stated in no RFC, at least not in the ones I scanned
through. ==> Yes, it makes sense to use the TFTP as NFS server, since
the syntax of Root Path seems to be undefined. But no, it isn't an
obligation -- Root Path may be interpreted as you want (I think).

My personal opinion : if a BOOTP client sees a normal path, it should
contact its TFTP server as NFS server ; however, if it sees and NFS-style
path, it should extract the NFS server from the path. (This would require
an "intelligent" client - seems like the right job for Linux ! ;-)

If anyone can shed some light on this whole syntax matter, please do.

Remarks, suggestions, ... fire away !

Regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Every dog has its day, and today's mine."
 Terry Borer after winning the Masters finals at the New York M:TG Pro Tour 



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Mon, 22 Mar 1999 11:40:44 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <qppv62evdh.fsf@erbium.epact.se>
Message-ID: <Pine.SO4.4.05.9903221116410.18896-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 21 Mar 1999, Michael Lundkvist wrote:

> This works just great!!! Thanks! 
> 
> One more win for the LinuxPPC-developers. Now I'll put Linux on every
> MVME2307 card I can find around here! :)

Nice. I wish I could say the same for our MVME2306...
I now strongly suspect NFS of obstructing progress ;-)
I also believe I am doing something incredibly stupid, and being
even more stupid not to see what's wrong. So if anyone can help me,
go ahead.

OK, so here's how far I've come :

- The MVME2306 correctly finds its BOOTP and TFTP server (they are the
  same). This very server is a Linux/i386 with 2.0.36 installed, and
  also serves as NFS server for the board's root file system.
- After the BOOTP phase, the board fetches Gabriels kernel (2.2.1 with
  NFS root support) with TFTP.
- Thanks to prepboot, I am able to type ``root=/dev/nfs'' at the
  boot prompt.
- Now, the Linux kernel starts. It initializes eth0 etc., and then
  starts its own BOOTP sequence. The data shown in ``IP-Config:''
  makes sense, the last line being :
  ``IP-Config: host=143.169.5.29, domain=(none), path=/export/''

  And indeed, the board address should be this, and the path on the
  NFS server (which is also TFTP server) to mount as root, is /export/.
- The kernel now starts an RPC sequence, contacts portmap (I guess)
  on the NFS server, and then says :
  ``VFS: Mounted root (NFS filesystem) read-only''.
- In the server's /var/adm/messages, I also get (I stripped the dates) :
  ``elpc6 mountd[67]: NFS mount of /export attempted from 143.169.5.29
    elpc6 mountd[67]: /export has been mounted by 143.169.5.29''

   If my /etc/exports is incorrect, I get the expected messages in syslog.
   But this is not the case now, since the board is valid client.
 - However, then, after initializing the serial console (I think), the
   board says :
   ``Kernel panic: no init found. Try passing init= option to kernel.''

So, I'm stuck. FTR, I tried using the init= option, e.g. ``init=/bin/sh''.
The relevant line in my /etc/exports is :

``/export/        elvme1.uia.ac.be(rw,no_root_squash,insecure)''

The insecure option is AFAIK not necessary, and initially I left it out.
I've also tried ``nfsroot=/export'', but with no effect.

One other thing : I've tried exporting the same filesystem (/export/) to
DECstation 3100. Something strange goes on : I export it rw, when I mount
it, the DEC recognizes it as rw, but I only have ro access ! I can
browse directories, read files, but NOT create files or change their
timestamp.  Maybe this is a DEC problem (it's pretty old), or caused by
the reason I don't know. 

Any help is appreciated,

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

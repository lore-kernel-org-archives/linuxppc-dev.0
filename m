Message-ID: <3735ABD1.6CD838E@wanadoo.fr>
Date: Sun, 09 May 1999 17:37:53 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org
CC: "Charles E. Leiserson, Jr." <locutus@MIT.EDU>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: $OSTYPE
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 03 May 1999, "Charles E. Leiserson, Jr." <locutus@MIT.EDU>
wrote:

> 
> Probably a stupid question but...
> 
> Why does 'echo $OSTYPE' give me 'mklinux' when I'm runnin LinuxPPC R4.1?
> 

I think this is a problem of tcsh. It is not present in bash. It comes
from the fact is that RedHat thinks the only linux on ppc is mklinux.
You get VENDOR=apple, too.

Below is a patch for tcsh-6.08.00-5. I hope the linuxppc developers put
something like this in R5. (Of course, the "vendor" could be left empty,
giving "unknown", or be replaced by "BlueCat" or something similar).

--
Martin

--- /usr/src/redhat/BUILD/tcsh-6.08.00/host.defs.ori    Sun May  9
17:03:05 1999
+++ /usr/src/redhat/BUILD/tcsh-6.08.00/host.defs        Sun May  9
17:06:54 1999
@@ -438,13 +438,12 @@
 hosttype: defined(M_i586)                              : "i586-linux"
 hosttype: defined(M_i486)                              : "i486-linux"
 hosttype: defined(M_i386)                              : "i386-linux"
-ostype : !defined(PPC)                                 : "linux"
-ostype : defined(PPC)                                  : "mklinux"
+ostype :                                               : "linux"
 machtype: defined(M_i586)                              : "i586"
 machtype: defined(M_i486)                              : "i486"
 machtype: defined(M_i386)                              : "i386"
 vendor : defined(__alpha)                              : "dec"
-vendor : defined(PPC)                                  : "apple"
+vendor : defined(PPC)                                  : "linuxppc"
 hosttype: defined(__alpha)                             : "alpha"
 hosttype: defined(PPC)                                 : "powerpc"
 machtype: defined(__alpha)                             : "alpha"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

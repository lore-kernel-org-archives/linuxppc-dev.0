Mime-Version: 1.0
Message-Id: <v04220827b49fa1e99714@[192.168.0.1]>
In-Reply-To: <20000109142900.A17353@suse.de>
References: <20000108171526.B8126@suse.de>
 <v04220818b49df84590b1@[192.168.0.1]> <38785B2C.7807E8FD@wanadoo.fr>
 <20000109142900.A17353@suse.de>
Date: Mon, 10 Jan 2000 05:58:01 -0900
To: linuxppc-dev@lists.linuxppc.org, Martin Costabel <costabel@wanadoo.fr>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: write into OF tree like nvsetenv
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 9/1/2000 Olaf Hering wrote:

>
>I want exactly this automatic. This works fine on the current IDE Macs,
>but with a B&W Scsi Mac a "typical" User has lost.
>The path on my Mac is something like
>
>/pci/pci-bridge/ADPT,2940U2B/@6:7,blah
>
>Too complex.

agreed, OF device paths are gross ;)

I have two comments on this, one this can be automatic if you make 
the bootstrap partition look like a MacOS bootdisk  (as my ybin 
scripts will do) and the mac-boot function `should' find it and see 
it as bootable and load the bootfile(*) automatically, however this 
is quite slow, it can take up to 2 to 5 MINUTES for this to occur (at 
least on my B&W with a adaptec 2930).

(*) bootfile as in the file in the blessed directory with a HFS file 
type of tbxi, my scripts will set the OF script to this if a OF 
script is used and if not the yaboot file gets it.

the other problem, is there is currently no way to determine the OF 
device path of a Linux device file, we cannot tell what /dev/sdb3's 
OF path is, BenH tells me to add this would require modification of 
every block device driver (which opens a big can of worms).

in short we have 2 problems right now: 1) we cannot write to OF nvram 
from linux at the moment and 2) we cannot figure out WHAT to write to 
it...


-- 
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

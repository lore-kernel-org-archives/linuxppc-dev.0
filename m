Message-Id: <5.1.0.14.2.20021126155728.02406c88@falcon.si.com>
Date: Tue, 26 Nov 2002 16:03:43 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Hung inside execve 
In-Reply-To: <20021126204034.87211C614B@atlas.denx.de>
References: <Your message of "Tue, 26 Nov 2002 11:55:29 PST." <B0CD235912AED411B69800D0B7C9F60F1DF88A@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:40 PM 11/26/2002 +0100, Wolfgang Denk wrote:

>In message <B0CD235912AED411B69800D0B7C9F60F1DF88A@mail> you wrote:
> >
> > I have been going through the LinuxPPC archives, looking for answers to my
> > problem, but still could not proceed ahead. My problem is that the Linux
> > will hang after the line 'execve("bin/sh", argv_init, envp_init);' inside
> > the init function of the file main.c. I have added the printk statements
> > preceding each of the execve calls. The last prink should be right before
> > the panic statement but it did not get executed, therefore I suspect that
> > the culprit is 'execve("bin/sh", argv_init, envp_init);' .

For what it is worth, my first thought when I saw this is that you probably
have a shared library missing on your RAM disk.  As suggested by Wolfgang,
use NFS and see where your system stops requesting files and what file it
(probably) was unable to find.  You can use binutils & company to figure
out what symbols/libraries are needed by /bin/sh, but it is generally
easier to just run it using NFS and sniff the ether.

>Ummm... in situations like this life is _much_ easier  when  you  can
>use a debugger. Get yourself a BDI2000!

BDI-2000: better than chicken soup for whatever ails you ;-)

gvb

[lots more good advice snipped]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

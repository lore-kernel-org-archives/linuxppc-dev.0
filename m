Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <waite@skycomputers.com>
To: Jerry Van Baren <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root woes: No init found
Date: Wed, 4 Dec 2002 18:03:21 -0500
References: <3DEE7FA8.7000908@bluewin.ch> <5.1.0.14.2.20021204174346.0243ead8@falcon.si.com>
In-Reply-To: <5.1.0.14.2.20021204174346.0243ead8@falcon.si.com>
MIME-Version: 1.0
Message-Id: <200212041803.21704.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is my /etc/exports:
/home   *(rw,insecure,no_root_squash)

That should be sufficent I think .

Thanks
Brian

On Wednesday 04 December 2002 5:47 pm, Jerry Van Baren wrote:
> Thoughts...
>
> Does your mount command
> * use the defaults options (-o defaults) or equivalent?
>    - includes read/write and execute privileges
>
> Does your host
> * have "no_root_squash" (may not be necessary)?
> * allow write access to the remote host?
>
> gvb
>
> At 05:30 PM 12/4/2002 -0500, Brian Waite wrote:
> >I tried loading the ash shell statically linked., along with a dynamically
> >linked bash. No executables seem to load. I have traced the execve call
> > and it progresses as far as walking the format list to determine what
> > format the file is in. After walking all the available formats, it can't
> > find one and fails. I have the floowing formats in my kernel:
> >CONFIG_KCORE_ELF=y
> >CONFIG_BINFMT_ELF=y
> >CONFIG_KERNEL_ELF=y
> >
> >and the ash executale is an elf:
> >ash.static: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1,
> >statically linked, stripped
> >
> >Any thoughts? I see the packets getting revieved by the gt64260_eth driver
> > and passed up to the higher layers. I also look at the various MIB
> > counters and see no errant packets so I can't why NFS is so cranky.
> >
> >Thanks
> >Brian
> >
> >On Wednesday 04 December 2002 5:20 pm, you wrote:
> > > Hello,
> > >
> > > if you get to the bash prompt you could try to start the init program
> > > manually. This should result in more useful error messages.
> > >
> > > Hope it helps,
> > >
> > > Wolfgang.
> > >
> > > On 12/04/2002 11:11 PM Brian Waite wrote:
> > > > I did this. I tried to start a staticly linked ash shell to no avail.
> > > > No libs are better than any libs :)
> > > > Thanks
> > > > Brian
> > > >
> > > > On Wednesday 04 December 2002 4:48 pm, Dan Malek wrote:
> > > >> Brian Waite wrote:
> > > >> > ...Then I get the message No init found.
> > > >>
> > > >> First, try using something simple like /bin/bash as your init
> > > >> program. Trying to start up the init program relies on lots of
> > > >> things being present in the file system.  If the program starts, and
> > > >> then exits, you still get this message.
> > > >>
> > > >> Just use a trivial, simple file system to get started.  A shell,
> > > >> couple of commands and minimal libraries are easier to debug.
> > > >>
> > > >> Good luck :-)
> > > >>
> > > >>    -- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

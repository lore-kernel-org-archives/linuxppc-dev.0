Date: Sat, 27 Jan 2001 21:12:45 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Richard Michael <michael@cs.toronto.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi trouble (SG_SET_TIMEOUT) on 7200-120 w/ 2.2.17: cdrecord 10a04
Message-ID: <20010127211245.A24897@allspice.cs.swarthmore.edu>
References: <00Nov15.121907edt.453141-25831@jane.cs.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00Nov15.121907edt.453141-25831@jane.cs.toronto.edu>; from michael@cs.toronto.edu on Wed, Nov 15, 2000 at 12:19:02PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does this happen only when you try to burn a dik in disk-at-once mode,
by any chance?  The symptoms you report sound eerily similar to what I
see on the mesh SCSI controller in my 7500 when I try to burn a disk in
disk-at-once mode.  But track-at-once mode works fine for me.

-Daniel

On Wed, Nov 15, 2000 at 12:19:02PM -0500, Richard Michael <michael@cs.toronto.edu> wrote:
> Hello Everyone,
>
> This is regarding SCSI errors using 2.2.17, on a 7200 w/ a single 53c94
> scsi controller, a sony cdu948s burner and cdrecord 10a04, compiled with
> gcc 2.95.2 on a glibc 2.1.3 system.
>
> I've exchanged email with J"org regarding this problem and he suggested
> a possible compiler or kernel issue, and I'm not sure what to do now.
> I don't think this is entirely off topic, but I'm sorry if this is
> inappropriate traffic on this list.  I've read the archives regarding
> drow's cdrecord difficulties, and this seems slightly different.
>
> Given the above config, I run cdrecord (built w/ smake w/ -g opts to compiler
> and linker) and receive this error:
> ------
> <SNIP - normal cdrecord stuff up to here pretty much>
> Waiting for reader process to fill input buffer ... input buffer ready.
> Starting new track at sector: 0
> Track 01:   0 of 417 MB written../cdrecord: Device not configured. Cannot set SG
> _SET_TIMEOUT.
> Currently running 'write_continue' command.
> Condition not caught: SCSI ALREADY RUNNING !!.
> Raisecond: not implemented.
> Aborted
> [root@chesslawn ppc-linux-cc]#
> ------
>
> At this point, I can still move around the filesystem, but most commands
> return I/O errors, including 'reboot', for example:
> (note: the 'ls' below does complete normally, hence the <SNIP>)
> ------
> [root@chesslawn /sbin]# reboot
> bash: /sbin/reboot: Input/output error
> [root@chesslawn /sbin]# ls -l
> ls: ldconfig: Input/output error
> ls: sln: Input/output error
> ls: chkconfig: Input/output error
> ls: install-info: Input/output error
> ls: badblocks: Input/output error
> ls: debugfs: Input/output error
> ls: service: Input/output error
> ls: pwdb_chkpwd: Input/output error
> ls: poweroff: Input/output error
> ls: shutdown: Input/output error
> ls: sulogin: Input/output error
> ls: telinit: Input/output error
> ls: getty: Input/output error
> ls: uugetty: Input/output error
> total 3865
> -rwxr-xr-x   1 root     root         4908 Apr 18  1999 accton
> -rwxr-xr-x   1 root     root        35876 Jan 28  2000 arp
> -rwxr-xr-x   1 root     root        58912 Jan 28  2000 cfdisk
> -rwxr-xr-x   1 root     root         8024 Apr 18  1999 clock
> -rwxr-xr-x   1 root     root         4280 Jan 28  2000 ctrlaltdel
> <SNIP - rest of output from 'ls' normal, and back to bash prompt>
> ------
>
> The machine is pretty much useless at this stage, and I can't reboot it
> nicely.  The machine and the recorder must be power cycled to reset.
>
> 'cdrecord -scanbus' works properly.
>
> I can post my kernel .config file (maybe I left something out of the config?)
> and the output from strace, if they would help.
>
> I've been using cdrecord on a variety of platforms (including x86 linux)
> for quite some time, but have never seen this.  I'm quite certain that the
> scsi devices are all properly terminated, etc. (but I'll triple check :).
>
> Any comments?
>
> Thanks everyone.
> Cheers,
> Richard

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

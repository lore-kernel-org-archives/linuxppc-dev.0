Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040605192221.GT15195@smtp.west.cox.net>
References: <40BF3206.8030705@intracom.gr>
	 <1086426744.4588.121.camel@imladris.demon.co.uk>
	 <20040605192221.GT15195@smtp.west.cox.net>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jun 2004 23:02:09 +0100
Message-Id: <1086472929.4862.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-06-05 at 12:22 -0700, Tom Rini wrote:
> On Sat, Jun 05, 2004 at 10:12:24AM +0100, David Woodhouse wrote:
>
> > On Thu, 2004-06-03 at 17:13 +0300, Pantelis Antoniou wrote:
> > > Hi
> > >
> > > The following patch updates the new CPM1/CPM2 uart driver.
> >
> > It seems to lose queued characters from the kernel output when userspace
> > /dev/console is first opened. Should you drain the FIFO before resetting
> > the hardware on open? Or indeed refrain from resetting the hardware if
> > you're not actually changing anything?
>
> I haven't seen this problem on 8xx myself.

8265 here.

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 100k iné
sh-2.05b#

> > This is with console on ttyCPM0 == SMC1. SysRq is also non-functional.
>
> SysRq is fixed in the linuxppc-2.5 tree now.

There's something weird about the console output if I hit SysRq-B. It's
as if each 32-bit word is rotated by 8 bits before being sent. The oops
I expect -- I know machine_restart() doesn't work and I'll fix if if I
have the toy in question here at home without automatic power control
for any length of time. But I do expect the oops to be readable :)

SysRq : ResettinttihMac inecchenk ir ke nelemodC.
eausyd br (fSom =RR10410 0):nTrarsfer eraor sck aignOl
:opsc maehine ch ck,:sig[ 7
 ... etc...

Also, userspace is broken without panto's _tlbia() hack in
update_mmu_cache().

Btw, someone with shell access to the linuxppc BK tree needs to manually
edit SCCS/s.ChangeSet and fix the checksum on this changeset:

ChangeSet@1.497.3879.2, 2004-04-09 10:55:30-07:00, rvinson@linuxbox.(none)
  Updating Force PCore to 2.6

This should do it:
	perl -pi -e s/K64684/K65408/ SCCS/s.ChangeSet

(for reference, if you 'bk export -tpatch' the offending cset it'll tell
you what the checksum is and what it should be.).

Then 'get ChangeSet' and it'll bitch about the checksum. Edit
SCCS/s.ChangeSet and fix the 'Hxxxxx' checksum in the very first line,
correcting it to the value it just gave you.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

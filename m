Date: Sat, 29 Mar 2003 16:55:01 +0100
From: Boris Bezlaj <boris@gajba.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
Message-ID: <20030329155501.GA587@gajba.net>
References: <16004.27866.270601.561756@gargle.gargle.HOWL> <16005.35950.570218.844672@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16005.35950.570218.844672@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 29, 2003 at 11:07:10PM +1100, Paul Mackerras wrote:
>
> This finally prodded me to look at the mach driver.  I've hacked the
> linux swim3 driver to do things in a more similar fashion to what the
> mach driver does.  It now seems to not get stuck on the dreaded 04
> error and generally seems a lot more robust.  Try this patch and let
> me know how it goes.


With a good floppy the driver works well reading and writing. No more
positioning errors..good work Paul 8)

Bad floppy case:
| kista:/tmp# dd if=swimmer of=/dev/fd0 bs=512 count=2880
| swim3: timeout reading sector 2647
| end_request: I/O error, dev 02:00 (floppy), sector 2647   <--bad sector
| dd: writing `/dev/fd0': Input/output error
| 2647+0 records in
| 2646+0 records out
| 1354752 bytes transferred in 134.614549 seconds (10064 bytes/sec)

after the error at sector 2647, swim3 seems to move the heads to sector 0
and write? another 2647 sectors. Any particular reason for that ?

Most importantly, when changing the floppy, it still works (not the
case with the unpatched driver).
--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

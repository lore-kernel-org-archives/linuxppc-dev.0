Mime-Version: 1.0
Message-Id: <v04220800b5da6bf366cb@[10.0.0.42]>
In-Reply-To: <20000901110221.5823@mailhost.mipsys.com>
References: <v04220803b5d51a99c774@[10.0.0.42]>
 <20000901110221.5823@mailhost.mipsys.com>
Date: Tue, 5 Sep 2000 02:32:29 -0700
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Content-Type: multipart/mixed; boundary="============_-1243976144==_============"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1243976144==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

At 1:02 PM +0200 9/1/00, Benjamin Herrenschmidt wrote:
>>
>>1. Resource conflicts are reported for the CMD646 IDE controller and
>>an Adaptec 2940UW card
>
>Please, send me logs of dmesg, /proc/device-tree (with lsprop), and /
>proc/pci.

OK, finally got a chance to play with 2.4 again.  Here they are.

>>4. Probably due to the resource conflict problem, the aic7xxx driver
>>doesn't recognize the 2940.  This is a showstopper for me because my
>>
>>root partition's on a drive connected to the 2940.
>
>I'll see what I can do.

I managed to boot 2.4 from the SCSI drive and get the above logs by
using the hack Tom Rini suggested (comment out a test in aic7xxx
which rejects improperly configured PCI devices).  Thanks, Tom!

Booting takes a long time thanks to the cmd646 driver taking a very
long time to figure out that it's screwed, but once it's up 2.4 seems
OK on this box.

I did have one further problem.  Since the installation on this box
is LPPC 2K, it uses labels rather than device numbers to mount
partitions.  Label based mounting appears to be quite broken in 2.4,
it couldn't find the root partition at all.  I think I've seen this
mentioned before on the main linux-kernel mailing list, but I'm not
sure.  In any case, I just rebooted the box with 2.2 and changed
fstab to mount by device instead of label, and then 2.4 was happy.

I also tried Geert's PCI patch (the one on sourceforge), but it
caused a kernel panic during boot.
--============_-1243976144==_============
Content-Id: <v04220800b5da6bf366cb@[10.0.0.42].0.0>
Content-Type: application/octet-stream; name="frankenmac-logs.tar.bz2"
 ; x-mac-type="42494E41"
 ; x-mac-creator="68446D70"
Content-Disposition: attachment; filename="frankenmac-logs.tar.bz2"
 ; modification-date="Tue, 5 Sep 2000 02:22:50 -0700"
Content-Transfer-Encoding: x-uuencode

begin 644 frankenm.bz2
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
A,`?2$-Y+TOBD-XA[_8@'?Y?*I^^"__B[DBG"A(:N2>&H
`
end

--============_-1243976144==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"


   Tim Seufert
--============_-1243976144==_============--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

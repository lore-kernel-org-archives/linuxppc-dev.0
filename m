Message-ID: <3A324D80.90E2CE17@home.com>
Date: Sat, 09 Dec 2000 10:19:28 -0500
From: Mike Stilson <mstilson@home.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Sound on iMac,1 w/2.4test12
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I asked this first on ppc-user (with test11) didn't hear anything, so
thought I'd ask here.
Well, in a nutshell, the problem is that other than a simple beep I
can't
manage to get any sound out of the machine (2.2 kernels worked just
fine)

Ok, I'm lying already.  gtcd will play a cd just fine.  that's it.
The mixer works, I can hear the volume change of the little clicks it
gives me.

Trying to start esd, I get about 1/2 way through the startup beeps and
it hangs.
(I have to then kill it off with gdb), but any other program (such as
mpg123)
simply generates no output whatsoever.

With test11 it failed initializing the DMA, with test12 (from bk
yesterday)
it starts up same as it used to with 2.2
$ dmesg|grep ^DMA
DMA sound driver installed, using 4 buffers of 32k.

I've tried recompiling with various settings, etc.  At best I get the
same results.
Switching back to 2.2, it works fine again.

I'm using yaboot with no MacOS left to change anything with Mac.

Using devfsd (stock install, all old compatible options, etc)
After manually remaking sndstat
$ cat /dev/sndstat
PowerMac (AWACS rev 100) DMA sound driver:
	sound.format = 0x8 (unsigned 8 bit)
	sound.speed = 8000Hz (phys. 44100Hz)
	sound.stereo = 0x0 (mono)
	sq.block_size = 0 sq.max_count = 0 sq.max_active = 0
	sq.count = 0 sq.rear_size = 0
	sq.active = 0 sq.syncing = 0

And finally, if it's any help:
[/proc/device-tree/pci/mac-io/davbus/sound]# for i in `dir`; do echo
$i;cat -v $i;echo;echo "----";done

#input-channels
^@^@^@^O
----
input-encoding-types
16bit-BE-signed-linear^@
----
output-frame-rates
^@^@M-,D
----
#output-channels
^@^@^@^H
----
input-frame-rates
^@^@M-,D
----
sample-frame-size
^@^@^@
----
compatible
burgundy^@awacs^@^@
----
model
343S0177^@
----
sample-precisions
^@^@^@^P
----
device-id
^@^@^@^A
----
name
sound^@
----
sub-frame
^@^@^@^@
----
device_type
sound^@
----
output-encoding-types
16bit-BE-signed-linear^@
----
vendor-id
^@^@^Pk
----


Any help is much appreciated... anything else needed to know, just ask.
-mike

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

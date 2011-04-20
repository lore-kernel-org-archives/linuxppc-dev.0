Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 001DB1007DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 06:44:45 +1000 (EST)
Date: Wed, 20 Apr 2011 13:44:41 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: "Schwarz,Andre" <andre.schwarz@matrix-vision.de>
Subject: Re: tmpfs size restriction
Message-ID: <20110420204441.GB29394@ovro.caltech.edu>
References: <211009162.1147.1303327260364.JavaMail.open-xchange@proteus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <211009162.1147.1303327260364.JavaMail.open-xchange@proteus>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2011 at 09:21:00PM +0200, Schwarz,Andre wrote:
> Hi,
> 
> I'm facing an issue with tmpfs mounts on PowerPC (mpc83xx specifically).
> 
> After "mount -t tmpfs tmpfs /tmp -o size=16m" I can fill the machine's mem
> (512MiB) until oom becomes active.
> 
> I can't see this on any other machine (x86/ARM) I have access to.
> There's always a "no space left on device" message as soon as size specified is
> reached ...
> 
> kernel versions available are v2.6.26.27 and v2.6.34.7 showing the same
> behaviour.
> 
> I'd expect the kernel to limit available tmpfs size to 50% of physical memory
> anyway.
> 
> Any ideas what might be wrong ?
> 

For what it is worth, I tried this on an 8349EA board, using 2.6.38rc8.
It behaved exactly as I would expect. A short log is below. Maybe your
mount command parses options differently on the powerpc machine? Try it
with the mount options before the mount points?

iws@carmaboard7 ~ $ mkdir mnt
mkdir: cannot create directory `mnt': File exists
iws@carmaboard7 ~ $ ls mnt/
iws@carmaboard7 ~ $ sudo mount -t tmpfs -o size=16m,users none mnt
iws@carmaboard7 ~ $ ls mnt/
iws@carmaboard7 ~ $ mount | grep mnt
none on /home/iws/mnt type tmpfs (rw,nosuid,nodev,noexec,relatime,size=16384k)
iws@carmaboard7 ~ $ cd ^C
iws@carmaboard7 ~ $ dd if=/dev/zero of=mnt/file.bin bs=1M count=18
dd: writing `mnt/file.bin': No space left on device
16+0 records in
15+0 records out
16760832 bytes (17 MB) copied, 0.313836 s, 53.4 MB/s
iws@carmaboard7 ~ $ du -b mnt/file.bin 
16760832        mnt/file.bin
iws@carmaboard7 ~ $ df -h mnt
Filesystem            Size  Used Avail Use% Mounted on
none                   16M     -     -   -  /home/iws/mnt
iws@carmaboard7 ~ $ uname -a
Linux carmaboard7.correlator.pvt 2.6.38-rc8-00028-g24d6894 #1 Tue Mar 8 09:48:15 PST 2011 ppc e300c1 GNU/Linux
iws@carmaboard7 ~ $ cat /proc/cpuinfo 
processor       : 0
cpu             : e300c1
clock           : 533.333328MHz
revision        : 3.1 (pvr 8083 0031)
bogomips        : 133.29
timebase        : 66646782
platform        : MPC834x MDS
model           : CARMA
Memory          : 256 MB

Hope it helps,
Ira

Date: Tue, 1 Oct 2002 23:54:43 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Location for Linux kernel module support files
Message-ID: <20021002075443.GB26324@plato.local.lan>
References: <5.1.0.14.2.20021001100707.02dbfb50@mail.attbi.com> <3D99F21B.5090408@mrsl.com>
Mime-Version: 1.0
In-Reply-To: <3D99F21B.5090408@mrsl.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 01, 2002 at 03:06:03PM -0400, Tim Moloney wrote:
> I want to distribute a standard FPGA program file with the module and
> have it loaded at system boot time.  I can create an rc script to copy
> this file to the /proc entry.  I can package the module, rc script, and
> FPGA file in an RPM.  I just need to determine a reasonable location for
> the FPGA file (since I know where to put the module and rc script).
>
> The custom FPGA files can be distributed with their respective
> applications and can be packaged in RPMs.
>
> Perhaps there is no good answer to this.  I thought that this situation
> happened enough that people had found a reasonable location for support
> files.

http://www.pathname.com/fhs/

if its not a configuration file which is intended to be edited by the
admin then it does NOT belong in /etc.  if its a architecture specific
file, but not a command executable then it belongs in /usr/lib unless
its required before filesystems are mounted in which cases it belongs
in /lib.

if its a architecture independent, non-executable file then it belongs
in /usr/share

the /lib /usr/lib and /usr/share cases indicate a subdirectory since
its not a actual shared library.

your Makefile make install step should install things in
/usr/local/lib or /usr/local/share (agian unless this is required to
get filesystems mounted, in that case it has to go in /lib).  debian
packages or rpms would install things under /usr/lib.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

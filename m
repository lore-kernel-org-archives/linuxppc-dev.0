Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B1243F436404D511A5CF009027E705DA04EC49EC@uswaumsx09medge.med.ge.com>
From: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
To: "'Steven Blakeslee'" <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: execute from flash?
Date: Mon, 25 Feb 2002 16:23:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Sure there are modifications for the cramfs filesystem that
utilizes the sticky bit to force those files to be aligned such that
they can be executed in flash. You can then place the cramfs filesystem
in flash and only execute the files that you have specifically tagged (
sticky bit) for execution.
	There are also modifictions to the kernel that allow execution
from flash.

I am using both modifications on a version of HH2.0 linux for our
hardware that is MPC823 based. I got from MVista to implement these
changes. I was hoping that it would show up in the next release of HH.
If want I will put together a tarball with the required file for you. My
current kernel is 2.4.2 but that should not pose to much of a problem.

-----Original Message-----
From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
Sent: Monday, February 25, 2002 2:17 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: execute from flash?



Does anyone know how I can run a program in flash from my embedded linux
kernel that is also running in flash?  Below is the code that I tried
but it
did not work.  It compiles but does not run correctly.

typedef int (codePtr(char *info));

void main(char *argv)
{
	int addr = 0xfff80000;
	codePtr* startloc = (codePtr *)addr;
	(startloc(argv));
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <A1C99F4731CAD111BA5400A024FC3B0CF26DC8@ESBILMA01EDCGE>
From: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Out of Memory: Killed process ...
Date: Mon, 24 Mar 2003 09:54:35 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi everybody:

		We have our custom PPCBoard that features
16 MB of RAM. The problem comes when writting files into the JFFS2
or even in the "ramfs", but in latter case it is less evident. What happens
is that the kernel kills some running processes because the system
runs out of memory.

	I don´t think that writting files is the cause of the problem, but
it reflects the "true" problem and it is that there is no enough memory.
We get messages from the kernel like

	"Out of Memory: Killed process ...."

and the memory available before writting files is more or less:

	500 Kb of free memory
	1.2 Mb of cached memory

and Linux starts killing processes when cached memory falls below 1 Mb.
AFAIK it is correct because the free memory is near the lowest limit allowed
by the kernel.

	There is another resource that plays an important role and it is the
time that Linux has for itself. Also we have RTAI and our RT tasks
control the time given for Linux. Now it is 6 ms out of 12 for Linux, but I
think
that the less time Linux has,  the more memory problems will appear, because

in some way memory-time resources are linked each other. Imagine that
RT tasks leave messages for Linux processes, for example, for writting data
in files; the less Linux takes the control the more writtings will need to
be done.

My questions are:

	1.- Do you think that this behavior is correct? Is the VFS, JFFS2 or
  	    RAMFS working badly (I don´t think so)? Is right the statement
that
	    when the kernel needs memory it may even kill Linux processes to
	    get some?

	2.- What are the criteria that the kernel takes into account
	     when killing processes? I mean, what processes are killed
	     first, and what are killed later? Is there any way from the
user
	     point of view to set the process priority in case of being
killed?
	     I mean, to set what process may be killed first and what later?

	3.- What are the minimum memory requirements for the system to
	     work fine? I think that there is three free memory thresholds
for Linux
	     and they are 1.5 MB, 1 MB and 500 Kb (worst case). So can we
	     conclude that if Linux has over 1.5 Mb of free memory the
system
	     health is good and that the memory problems may appear when
	     free memory is around 500 Kb?

	4.- Do you think that the less time Linux has for itself, the more
memory
	     problems?


	Any hint or advice will be welcome to solve this problem. If you
think that
some other things may have an impact on the problem, let me know.

							Thank you
								Billa


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

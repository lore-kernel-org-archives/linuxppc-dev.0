Message-Id: <5.1.0.14.0.20020521144711.0312fc28@sgss.com>
Date: Tue, 21 May 2002 16:58:40 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Dean McBride <dmcbride@sgss.com>
Subject: Un-killable process???
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a process I can't kill (kill -9) without rebooting the system.  I've
attempted
attaching strace, gdb, etc. to the process, but each of those task just
hang.  I
can however kill those task (strace, gdb).  I've looked through the /proc/<pid>
area, but don't really know what I'm looking for or at!  The task seems to be
somehow stuck on some resource, but I don't know which one or how to find
out.  I'm running with Linux 2.4.10-pre10 on a 4 processor Power PC with
512Mbytes of memory.  The process is reading data from a PMC card.

Any ideas or suggestions?  I've include some more information below!

Thanks
Dean

Here's the output from the ps command:
    74 root     root     R /opt/ds/src/lm1/bin/lm1_read -s 4 -m 255 -f 4000
-a -r -u 2 -g 1


Heres the /proc/74/status file

sh-2.03# more /proc/74/status
Name:   lm1_read
State:  R (running)
Pid:    74
PPid:   62
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups: 0
VmSize:     2580 kB
VmLck:      2580 kB
VmRSS:      2580 kB
VmData:     1128 kB
VmStk:        16 kB
VmExe:        20 kB
VmLib:      1188 kB
SigPnd: 0000000000044102
SigBlk: 0000000000000000
SigIgn: 8000000000000000
SigCgt: 0000000000004002
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff

/proc/74/statm file

sh-2.03# more /proc/74/statm
645 645 317 17 0 628 328


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <20021217124416.13690.qmail@web20108.mail.yahoo.com>
Date: Tue, 17 Dec 2002 04:44:16 -0800 (PST)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: memory management bug??
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEECEFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1140501742-1040129056=:13619"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-1140501742-1040129056=:13619
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I was making some tests in my linux box and I just
realized that when the system goes to a "low memory
state" kswapd gets almost all the cpu, I've got this
from top (see attached file). But the worst I guess is
that I can't see to where my memory has gone, top
output and /proc/meminfo seems to be "hidding" some
...
I'm using kernel 2.4.4 from Denx, is there memory leak
in this kernel version? How can I reduce kswapd cpu
usage?

Thanks in advance,

Owen.

--0-1140501742-1040129056=:13619
Content-Type: text/plain; name="memory_problems_output.txt"
Content-Description: memory_problems_output.txt
Content-Disposition: inline; filename="memory_problems_output.txt"

 12:34am  up 34 min,  0 users,  load average: 1.37, 1.33, 0.89
9 processes: 7 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   7.2% user,  92.8% system,   0.0% nice,   0.0% idle
Mem:     14712K total,    13696K used,     1016K free,     6144K buffers
Swap:        0K total,        0K used,        0K free,     4812K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    3 root      16   0     0    0     0 RW   78.4  0.0  12:20 kswapd
  150 root      18   0   420  428   120 R    18.9  2.8   0:19 top
    5 root       9   0     0    0     0 SW    2.9  0.0   0:28 bdflush
    1 root       8   0   144  144     0 S     0.0  0.9   0:26 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:01 kupdated
   21 root       9   0   212  212     0 S     0.0  1.4   0:11 sh
  106 root       9   0   224  224     0 S     0.0  1.5   0:00 xinetd

# ps
  PID  Uid     Stat Command
    1 root     S    init
    2 root     S    [keventd]
    3 root     R    [kswapd]
    4 root     S    [kreclaimd]
    5 root     S    [bdflush]
    6 root     S    [kupdated]
   21 root     S    -sh
  106 root     S    xinetd
  151 root     R    ps
#
--0-1140501742-1040129056=:13619--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <38870F4A.44918575@global2000.net>
Date: Thu, 20 Jan 2000 08:36:11 -0500
From: "Andrew B. Arthur" <arthur99@global2000.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX slowdown
References: <20000119150258.016197@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> Please, could you do the following test:
>
>  - boot with BootX 1.2b3 in the exact same configuration that usually
> triggers the slowdown problem. You may eventually boot single user or
> even "init=/bin/sh" so that it doesn't take for ever to reach bash prompt.

Running on a PowerMacintosh 4400/200. BootX 1.2b3 and BootX 1.1.3
results listed below. Linux hagoleche.aarthur.bsdonline.org 2.2.14 #1
Sun Jan 16 02:39:35 EST 2000 ppc unknown


>  - cat /proc/interrupts and send me the result

Here is the /proc/interrupts and /proc/cpuinfo I saved from earlier
using BootX 1.2b3:

[AArthur@hagoleche AArthur]$ cat ~/interrupts.12b3
           CPU0
  4:          0   PMAC-PIC      SCC-txdma
  5:          0   PMAC-PIC      SCC-rxdma
  6:          0   PMAC-PIC      SCC-txdma
  7:          0   PMAC-PIC      SCC-rxdma
  8:          0   PMAC-PIC      AWACS out
 12:        125   PMAC-PIC      MESH
 13:       2861   PMAC-PIC      ide0
 14:          3   PMAC-PIC      ide1
 15:          0   PMAC-PIC      SCC
 16:          0   PMAC-PIC      SCC
 17:          0   PMAC-PIC      AWACS
 18:       3469   PMAC-PIC      VIA
 19:          0   PMAC-PIC      SWIM3
BAD:          0


[AArthur@hagoleche AArthur]$ cat ~/cpuinfo.12b3
processor       : 0
cpu             : 603ev
clock           : 200MHz
revision        : 2.1
bogomips        : 11.39
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/217 (0%)
machine         : Power Macintosh
motherboard     : AAPL,e826 MacRISC
L2 cache        : 256K unified
memory          : 32MB


Here is my current setup (using BootX 1.1.3):

[AArthur@hagoleche AArthur]$ cat /proc/interrupts
           CPU0
  4:          0   PMAC-PIC      SCC-txdma
  5:      16262   PMAC-PIC      SCC-rxdma
  6:          0   PMAC-PIC      SCC-txdma
  7:          0   PMAC-PIC      SCC-rxdma
  8:      35864   PMAC-PIC      AWACS out
 12:      15898   PMAC-PIC      MESH
 13:      54305   PMAC-PIC      ide0
 14:       8063   PMAC-PIC      ide1
 15:     190585   PMAC-PIC      SCC
 16:          0   PMAC-PIC      SCC
 17:          0   PMAC-PIC      AWACS
 18:     564944   PMAC-PIC      VIA
 19:          0   PMAC-PIC      SWIM3
BAD:          0

[AArthur@hagoleche AArthur]$ cat /proc/cpuinfo
processor       : 0
cpu             : 603ev
clock           : 200MHz
revision        : 2.1
bogomips        : 133.12
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/323 (0%)
machine         : Power Macintosh
motherboard     : AAPL,e826 MacRISC
L2 cache        : 256K unified
memory          : 32MB

Andrew B. Arthur | arthur99@global2000.net |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

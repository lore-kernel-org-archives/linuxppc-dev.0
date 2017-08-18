Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xYXNy5Yz8zDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 15:55:14 +1000 (AEST)
Date: Fri, 18 Aug 2017 08:37:46 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
Message-ID: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
RAM and after some time of sddm respawning and X trying to restart, 
dmesg is full of messages about vmap allocation failures.

Maybe the aty128fb is leaking ROM allocations or something like that?

sddm has been crashing eearlier too but I have not investigated it yet, 
but right after reboot the messages are about ATI ROM contents:

Aug 17 23:53:57 pohl kernel: [ 2940.146546] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
Aug 17 23:54:02 pohl kernel: [ 2944.804838] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1110
Aug 17 23:54:06 pohl kernel: [ 2948.992457] sddm[14039]: unhandled signal 11 at 00000030 nip 00000030 lr 0f55f858 code 30001

Then it changes to groups like this:
Aug 17 23:54:29 pohl kernel: [ 2971.514484] sddm[14093]: unhandled signal 11 at 00000090 nip 00000090 lr 0f55f858 code 30001
Aug 17 23:54:30 pohl kernel: [ 2972.994486] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
Aug 17 23:54:30 pohl kernel: [ 2973.040595] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
Aug 17 23:54:33 pohl kernel: [ 2976.245220] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
Aug 17 23:54:33 pohl kernel: [ 2976.295452] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size

And finally it becomes just vmalloc errors, no ATI ROM messages at all:

[32075.316981] sddm[14563]: unhandled signal 11 at 00000050 nip 00000050 lr 0f55f858 code 30001
[32076.766965] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32076.788476] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32079.124735] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32079.146326] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32081.305352] sddm[14590]: unhandled signal 11 at 00000050 nip 00000050 lr 0f55f858 code 30001
[32082.768060] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32082.789530] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32085.125847] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32085.147228] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32087.311193] sddm[14617]: unhandled signal 11 at 00430068 nip 00430068 lr 0f55f858 code 30001
[32088.767983] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32088.789536] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32091.108732] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32091.130348] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32093.285222] sddm[14644]: unhandled signal 11 at 00000050 nip 00000050 lr 0f55f858 code 30001
[32094.767678] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32094.789329] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32097.128241] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32097.149745] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32099.293082] sddm[14671]: unhandled signal 11 at 00000030 nip 00000030 lr 0f55f858 code 30001
[32100.768030] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32100.789505] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size
[32103.124223] vmap allocation for size 135168 failed: use vmalloc=<size> to increase size
[32103.145881] vmap allocation for size 3149824 failed: use vmalloc=<size> to increase size


# cat /proc/meminfo 
MemTotal:        1031440 kB
MemFree:          135948 kB
MemAvailable:     889288 kB
Buffers:          215448 kB
Cached:           573780 kB
SwapCached:           44 kB
Active:           430480 kB
Inactive:         392416 kB
Active(anon):      14984 kB
Inactive(anon):    92276 kB
Active(file):     415496 kB
Inactive(file):   300140 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:        262144 kB
HighFree:          22140 kB
LowTotal:         769296 kB
LowFree:          113808 kB
SwapTotal:        848984 kB
SwapFree:         848464 kB
Dirty:               180 kB
Writeback:             0 kB
AnonPages:         33640 kB
Mapped:            84392 kB
Shmem:             73592 kB
Slab:              66972 kB
SReclaimable:      54952 kB
SUnreclaim:        12020 kB
KernelStack:         680 kB
PageTables:         1344 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1364704 kB
Committed_AS:     351992 kB
VmallocTotal:     211808 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB



-- 
Meelis Roos (mroos@linux.ee)

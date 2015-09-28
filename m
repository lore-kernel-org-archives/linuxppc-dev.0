Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f193.google.com (mail-yk0-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 005C01A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 20:45:29 +1000 (AEST)
Received: by ykdg206 with SMTP id g206so14368864ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 03:44:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Date: Mon, 28 Sep 2015 13:44:42 +0300
Message-ID: <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] powerpc:numa Add serial nid support
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 nikunj@linux.vnet.ibm.com, nacc@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, anton@samba.org, grant.likely@linaro.org,
 cl@linux.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gkurz@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/27/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
> Problem description:
> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
> got from device tree is naturally mapped (directly) to nid.

Interesting thing to play with, I'll try to test it on my POWER7 box,
but it doesn't have the OPAL layer :(

>
> Potential side effect of that is:
>
> 1) There are several places in kernel that assumes serial node numbering.
> and memory allocations assume that all the nodes from 0-(highest nid)
> exist inturn ending up allocating memory for the nodes that does not exist.
>
> 2) For virtualization use cases (such as qemu, libvirt, openstack), mapping
> sparse nid of the host system to contiguous nids of guest (numa affinity,
> placement) could be a challenge.
>
> Possible Solutions:
> 1) Handling the memory allocations is kernel case by case: Though in some
> cases it is easy to achieve, some cases may be intrusive/not trivial.
> at the end it does not handle side effect (2) above.
>
> 2) Map the sparse chipid got from device tree to a serial nid at kernel
> level (The idea proposed in this series).
> Pro: It is more natural to handle at kernel level than at lower (OPAL)
> layer.
> con: The chipid is in device tree no longer the same as nid in kernel
>
> 3) Let the lower layer (OPAL) give the serial node ids after parsing the
> chipid and the associativity etc [ either as a separate item in device tree
> or by compacting the chipid numbers ]
> Pros: kernel, device tree are on same page and less change in kernel
> Con: is it the functionality expected in lower layer
>
> As mentioned above, current patch series tries to map chipid from lower
> layer
> to a contiguos nid at kernel level keeping the node distance calculation and
> so on intact.
>
> Result:
> Before the patch: numactl -H
>
> available: 4 nodes (0-1,16-17)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> 24 25 26 27 28 29 30 31
> node 0 size: 31665 MB
> node 0 free: 29836 MB
> node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
> 53 54 55 56 57 58 59 60 61 62 63
> node 1 size: 32722 MB
> node 1 free: 32019 MB
> node 16 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84
> 85 86 87 88 89 90 91 92 93 94 95
> node 16 size: 32571 MB
> node 16 free: 31222 MB
> node 17 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111
> 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> node 17 size: 0 MB
> node 17 free: 0 MB
> node distances:
> node   0   1  16  17
>   0:  10  20  40  40
>   1:  20  10  40  40
>  16:  40  40  10  20
>  17:  40  40  20  10
>
> After the patch: numactl -H
>
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> 24 25 26 27 28 29 30 31
> node 0 size: 31665 MB
> node 0 free: 30657 MB
> node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
> 53 54 55 56 57 58 59 60 61 62 63
> node 1 size: 32722 MB
> node 1 free: 32566 MB
> node 2 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84
> 85 86 87 88 89 90 91 92 93 94 95
> node 2 size: 32571 MB
> node 2 free: 32401 MB
> node 3 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
> 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> node 3 size: 0 MB
> node 3 free: 0 MB
> node distances:
> node   0   1   2   3
>   0:  10  20  40  40
>   1:  20  10  40  40
>   2:  40  40  10  20
>   3:  40  40  20  10
>
> (note that numa distances are intact). Apart from this, The following tests
> are done with the patched kernel (both baremetal and KVM guest with multiple
> nodes) to ensure there is no breakage.
>
> 1) offlining and onlining of memory in /sys/devices/system/node/nodeX path
>
> 2) offlining and onlining of cpus in /sys/devices/system/cpu/ path
>
> 3) Numactl tests from
> ftp://oss.sgi.com/www/projects/libnuma/download/numactl-2.0.10.tar.gz
>
> (infact there were more breakage before the patch because of sparse nid
> and memoryless node cases of powerpc)
>
> 4) Thousands of docker containers were spawned.
>
> Please let me know your comments.
>
>  patch 1-3: cleanup patches
>  patch 4: Adds helper function to map nid and chipid
>  patch 5: Uses the mapping to get serial nid
>
> Raghavendra K T (5):
>   powerpc:numa Add numa_cpu_lookup function to update lookup table
>   powerpc:numa Rename functions referring to nid as chipid
>   powerpc:numa create 1:1 mappaing between chipid and nid
>   powerpc:numa Add helper functions to maintain chipid to nid mapping
>   powerpc:numa Use chipid to nid mapping to get serial numa node ids
>
>  arch/powerpc/include/asm/mmzone.h |   2 +-
>  arch/powerpc/kernel/smp.c         |  10 ++--
>  arch/powerpc/mm/numa.c            | 121
> +++++++++++++++++++++++++++++++-------
>  3 files changed, 105 insertions(+), 28 deletions(-)
>
> --
> 1.7.11.7
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

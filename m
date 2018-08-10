Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n9wn5qxVzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 02:45:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AGi3rl189085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 12:45:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ksdg4t6f5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 12:45:42 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 17:45:41 +0100
Date: Fri, 10 Aug 2018 09:45:33 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180808075840.GO2494@hirez.programming.kicks-ass.net>
Message-Id: <20180810164533.GB42350@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <peterz@infradead.org> [2018-08-08 09:58:41]:

> On Wed, Aug 08, 2018 at 12:39:31PM +0530, Srikar Dronamraju wrote:
> > With Commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> > sched domain") scheduler introduces an extra numa level. However that
> > leads to
> > 
> >  - numa topology on 2 node systems no more marked as NUMA_DIRECT.  After
> >    this commit, it gets reported as NUMA_BACKPLANE. This is because
> >    sched_domains_numa_level now equals 2 on 2 node systems.
> > 
> >  - Extra numa sched domain that gets added and degenerated on most
> >    machines.  The Identity node is only needed on very few systems.
> >    Also all non-numa systems will end up populating
> >    sched_domains_numa_distance and sched_domains_numa_masks tables.
> > 
> >  - On shared lpars like powerpc, this extra sched domain creation can
> >    lead to repeated rcu stalls, sometimes even causing unresponsive
> >    systems on boot. On such stalls, it was noticed that
> >    init_sched_groups_capacity() (sg != sd->groups is always true).
> 
> The idea was that if the topology level is redundant (as it often is);
> then the degenerate code would take it out.
> 
> Why is that not working (right) and can we fix that instead?
> 

Here is my analysis on another box showing same issue.
numactl o/p

available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 32 33 34 35 36 37 38 39 64 65 66 67 68 69 70 71 96 97 98 99 100 101 102 103 128 129 130 131 132 133 134 135 160 161 162 163 164 165 166 167 192 193 194 195 196 197 198 199 224 225 226 227 228 229 230 231 256 257 258 259 260 261 262 263 288 289 290 291 292 293 294 295
node 0 size: 536888 MB
node 0 free: 533582 MB
node 1 cpus: 24 25 26 27 28 29 30 31 56 57 58 59 60 61 62 63 88 89 90 91 92 93 94 95 120 121 122 123 124 125 126 127 152 153 154 155 156 157 158 159 184 185 186 187 188 189 190 191 216 217 218 219 220 221 222 223 248 249 250 251 252 253 254 255 280 281 282 283 284 285 286 287
node 1 size: 502286 MB
node 1 free: 501283 MB
node 2 cpus: 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 80 81 82 83 84 85 86 87 112 113 114 115 116 117 118 119 144 145 146 147 148 149 150 151 176 177 178 179 180 181 182 183 208 209 210 211 212 213 214 215 240 241 242 243 244 245 246 247 272 273 274 275 276 277 278 279
node 2 size: 503054 MB
node 2 free: 502854 MB
node 3 cpus: 8 9 10 11 12 13 14 15 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 104 105 106 107 108 109 110 111 136 137 138 139 140 141 142 143 168 169 170 171 172 173 174 175 200 201 202 203 204 205 206 207 232 233 234 235 236 237 238 239 264 265 266 267 268 269 270 271 296 297 298 299 300 301 302 303
node 3 size: 503310 MB
node 3 free: 498465 MB
node distances:
node   0   1   2   3
  0:  10  40  40  40
  1:  40  10  40  40
  2:  40  40  10  40
  3:  40  40  40  10

Extracting the contents of dmesg using sched_debug kernel parameter

CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
....
....
CPU302 attaching NULL sched-domain.
CPU303 attaching NULL sched-domain.
BUG: arch topology borken
     the DIE domain not a subset of the NODE domain
BUG: arch topology borken
     the DIE domain not a subset of the NODE domain
.....
.....
BUG: arch topology borken
     the DIE domain not a subset of the NODE domain
BUG: arch topology borken
     the DIE domain not a subset of the NODE domain
BUG: arch topology borken
     the DIE domain not a subset of the NODE domain

 CPU0 attaching sched-domain(s):
   domain-2: sdA, span=0-303 level=NODE
    groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
CPU1  attaching sched-domain(s):
   domain-2: sdB, span=0-303 level=NODE
[  367.739387]     groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }


CPU8  attaching sched-domain(s):
   domain-2: sdC, span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
    groups: sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
    domain-3: sdD, span=0-303 level=NUMA
     groups: sgX 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sgY 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgZ 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
ERROR: groups don't span domain->span

CPU9  attaching sched-domain(s):
   domain-2: sdE span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
    groups: sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
    domain-3: sdF span=0-303 level=NUMA
     groups: sgP 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sgQ 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgR 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
ERROR: groups don't span domain->span


Trying to summarize further

+ Node sched domain groups are initialised with build_sched_groups (that
tried to share groups)
+ Numa sched domain groups are initialised with build_overlap_sched_groups

Cpu 0: sdA->groups  sgL  ->next= sgM ->next= sgN ->next= sgO
Cpu 1: sdB->groups  sgL  ->next= sgM ->next= sgN ->next= sgO

However
Cpu 8: sdC->groups -> sgM ->next= sgM  (NODE)
Cpu 8: sdD->groups  sgX  ->next= sgY ->next= sgZ (NUMA)
Cpu 9: sdE->groups -> sgM ->next= sgM  (NODE)
Cpu 1: sdB->groups  sgP  ->next= sgQ ->next= sg (NUMA)

In init_sched_group_capacity(), When we start with sdB->groups and reach sgM
but sgM->next happens to be sgM. However sdB->groups != sdM

With non-identity NUMA sched_domains, build_overlap_sched_groups creates new
groups per sched-domain, so the problem is masked.

i.e On a topology update, the sched_domain_numa_mask aren't getting updated.
causing very wierd sched domains. The Identity node sched domain further
complicates the problem.

One solution would be to expose sched_domain_numa_mask_set/clear so that the
archs can help build correct/proper sched_domains.

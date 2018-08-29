Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420fLC2xGlzF315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:44:03 +1000 (AEST)
Date: Wed, 29 Aug 2018 10:43:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Message-ID: <20180829084348.GO24124@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180810164533.GB42350@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2018 at 09:45:33AM -0700, Srikar Dronamraju wrote:

> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 32 33 34 35 36 37 38 39 64 65 66 67 68 69 70 71 96 97 98 99 100 101 102 103 128 129 130 131 132 133 134 135 160 161 162 163 164 165 166 167 192 193 194 195 196 197 198 199 224 225 226 227 228 229 230 231 256 257 258 259 260 261 262 263 288 289 290 291 292 293 294 295
> node 0 size: 536888 MB
> node 0 free: 533582 MB
> node 1 cpus: 24 25 26 27 28 29 30 31 56 57 58 59 60 61 62 63 88 89 90 91 92 93 94 95 120 121 122 123 124 125 126 127 152 153 154 155 156 157 158 159 184 185 186 187 188 189 190 191 216 217 218 219 220 221 222 223 248 249 250 251 252 253 254 255 280 281 282 283 284 285 286 287
> node 1 size: 502286 MB
> node 1 free: 501283 MB
> node 2 cpus: 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 80 81 82 83 84 85 86 87 112 113 114 115 116 117 118 119 144 145 146 147 148 149 150 151 176 177 178 179 180 181 182 183 208 209 210 211 212 213 214 215 240 241 242 243 244 245 246 247 272 273 274 275 276 277 278 279
> node 2 size: 503054 MB
> node 2 free: 502854 MB
> node 3 cpus: 8 9 10 11 12 13 14 15 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 104 105 106 107 108 109 110 111 136 137 138 139 140 141 142 143 168 169 170 171 172 173 174 175 200 201 202 203 204 205 206 207 232 233 234 235 236 237 238 239 264 265 266 267 268 269 270 271 296 297 298 299 300 301 302 303
> node 3 size: 503310 MB
> node 3 free: 498465 MB
> node distances:
> node   0   1   2   3
>   0:  10  40  40  40
>   1:  40  10  40  40
>   2:  40  40  10  40
>   3:  40  40  40  10
> 
> Extracting the contents of dmesg using sched_debug kernel parameter
> 
> CPU0 attaching NULL sched-domain.
> CPU1 attaching NULL sched-domain.
> ....
> ....
> CPU302 attaching NULL sched-domain.
> CPU303 attaching NULL sched-domain.
> BUG: arch topology borken
>      the DIE domain not a subset of the NODE domain

^^^^^ CLUE!!

but nowhere did you show what it thinks the DIE mask is.

>  CPU0 attaching sched-domain(s):
>    domain-2: sdA, span=0-303 level=NODE
>     groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> CPU1  attaching sched-domain(s):
>    domain-2: sdB, span=0-303 level=NODE
> [  367.739387]     groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }

You forgot to provide the rest of it... what's domain-[01] look like?

DIE(j) should be:

	cpu_cpu_mask(j) := cpumask_of_node(cpu_to_node(j))

and NODE(j) should be:

	\Union_k cpumask_of_node(k) ; where node_distance(j,k) <= node_distance(0,0)

which, _should_ reduce to:

	cpumask_of_node(j)

and thus DIE and NODE _should_ be the same here.

So what's going sideways?

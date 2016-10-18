Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syj3s3dHqzDt2d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 15:37:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <20161017193047.GC6248@htj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
 <20161017181556.GB6248@htj.duckdns.org>
 <20161017193047.GC6248@htj.duckdns.org>
Date: Tue, 18 Oct 2016 15:37:42 +1100
Message-ID: <87y41mb7c9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tejun Heo <tj@kernel.org> writes:

> Hello, Michael.
>
> Other NUMA archs are lazy-initializing cpu to node mapping too, so we
> need to fix it from workqueue side.  This also means that we've been
> getting NUMA node wrong for percpu pools on those archs.
>
> Can you please try the following patch and if it resolves the issue,
> report the workqueue part (it's at the end) of sysrq-t dump?
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 984f6ff..276557b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4411,14 +4411,14 @@ void show_workqueue_state(void)
> @@ -5571,6 +5571,9 @@ int __init workqueue_init(void)
>  	struct worker_pool *pool;
>  	int cpu, bkt;
>  
> +	wq_numa_init();
> +	wq_update_unbound_numa(wq, smp_processor_id(), true);
> +

That doesn't compile, wq doesn't exist.

I guessed that you meant:

+       wq_numa_init();
+       list_for_each_entry(wq, &workqueues, list)
+               wq_update_unbound_numa(wq, smp_processor_id(), true);


And that does boot.

The sysrq-t output is below, it's rather large.

cheers


Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300:
 cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286:
 cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234:
 cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222:
 cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184:
 cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132:
 cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122:
 cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88:
 cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=1/256
    pending: dbs_work_handler
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28:
 cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue events_highpri: flags=0x10
  pwq 319: cpus=159 node=17 flags=0x0 nice=-20 active=0/256
  pwq 317: cpus=158 node=17 flags=0x0 nice=-20 active=0/256
  pwq 315:
 cpus=157 node=17 flags=0x0 nice=-20 active=0/256
  pwq 313: cpus=156 node=17 flags=0x0 nice=-20 active=0/256
  pwq 311: cpus=155 node=17 flags=0x0 nice=-20 active=0/256
  pwq 309:
 cpus=154 node=17 flags=0x0 nice=-20 active=0/256
  pwq 307: cpus=153 node=17 flags=0x0 nice=-20 active=0/256
  pwq 305: cpus=152 node=17 flags=0x0 nice=-20 active=0/256
  pwq 303: cpus=151 node=17 flags=0x0 nice=-20 active=0/256
  pwq 301: cpus=150 node=17 flags=0x0 nice=-20 active=0/256
  pwq 299: cpus=149 node=17 flags=0x0 nice=-20 active=0/256
  pwq 297: cpus=148 node=17 flags=0x0 nice=-20 active=0/256
  pwq 295: cpus=147 node=17 flags=0x0 nice=-20 active=0/256
  pwq 293: cpus=146 node=17 flags=0x0 nice=-20 active=0/256
  pwq 291: cpus=145 node=17 flags=0x0 nice=-20 active=0/256
  pwq 289: cpus=144 node=17 flags=0x0 nice=-20 active=0/256
  pwq 287: cpus=143 node=17 flags=0x0 nice=-20 active=0/256
  pwq 285: cpus=142 node=17 flags=0x0 nice=-20 active=0/256
  pwq 283: cpus=141 node=17 flags=0x0 nice=-20 active=0/256
  pwq 281: cpus=140 node=17 flags=0x0 nice=-20 active=0/256
  pwq 279: cpus=139 node=17 flags=0x0 nice=-20 active=0/256
  pwq 277: cpus=138 node=17 flags=0x0 nice=-20 active=0/256
  pwq 275: cpus=137 node=17 flags=0x0 nice=-20 active=0/256
  pwq 273: cpus=136 node=17 flags=0x0 nice=-20 active=0/256
  pwq 271: cpus=135 node=17 flags=0x0 nice=-20 active=0/256
  pwq 269: cpus=134 node=17 flags=0x0 nice=-20 active=0/256
  pwq 267: cpus=133 node=17 flags=0x0 nice=-20 active=0/256
  pwq 265:
 cpus=132 node=17 flags=0x0 nice=-20 active=0/256
  pwq 263: cpus=131 node=17 flags=0x0 nice=-20 active=0/256
  pwq 261: cpus=130 node=17 flags=0x0 nice=-20 active=0/256
  pwq 259: cpus=129 node=17 flags=0x0 nice=-20 active=0/256
  pwq 257: cpus=128 node=17 flags=0x0 nice=-20 active=0/256
  pwq 255: cpus=127 node=17 flags=0x0 nice=-20 active=0/256
  pwq 253: cpus=126 node=17 flags=0x0 nice=-20 active=0/256
  pwq 251: cpus=125 node=17 flags=0x0 nice=-20 active=0/256
  pwq 249: cpus=124 node=17 flags=0x0 nice=-20 active=0/256
  pwq 247: cpus=123 node=17 flags=0x0 nice=-20 active=0/256
  pwq 245: cpus=122 node=17 flags=0x0 nice=-20 active=0/256
  pwq 243: cpus=121 node=17 flags=0x0 nice=-20 active=0/256
  pwq 241: cpus=120 node=17 flags=0x0 nice=-20 active=0/256
  pwq 239: cpus=119 node=16 flags=0x0 nice=-20 active=0/256
  pwq 237: cpus=118 node=16 flags=0x0 nice=-20 active=0/256
  pwq 235: cpus=117 node=16 flags=0x0 nice=-20 active=0/256
  pwq 233: cpus=116 node=16 flags=0x0 nice=-20 active=0/256
  pwq 231: cpus=115 node=16 flags=0x0 nice=-20 active=0/256
  pwq 229: cpus=114 node=16 flags=0x0 nice=-20 active=0/256
  pwq 227: cpus=113 node=16 flags=0x0 nice=-20 active=0/256
  pwq 225: cpus=112 node=16 flags=0x0 nice=-20 active=0/256
  pwq 223: cpus=111 node=16 flags=0x0 nice=-20 active=0/256
  pwq 221: cpus=110 node=16 flags=0x0 nice=-20 active=0/256
  pwq 219:
 cpus=109 node=16 flags=0x0 nice=-20 active=0/256
  pwq 217: cpus=108 node=16 flags=0x0 nice=-20 active=0/256
  pwq 215: cpus=107 node=16 flags=0x0 nice=-20 active=0/256
  pwq 213: cpus=106 node=16 flags=0x0 nice=-20 active=0/256
  pwq 211: cpus=105 node=16 flags=0x0 nice=-20 active=0/256
  pwq 209:
 cpus=104 node=16 flags=0x0 nice=-20 active=0/256
  pwq 207: cpus=103 node=16 flags=0x0 nice=-20 active=0/256
  pwq 205: cpus=102 node=16 flags=0x0 nice=-20 active=0/256
  pwq 203: cpus=101 node=16 flags=0x0 nice=-20 active=0/256
  pwq 201: cpus=100 node=16 flags=0x0 nice=-20 active=0/256
  pwq 199: cpus=99 node=16 flags=0x0 nice=-20 active=0/256
  pwq 197: cpus=98 node=16 flags=0x0 nice=-20 active=0/256
  pwq 195:
 cpus=97 node=16 flags=0x0 nice=-20 active=0/256
  pwq 193:
 cpus=96 node=16 flags=0x0 nice=-20 active=0/256
  pwq 191: cpus=95 node=16 flags=0x0 nice=-20 active=0/256
  pwq 189: cpus=94 node=16 flags=0x0 nice=-20 active=0/256
  pwq 187: cpus=93 node=16 flags=0x0 nice=-20 active=0/256
  pwq 185: cpus=92 node=16 flags=0x0 nice=-20 active=0/256
  pwq 183: cpus=91 node=16 flags=0x0 nice=-20 active=0/256
  pwq 181: cpus=90 node=16 flags=0x0 nice=-20 active=0/256
  pwq 179:
 cpus=89 node=16 flags=0x0 nice=-20 active=0/256
  pwq 177: cpus=88 node=16 flags=0x0 nice=-20 active=0/256
  pwq 175: cpus=87 node=16 flags=0x0 nice=-20 active=0/256
  pwq 173: cpus=86 node=16 flags=0x0 nice=-20 active=0/256
  pwq 171: cpus=85 node=16 flags=0x0 nice=-20 active=0/256
  pwq 169: cpus=84 node=16 flags=0x0 nice=-20 active=0/256
  pwq 167: cpus=83 node=16 flags=0x0 nice=-20 active=0/256
  pwq 165: cpus=82 node=16 flags=0x0 nice=-20 active=0/256
  pwq 163: cpus=81 node=16 flags=0x0 nice=-20 active=0/256
  pwq 161: cpus=80 node=16 flags=0x0 nice=-20 active=0/256
  pwq 159: cpus=79 node=1 flags=0x0 nice=-20 active=0/256
  pwq 157: cpus=78 node=1 flags=0x0 nice=-20 active=0/256
  pwq 155: cpus=77 node=1 flags=0x0 nice=-20 active=0/256
  pwq 153: cpus=76 node=1 flags=0x0 nice=-20 active=0/256
  pwq 151: cpus=75 node=1 flags=0x0 nice=-20 active=0/256
  pwq 149: cpus=74 node=1 flags=0x0 nice=-20 active=0/256
  pwq 147: cpus=73 node=1 flags=0x0 nice=-20 active=0/256
  pwq 145: cpus=72 node=1 flags=0x0 nice=-20 active=0/256
  pwq 143: cpus=71 node=1 flags=0x0 nice=-20 active=0/256
  pwq 141: cpus=70 node=1 flags=0x0 nice=-20 active=0/256
  pwq 139: cpus=69 node=1 flags=0x0 nice=-20 active=0/256
  pwq 137: cpus=68 node=1 flags=0x0 nice=-20 active=0/256
  pwq 135: cpus=67 node=1 flags=0x0 nice=-20 active=0/256
  pwq 133: cpus=66 node=1 flags=0x0 nice=-20 active=0/256
  pwq 131: cpus=65 node=1 flags=0x0 nice=-20 active=0/256
  pwq 129: cpus=64 node=1 flags=0x0 nice=-20 active=0/256
  pwq 127: cpus=63 node=1 flags=0x0 nice=-20 active=0/256
  pwq 125: cpus=62 node=1 flags=0x0 nice=-20 active=0/256
  pwq 123: cpus=61 node=1 flags=0x0 nice=-20 active=0/256
  pwq 121:
 cpus=60 node=1 flags=0x0 nice=-20 active=0/256
  pwq 119: cpus=59 node=1 flags=0x0 nice=-20 active=0/256
  pwq 117: cpus=58 node=1 flags=0x0 nice=-20 active=0/256
  pwq 115: cpus=57 node=1 flags=0x0 nice=-20 active=0/256
  pwq 113: cpus=56 node=1 flags=0x0 nice=-20 active=0/256
  pwq 111:
 cpus=55 node=1 flags=0x0 nice=-20 active=0/256
  pwq 109: cpus=54 node=1 flags=0x0 nice=-20 active=0/256
  pwq 107: cpus=53 node=1 flags=0x0 nice=-20 active=0/256
  pwq 105: cpus=52 node=1 flags=0x0 nice=-20 active=0/256
  pwq 103: cpus=51 node=1 flags=0x0 nice=-20 active=0/256
  pwq 101: cpus=50 node=1 flags=0x0 nice=-20 active=0/256
  pwq 99: cpus=49 node=1 flags=0x0 nice=-20 active=0/256
  pwq 97: cpus=48 node=1 flags=0x0 nice=-20 active=0/256
  pwq 95: cpus=47 node=1 flags=0x0 nice=-20 active=0/256
  pwq 93: cpus=46 node=1 flags=0x0 nice=-20 active=0/256
  pwq 91: cpus=45 node=1 flags=0x0 nice=-20 active=0/256
  pwq 89: cpus=44 node=1 flags=0x0 nice=-20 active=0/256
  pwq 87:
 cpus=43 node=1 flags=0x0 nice=-20 active=0/256
  pwq 85: cpus=42 node=1 flags=0x0 nice=-20 active=0/256
  pwq 83: cpus=41 node=1 flags=0x0 nice=-20 active=0/256
  pwq 81: cpus=40 node=1 flags=0x0 nice=-20 active=0/256
  pwq 79: cpus=39 node=0 flags=0x0 nice=-20 active=0/256
  pwq 77: cpus=38 node=0 flags=0x0 nice=-20 active=0/256
  pwq 75: cpus=37 node=0 flags=0x0 nice=-20 active=0/256
  pwq 73: cpus=36 node=0 flags=0x0 nice=-20 active=0/256
  pwq 71: cpus=35 node=0 flags=0x0 nice=-20 active=0/256
  pwq 69: cpus=34 node=0 flags=0x0 nice=-20 active=0/256
  pwq 67: cpus=33 node=0 flags=0x0 nice=-20 active=0/256
  pwq 65: cpus=32 node=0 flags=0x0 nice=-20 active=0/256
  pwq 63: cpus=31 node=0 flags=0x0 nice=-20 active=0/256
  pwq 61: cpus=30 node=0 flags=0x0 nice=-20 active=0/256
  pwq 59: cpus=29 node=0 flags=0x0 nice=-20 active=0/256
  pwq 57: cpus=28 node=0 flags=0x0 nice=-20 active=0/256
  pwq 55: cpus=27 node=0 flags=0x0 nice=-20 active=0/256
  pwq 53: cpus=26 node=0 flags=0x0 nice=-20 active=0/256
  pwq 51: cpus=25 node=0 flags=0x0 nice=-20 active=0/256
  pwq 49: cpus=24 node=0 flags=0x0 nice=-20 active=0/256
  pwq 47: cpus=23 node=0 flags=0x0 nice=-20 active=0/256
  pwq 45: cpus=22 node=0 flags=0x0 nice=-20 active=0/256
  pwq 43: cpus=21 node=0 flags=0x0 nice=-20 active=0/256
  pwq 41: cpus=20 node=0 flags=0x0 nice=-20 active=0/256
  pwq 39: cpus=19 node=0 flags=0x0 nice=-20 active=0/256
  pwq 37: cpus=18 node=0 flags=0x0 nice=-20 active=0/256
  pwq 35: cpus=17 node=0 flags=0x0 nice=-20 active=0/256
  pwq 33: cpus=16 node=0 flags=0x0 nice=-20 active=0/256
  pwq 31: cpus=15 node=0 flags=0x0 nice=-20 active=0/256
  pwq 29: cpus=14 node=0 flags=0x0 nice=-20 active=0/256
  pwq 27: cpus=13 node=0 flags=0x0 nice=-20 active=0/256
  pwq 25: cpus=12 node=0 flags=0x0 nice=-20 active=0/256
  pwq 23: cpus=11 node=0 flags=0x0 nice=-20 active=0/256
  pwq 21: cpus=10 node=0 flags=0x0 nice=-20 active=0/256
  pwq 19:
 cpus=9 node=0 flags=0x0 nice=-20 active=0/256
  pwq 17: cpus=8 node=0 flags=0x0 nice=-20 active=0/256
  pwq 15: cpus=7 node=0 flags=0x0 nice=-20 active=0/256
  pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=0/256
  pwq 11: cpus=5 node=0 flags=0x0 nice=-20 active=0/256
  pwq 9: cpus=4 node=0 flags=0x0 nice=-20 active=0/256
  pwq 7: cpus=3 node=0 flags=0x0 nice=-20 active=0/256
  pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=0/256
  pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=0/256
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=0/256
workqueue events_long: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304:
 cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254:
 cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204:
 cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168:
 cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102:
 cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66:
 cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue events_unbound: flags=0x2
  pwq 324:
 cpus=120-159 node=17 flags=0x4 nice=0 active=0/640
  pwq 323: cpus=80-119 node=16 flags=0x4 nice=0 active=0/640
  pwq 322: cpus=40-79 node=1 flags=0x4 nice=0 active=0/640
  pwq 321: cpus=0-39 node=0 flags=0x4 nice=0 active=0/640
  pwq 320: cpus=0-159 flags=0x4 nice=0 active=0/640
workqueue events_freezable: flags=0x4
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq pus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172:
 cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126:
 cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38:
 cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22:
 cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue events_power_efficient: flags=0x80
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274:
 cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238:
 cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234:
 cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174:
 cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166:
 cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140:
 cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134:
 cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130:
 cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98:
 cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72:
 cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0:
 cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue events_freezable_power_: flags=0x84
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288:
 cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268:
 cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222:
 cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188:
 cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146:
 cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84:
 cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82:
 cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62:
 cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50:
 cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32:
 cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue lru-add-drain: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302:
 cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268:
 cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246:
 cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228:
 cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168:
 cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160:
 cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132:
 cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128:
 cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124:
 cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64:
 cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60:
 cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186:
 cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174:
 cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172:
 cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136:
 cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82:
 cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22:
 cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue cgroup_destroy: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/1
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/1
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/1
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/1
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/1
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/1
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/1
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/1
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/1
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/1
  pwq 298:
 cpus=149 node=17 flags=0x0 nice=0 active=0/1
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/1
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/1
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/1
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/1
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/1
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/1
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/1
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/1
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/1
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/1
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/1
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/1
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/1
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/1
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/1
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/1
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/1
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/1
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/1
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/1
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/1
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/1
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/1
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/1
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/1
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/1
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/1
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/1
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/1
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/1
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/1
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/1
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/1
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/1
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/1
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/1
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/1
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/1
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/1
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/1
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/1
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/1
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/1
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/1
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/1
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/1
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/1
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/1
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/1
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/1
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/1
  pwq 194:
 cpus=97 node=16 flags=0x0 nice=0 active=0/1
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/1
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/1
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/1
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/1
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/1
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/1
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/1
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/1
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/1
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/1
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/1
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/1
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/1
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/1
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/1
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/1
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/1
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/1
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/1
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/1
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/1
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/1
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/1
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/1
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/1
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/1
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/1
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/1
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/1
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/1
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/1
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/1
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/1
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/1
  pwq 124:
 cpus=62 node=1 flags=0x0 nice=0 active=0/1
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/1
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/1
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/1
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/1
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/1
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/1
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/1
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/1
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/1
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/1
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/1
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/1
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/1
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/1
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/1
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/1
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/1
  pwq 88:
 cpus=44 node=1 flags=0x0 nice=0 active=0/1
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/1
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/1
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/1
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/1
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/1
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/1
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/1
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/1
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/1
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/1
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/1
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/1
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/1
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/1
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/1
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/1
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/1
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/1
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/1
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/1
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/1
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/1
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/1
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/1
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/1
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/1
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/1
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/1
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/1
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/1
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/1
  pwq 24:
 cpus=12 node=0 flags=0x0 nice=0 active=0/1
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/1
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/1
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/1
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/1
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/1
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/1
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/1
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/1
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/1
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/1
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/1
workqueue cgroup_pidlist_destroy: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/1
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/1
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/1
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/1
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/1
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/1
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/1
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/1
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/1
  pwq 300:
 cpus=150 node=17 flags=0x0 nice=0 active=0/1
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/1
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/1
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/1
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/1
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/1
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/1
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/1
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/1
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/1
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/1
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/1
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/1
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/1
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/1
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/1
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/1
  pwq 266:
 cpus=133 node=17 flags=0x0 nice=0 active=0/1
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/1
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/1
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/1
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/1
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/1
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/1
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/1
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/1
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/1
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/1
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/1
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/1
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/1
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/1
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/1
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/1
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/1
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/1
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/1
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/1
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/1
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/1
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/1
  pwq 218:
 cpus=109 node=16 flags=0x0 nice=0 active=0/1
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/1
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/1
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/1
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/1
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/1
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/1
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/1
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/1
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/1
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/1
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/1
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/1
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/1
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/1
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/1
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/1
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/1
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/1
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/1
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/1
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/1
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/1
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/1
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/1
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/1
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/1
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/1
  pwq 162:
 cpus=81 node=16 flags=0x0 nice=0 active=0/1
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/1
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/1
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/1
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/1
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/1
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/1
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/1
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/1
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/1
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/1
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/1
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/1
  pwq 136:
 cpus=68 node=1 flags=0x0 nice=0 active=0/1
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/1
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/1
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/1
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/1
  pwq 126:
 cpus=63 node=1 flags=0x0 nice=0 active=0/1
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/1
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/1
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/1
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/1
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/1
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/1
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/1
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/1
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/1
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/1
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/1
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/1
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/1
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/1
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/1
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/1
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/1
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/1
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/1
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/1
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/1
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/1
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/1
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/1
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/1
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/1
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/1
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/1
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/1
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/1
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/1
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/1
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/1
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/1
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/1
  pwq 54:
 cpus=27 node=0 flags=0x0 nice=0 active=0/1
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/1
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/1
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/1
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/1
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/1
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/1
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/1
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/1
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/1
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/1
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/1
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/1
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/1
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/1
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/1
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/1
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/1
  pwq 18:
 cpus=9 node=0 flags=0x0 nice=0 active=0/1
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/1
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/1
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/1
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/1
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/1
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/1
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/1
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/1
workqueue writeback: flags=0x4e
  pwq 320: cpus=0-159 flags=0x4 nice=0 active=0/256
  pwq 324: cpus=120-159 node=17 flags=0x4 nice=0 active=0/256
  pwq 323: cpus=80-119 node=16 flags=0x4 nice=0 active=0/256
  pwq 322: cpus=40-79 node=1 flags=0x4 nice=0 active=0/256
  pwq 321: cpus=0-39 node=0 flags=0x4 nice=0 active=0/256
workqueue crypto: flags=0x28
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/1
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/1
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/1
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/1
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/1
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/1
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/1
  pwq 304:
 cpus=152 node=17 flags=0x0 nice=0 active=0/1
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/1
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/1
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/1
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/1
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/1
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/1
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/1
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/1
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/1
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/1
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/1
  pwq 280:
 cpus=140 node=17 flags=0x0 nice=0 active=0/1
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/1
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/1
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/1
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/1
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/1
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/1
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/1
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/1
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/1
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/1
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/1
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/1
  pwq 254:
 cpus=127 node=17 flags=0x0 nice=0 active=0/1
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/1
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/1
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/1
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/1
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/1
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/1
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/1
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/1
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/1
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/1
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/1
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/1
  pwq 228:
 cpus=114 node=16 flags=0x0 nice=0 active=0/1
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/1
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/1
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/1
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/1
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/1
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/1
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/1
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/1
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/1
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/1
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/1
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/1
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/1
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/1
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/1
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/1
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/1
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/1
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/1
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/1
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/1
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/1
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/1
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/1
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/1
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/1
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/1
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/1
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/1
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/1
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/1
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/1
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/1
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/1
  pwq 158:
 cpus=79 node=1 flags=0x0 nice=0 active=0/1
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/1
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/1
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/1
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/1
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/1
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/1
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/1
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/1
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/1
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/1
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/1
  pwq 134:
 cpus=67 node=1 flags=0x0 nice=0 active=0/1
  pwq 132:
 cpus=66 node=1 flags=0x0 nice=0 active=0/1
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/1
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/1
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/1
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/1
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/1
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/1
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/1
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/1
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/1
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/1
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/1
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/1
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/1
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/1
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/1
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/1
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/1
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/1
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/1
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/1
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/1
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/1
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/1
  pwq 8 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216:
 cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182:
 cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178:
 cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114:
 cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64:
 cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue kblockd: flags=0x18
  pwq 319: cpus=159 node=17 flags=0x0 nice=-20 active=0/256
  pwq 317: cpus=158 node=17 flags=0x0 nice=-20 active=0/256
  pwq 315: cpus=157 node=17 flags=0x0 nice=-20 active=0/256
  pwq 313: cpus=156 node=17 flags=0x0 nice=-20 active=0/256
  pwq 311: cpus=155 node=17 flags=0x0 nice=-20 active=0/256
  pwq 309: cpus=154 node=17 flags=0x0 nice=-20 active=0/256
  pwq 307: cpus=153 node=17 flags=0x0 nice=-20 active=0/256
  pwq 305: cpus=152 node=17 flags=0x0 nice=-20 active=0/256
  pwq 303: cpus=151 node=17 flags=0x0 nice=-20 active=0/256
  pwq 301: cpus=150 node=17 flags=0x0 nice=-20 active=0/256
  pwq 299: cpus=149 node=17 flags=0x0 nice=-20 active=0/256
  pwq 297:
 cpus=148 node=17 flags=0x0 nice=-20 active=0/256
  pwq 295: cpus=147 node=17 flags=0x0 nice=-20 active=0/256
  pwq 293: cpus=146 node=17 flags=0x0 nice=-20 active=0/256
  pwq 291:
 cpus=145 node=17 flags=0x0 nice=-20 active=0/256
  pwq 289: cpus=144 node=17 flags=0x0 nice=-20 active=0/256
  pwq 287: cpus=143 node=17 flags=0x0 nice=-20 active=0/256
  pwq 285: cpus=142 node=17 flags=0x0 nice=-20 active=0/256
  pwq 283: cpus=141 node=17 flags=0x0 nice=-20 active=0/256
  pwq 281: cpus=140 node=17 flags=0x0 nice=-20 active=0/256
  pwq 279: cpus=139 node=17 flags=0x0 nice=-20 active=0/256
  pwq 277:
 cpus=138 node=17 flags=0x0 nice=-20 active=0/256
  pwq 275: cpus=137 node=17 flags=0x0 nice=-20 active=0/256
  pwq 273: cpus=136 node=17 flags=0x0 nice=-20 active=0/256
  pwq 271: cpus=135 node=17 flags=0x0 nice=-20 active=0/256
  pwq 269: cpus=134 node=17 flags=0x0 nice=-20 active=0/256
  pwq 267: cpus=133 node=17 flags=0x0 nice=-20 active=0/256
  pwq 265: cpus=132 node=17 flags=0x0 nice=-20 active=0/256
  pwq 263: cpus=131 node=17 flags=0x0 nice=-20 active=0/256
  pwq 261: cpus=130 node=17 flags=0x0 nice=-20 active=0/256
  pwq 259: cpus=129 node=17 flags=0x0 nice=-20 active=0/256
  pwq 257: cpus=128 node=17 flags=0x0 nice=-20 active=0/256
  pwq 255: cpus=127 node=17 flags=0x0 nice=-20 active=0/256
  pwq 253: cpus=126 node=17 flags=0x0 nice=-20 active=0/256
  pwq 251: cpus=125 node=17 flags=0x0 nice=-20 active=0/256
  pwq 249: cpus=124 node=17 flags=0x0 nice=-20 active=0/256
  pwq 247: cpus=123 node=17 flags=0x0 nice=-20 active=0/256
  pwq 245: cpus=122 node=17 flags=0x0 nice=-20 active=0/256
  pwq 243: cpus=121 node=17 flags=0x0 nice=-20 active=0/256
  pwq 241: cpus=120 node=17 flags=0x0 nice=-20 active=0/256
  pwq 239: cpus=119 node=16 flags=0x0 nice=-20 active=0/256
  pwq 237: cpus=118 node=16 flags=0x0 nice=-20 active=0/256
  pwq 235: cpus=117 node=16 flags=0x0 nice=-20 active=0/256
  pwq 233:
 cpus=116 node=16 flags=0x0 nice=-20 active=0/256
  pwq 231: cpus=115 node=16 flags=0x0 nice=-20 active=0/256
  pwq 229: cpus=114 node=16 flags=0x0 nice=-20 active=0/256
  pwq 227: cpus=113 node=16 flags=0x0 nice=-20 active=0/256
  pwq 225: cpus=112 node=16 flags=0x0 nice=-20 active=0/256
  pwq 223: cpus=111 node=16 flags=0x0 nice=-20 active=0/256
  pwq 221: cpus=110 node=16 flags=0x0 nice=-20 active=0/256
  pwq 219: cpus=109 node=16 flags=0x0 nice=-20 active=0/256
  pwq 217:
 cpus=108 node=16 flags=0x0 nice=-20 active=0/256
  pwq 215: cpus=107 node=16 flags=0x0 nice=-20 active=0/256
  pwq 213:
 cpus=106 node=16 flags=0x0 nice=-20 active=0/256
  pwq 211: cpus=105 node=16 flags=0x0 nice=-20 active=0/256
  pwq 209: cpus=104 node=16 flags=0x0 nice=-20 active=0/256
  pwq 207: cpus=103 node=16 flags=0x0 nice=-20 active=0/256
  pwq 205: cpus=102 node=16 flags=0x0 nice=-20 active=0/256
  pwq 203: cpus=101 node=16 flags=0x0 nice=-20 active=0/256
  pwq 201: cpus=100 node=16 flags=0x0 nice=-20 active=0/256
  pwq 199:
 cpus=99 node=16 flags=0x0 nice=-20 active=0/256
  pwq 197: cpus=98 node=16 flags=0x0 nice=-20 active=0/256
  pwq 195: cpus=97 node=16 flags=0x0 nice=-20 active=0/256
  pwq 193: cpus=96 node=16 flags=0x0 nice=-20 active=0/256
  pwq 191: cpus=95 node=16 flags=0x0 nice=-20 active=0/256
  pwq 189: cpus=94 node=16 flags=0x0 nice=-20 active=0/256
  pwq 187: cpus=93 node=16 flags=0x0 nice=-20 active=0/256
  pwq 185: cpus=92 node=16 flags=0x0 nice=-20 active=0/256
  pwq 183: cpus=91 node=16 flags=0x0 nice=-20 active=0/256
  pwq 181: cpus=90 node=16 flags=0x0 nice=-20 active=0/256
  pwq 179: cpus=89 node=16 flags=0x0 nice=-20 active=0/256
  pwq 177: cpus=88 node=16 flags=0x0 nice=-20 active=0/256
  pwq 175: cpus=87 node=16 flags=0x0 nice=-20 active=0/256
  pwq 173: cpus=86 node=16 flags=0x0 nice=-20 active=0/256
  pwq 171: cpus=85 node=16 flags=0x0 nice=-20 active=0/256
  pwq 169: cpus=84 node=16 flags=0x0 nice=-20 active=0/256
  pwq 167: cpus=83 node=16 flags=0x0 nice=-20 active=0/256
  pwq 165: cpus=82 node=16 flags=0x0 nice=-20 active=0/256
  pwq 163: cpus=81 node=16 flags=0x0 nice=-20 active=0/256
  pwq 161: cpus=80 node=16 flags=0x0 nice=-20 active=0/256
  pwq 159: cpus=79 node=1 flags=0x0 nice=-20 active=0/256
  pwq 157: cpus=78 node=1 flags=0x0 nice=-20 active=0/256
  pwq 155: cpus=77 node=1 flags=0x0 nice=-20 active=0/256
  pwq 153: cpus=76 node=1 flags=0x0 nice=-20 active=0/256
  pwq 151: cpus=75 node=1 flags=0x0 nice=-20 active=0/256
  pwq 149: cpus=74 node=1 flags=0x0 nice=-20 active=0/256
  pwq 147: cpus=73 node=1 flags=0x0 nice=-20 active=0/256
  pwq 145: cpus=72 node=1 flags=0x0 nice=-20 active=0/256
  pwq 143: cpus=71 node=1 flags=0x0 nice=-20 active=0/256
  pwq 141: cpus=70 node=1 flags=0x0 nice=-20 active=0/256
  pwq 139: cpus=69 node=1 flags=0x0 nice=-20 active=0/256
  pwq 137: cpus=68 node=1 flags=0x0 nice=-20 active=0/256
  pwq 135: cpus=67 node=1 flags=0x0 nice=-20 active=0/256
  pwq 133:
 cpus=66 node=1 flags=0x0 nice=-20 active=0/256
  pwq 131: cpus=65 node=1 flags=0x0 nice=-20 active=0/256
  pwq 129: cpus=64 node=1 flags=0x0 nice=-20 active=0/256
  pwq 127: cpus=63 node=1 flags=0x0 nice=-20 active=0/256
  pwq 125: cpus=62 node=1 flags=0x0 nice=-20 active=0/256
  pwq 123: cpus=61 node=1 flags=0x0 nice=-20 active=0/256
  pwq 121: cpus=60 node=1 flags=0x0 nice=-20 active=0/256
  pwq 119: cpus=59 node=1 flags=0x0 nice=-20 active=0/256
  pwq 117: cpus=58 node=1 flags=0x0 nice=-20 active=0/256
  pwq 115: cpus=57 node=1 flags=0x0 nice=-20 active=0/256
  pwq 113: cpus=56 node=1 flags=0x0 nice=-20 active=0/256
  pwq 111: cpus=55 node=1 flags=0x0 nice=-20 active=0/256
  pwq 109: cpus=54 node=1 flags=0x0 nice=-20 active=0/256
  pwq 107: cpus=53 node=1 flags=0x0 nice=-20 active=0/256
  pwq 105: cpus=52 node=1 flags=0x0 nice=-20 active=0/256
  pwq 103: cpus=51 node=1 flags=0x0 nice=-20 active=0/256
  pwq 101:
 cpus=50 node=1 flags=0x0 nice=-20 active=0/256
  pwq 99: cpus=49 node=1 flags=0x0 nice=-20 active=0/256
  pwq 97: cpus=48 node=1 flags=0x0 nice=-20 active=0/256
  pwq 95: cpus=47 node=1 flags=0x0 nice=-20 active=0/256
  pwq 93:
 cpus=46 node=1 flags=0x0 nice=-20 active=0/256
  pwq 91: cpus=45 node=1 flags=0x0 nice=-20 active=0/256
  pwq 89: cpus=44 node=1 flags=0x0 nice=-20 active=0/256
  pwq 87: cpus=43 node=1 flags=0x0 nice=-20 active=0/256
  pwq 85: cpus=42 node=1 flags=0x0 nice=-20 active=0/256
  pwq 83: cpus=41 node=1 flags=0x0 nice=-20 active=0/256
  pwq 81: cpus=40 node=1 flags=0x0 nice=-20 active=0/256
  pwq 79: cpus=39 node=0 flags=0x0 nice=-20 active=0/256
  pwq 77: cpus=38 node=0 flags=0x0 nice=-20 active=0/256
  pwq 75: cpus=37 node=0 flags=0x0 nice=-20 active=0/256
  pwq 73: cpus=36 node=0 flags=0x0 nice=-20 active=0/256
  pwq 71: cpus=35 node=0 flags=0x0 nice=-20 active=0/256
  pwq 69: cpus=34 node=0 flags=0x0 nice=-20 active=0/256
  pwq 67:
 cpus=33 node=0 flags=0x0 nice=-20 active=0/256
  pwq 65: cpus=32 node=0 flags=0x0 nice=-20 active=0/256
  pwq 63: cpus=31 node=0 flags=0x0 nice=-20 active=0/256
  pwq 61: cpus=30 node=0 flags=0x0 nice=-20 active=0/256
  pwq 59: cpus=29 node=0 flags=0x0 nice=-20 active=0/256
  pwq 57: cpus=28 node=0 flags=0x0 nice=-20 active=0/256
  pwq 55: cpus=27 node=0 flags=0x0 nice=-20 active=0/256
  pwq 53: cpus=26 node=0 flags=0x0 nice=-20 active=0/256
  pwq 51: cpus=25 node=0 flags=0x0 nice=-20 active=0/256
  pwq 49: cpus=24 node=0 flags=0x0 nice=-20 active=0/256
  pwq 47: cpus=23 node=0 flags=0x0 nice=-20 active=0/256
  pwq 45: cpus=22 node=0 flags=0x0 nice=-20 active=0/256
  pwq 43: cpus=21 node=0 flags=0x0 nice=-20 active=0/256
  pwq 41: cpus=20 node=0 flags=0x0 nice=-20 active=0/256
  pwq 39: cpus=19 node=0 flags=0x0 nice=-20 active=0/256
  pwq 37: cpus=18 node=0 flags=0x0 nice=-20 active=0/256
  pwq 35: cpus=17 node=0 flags=0x0 nice=-20 active=0/256
  pwq 33: cpus=16 node=0 flags=0x0 nice=-20 active=0/256
  pwq 31: cpus=15 node=0 flags=0x0 nice=-20 active=0/256
  pwq 29: cpus=14 node=0 flags=0x0 nice=-20 active=0/256
  pwq 27: cpus=13 node=0 flags=0x0 nice=-20 active=0/256
  pwq 25: cpus=12 node=0 flags=0x0 nice=-20 active=0/256
  pwq 23: cpus=11 node=0 flags=0x0 nice=-20 active=0/256
  pwq 21: cpus=10 node=0 flags=0x0 nice=-20 active=0/256
  pwq 19: cpus=9 node=0 flags=0x0 nice=-20 active=0/256
  pwq 17: cpus=8 node=0 flags=0x0 nice=-20 active=0/256
  pwq 15: cpus=7 node=0 flags=0x0 nice=-20 active=0/256
  pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=0/256
  pwq 11: cpus=5 node=0 flags=0x0 nice=-20 active=0/256
  pwq 9: cpus=4 node=0 flags=0x0 nice=-20 active=0/256
  pwq 7: cpus=3 node=0 flags=0x0 nice=-20 active=0/256
  pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=0/256
  pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=0/256
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=0/256
workqueue usb_hub_wq: flags=0x4
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284:
 cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232:
 cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184:
 cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150:
 cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142:
 cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82:
 cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46:
 cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20:
 cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14:
 cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue md: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316:
 cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164:
 cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 14=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue md_misc: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316:
 cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262:
 cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174:
 cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108:
 cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64:
 cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2:
 cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue watchdogd: flags=0x18
  pwq 319: cpus=159 node=17 flags=0x0 nice=-20 active=0/256
  pwq 317: cpus=158 node=17 flags=0x0 nice=-20 active=0/256
  pwq 315: cpus=157 node=17 flags=0x0 nice=-20 active=0/256
  pwq 313: cpus=156 node=17 flags=0x0 nice=-20 active=0/256
  pwq 311:
 cpus=155 node=17 flags=0x0 nice=-20 active=0/256
  pwq 309: cpus=154 node=17 flags=0x0 nice=-20 active=0/256
  pwq 307:
 cpus=153 node=17 flags=0x0 nice=-20 active=0/256
  pwq 305: cpus=152 node=17 flags=0x0 nice=-20 active=0/256
  pwq 303: cpus=151 node=17 flags=0x0 nice=-20 active=0/256
  pwq 301: cpus=150 node=17 flags=0x0 nice=-20 active=0/256
  pwq 299: cpus=149 node=17 flags=0x0 nice=-20 active=0/256
  pwq 297: cpus=148 node=17 flags=0x0 nice=-20 active=0/256
  pwq 295: cpus=147 node=17 flags=0x0 nice=-20 active=0/256
  pwq 293: cpus=146 node=17 flags=0x0 nice=-20 active=0/256
  pwq 291:
 cpus=145 node=17 flags=0x0 nice=-20 active=0/256
  pwq 289: cpus=144 node=17 flags=0x0 nice=-20 active=0/256
  pwq 287: cpus=143 node=17 flags=0x0 nice=-20 active=0/256
  pwq 285:
 cpus=142 node=17 flags=0x0 nice=-20 active=0/256
  pwq 283: cpus=141 node=17 flags=0x0 nice=-20 active=0/256
  pwq 281: cpus=140 node=17 flags=0x0 nice=-20 active=0/256
  pwq 279: cpus=139 node=17 flags=0x0 nice=-20 active=0/256
  pwq 277: cpus=138 node=17 flags=0x0 nice=-20 active=0/256
  pwq 275: cpus=137 node=17 flags=0x0 nice=-20 active=0/256
  pwq 273: cpus=136 node=17 flags=0x0 nice=-20 active=0/256
  pwq 271: cpus=135 node=17 flags=0x0 nice=-20 active=0/256
  pwq 269: cpus=134 node=17 flags=0x0 nice=-20 active=0/256
  pwq 267: cpus=133 node=17 flags=0x0 nice=-20 active=0/256
  pwq 265: cpus=132 node=17 flags=0x0 nice=-20 active=0/256
  pwq 263: cpus=131 node=17 flags=0x0 nice=-20 active=0/256
  pwq 261: cpus=130 node=17 flags=0x0 nice=-20 active=0/256
  pwq 259: cpus=129 node=17 flags=0x0 nice=-20 active=0/256
  pwq 257: cpus=128 node=17 flags=0x0 nice=-20 active=0/256
  pwq 255: cpus=127 node=17 flags=0x0 nice=-20 active=0/256
  pwq 253: cpus=126 node=17 flags=0x0 nice=-20 active=0/256
  pwq 251: cpus=125 node=17 flags=0x0 nice=-20 active=0/256
  pwq 249: cpus=124 node=17 flags=0x0 nice=-20 active=0/256
  pwq 247: cpus=123 node=17 flags=0x0 nice=-20 active=0/256
  pwq 245: cpus=122 node=17 flags=0x0 nice=-20 active=0/256
  pwq 243: cpus=121 node=17 flags=0x0 nice=-20 active=0/256
  pwq 241: cpus=120 node=17 flags=0x0 nice=-20 active=0/256
  pwq 239: cpus=119 node=16 flags=0x0 nice=-20 active=0/256
  pwq 237: cpus=118 node=16 flags=0x0 nice=-20 active=0/256
  pwq 235: cpus=117 node=16 flags=0x0 nice=-20 active=0/256
  pwq 233: cpus=116 node=16 flags=0x0 nice=-20 active=0/256
  pwq 231: cpus=115 node=16 flags=0x0 nice=-20 active=0/256
  pwq 229: cpus=114 node=16 flags=0x0 nice=-20 active=0/256
  pwq 227:
 cpus=113 node=16 flags=0x0 nice=-20 active=0/256
  pwq 225: cpus=112 node=16 flags=0x0 nice=-20 active=0/256
  pwq 223: cpus=111 node=16 flags=0x0 nice=-20 active=0/256
  pwq 221: cpus=110 node=16 flags=0x0 nice=-20 active=0/256
  pwq 219: cpus=109 node=16 flags=0x0 nice=-20 active=0/256
  pwq 217:
 cpus=108 node=16 flags=0x0 nice=-20 active=0/256
  pwq 215: cpus=107 node=16 flags=0x0 nice=-20 active=0/256
  pwq 213: cpus=106 node=16 flags=0x0 nice=-20 active=0/256
  pwq 211: cpus=105 node=16 flags=0x0 nice=-20 active=0/256
  pwq 209: cpus=104 node=16 flags=0x0 nice=-20 active=0/256
  pwq 207: cpus=103 node=16 flags=0x0 nice=-20 active=0/256
  pwq 205: cpus=102 node=16 flags=0x0 nice=-20 active=0/256
  pwq 203: cpus=101 node=16 flags=0x0 nice=-20 active=0/256
  pwq 201: cpus=100 node=16 flags=0x0 nice=-20 active=0/256
  pwq 199: cpus=99 node=16 flags=0x0 nice=-20 active=0/256
  pwq 197: cpus=98 node=16 flags=0x0 nice=-20 active=0/256
  pwq 195:
 cpus=97 node=16 flags=0x0 nice=-20 active=0/256
  pwq 193: cpus=96 node=16 flags=0x0 nice=-20 active=0/256
  pwq 191: cpus=95 node=16 flags=0x0 nice=-20 active=0/256
  pwq 189: cpus=94 node=16 flags=0x0 nice=-20 active=0/256
  pwq 187: cpus=93 node=16 flags=0x0 nice=-20 active=0/256
  pwq 185: cpus=92 node=16 flags=0x0 nice=-20 active=0/256
  pwq 183: cpus=91 node=16 flags=0x0 nice=-20 active=0/256
  pwq 181: cpus=90 node=16 flags=0x0 nice=-20 active=0/256
  pwq 179: cpus=89 node=16 flags=0x0 nice=-20 active=0/256
  pwq 177: cpus=88 node=16 flags=0x0 nice=-20 active=0/256
  pwq 175: cpus=87 node=16 flags=0x0 nice=-20 active=0/256
  pwq 173: cpus=86 node=16 flags=0x0 nice=-20 active=0/256
  pwq 171: cpus=85 node=16 flags=0x0 nice=-20 active=0/256
  pwq 169: cpus=84 node=16 flags=0x0 nice=-20 active=0/256
  pwq 167: cpus=83 node=16 flags=0x0 nice=-20 active=0/256
  pwq 165: cpus=82 node=16 flags=0x0 nice=-20 active=0/256
  pwq 163: cpus=81 node=16 flags=0x0 nice=-20 active=0/256
  pwq 161:
 cpus=80 node=16 flags=0x0 nice=-20 active=0/256
  pwq 159: cpus=79 node=1 flags=0x0 nice=-20 active=0/256
  pwq 157: cpus=78 node=1 flags=0x0 nice=-20 active=0/256
  pwq 155: cpus=77 node=1 flags=0x0 nice=-20 active=0/256
  pwq 153: cpus=76 node=1 flags=0x0 nice=-20 active=0/256
  pwq 151: cpus=75 node=1 flags=0x0 nice=-20 active=0/256
  pwq 149: cpus=74 node=1 flags=0x0 nice=-20 active=0/256
  pwq 147: cpus=73 node=1 flags=0x0 nice=-20 active=0/256
  pwq 145: cpus=72 node=1 flags=0x0 nice=-20 active=0/256
  pwq 143: cpus=71 node=1 flags=0x0 nice=-20 active=0/256
  pwq 141: cpus=70 node=1 flags=0x0 nice=-20 active=0/256
  pwq 139: cpus=69 node=1 flags=0x0 nice=-20 active=0/256
  pwq 137: cpus=68 node=1 flags=0x0 nice=-20 active=0/256
  pwq 135: cpus=67 node=1 flags=0x0 nice=-20 active=0/256
  pwq 133: cpus=66 node=1 flags=0x0 nice=-20 active=0/256
  pwq 131: cpus=65 node=1 flags=0x0 nice=-20 active=0/256
  pwq 129: cpus=64 node=1 flags=0x0 nice=-20 active=0/256
  pwq 127: cpus=63 node=1 flags=0x0 nice=-20 active=0/256
  pwq 125: cpus=62 node=1 flags=0x0 nice=-20 active=0/256
  pwq 123: cpus=61 node=1 flags=0x0 nice=-20 active=0/256
  pwq 121: cpus=60 node=1 flags=0x0 nice=-20 active=0/256
  pwq 119: cpus=59 node=1 flags=0x0 nice=-20 active=0/256
  pwq 117: cpus=58 node=1 flags=0x0 nice=-20 active=0/256
  pwq 115: cpus=57 node=1 flags=0x0 nice=-20 active=0/256
  pwq 113: cpus=56 node=1 flags=0x0 nice=-20 active=0/256
  pwq 111: cpus=55 node=1 flags=0x0 nice=-20 active=0/256
  pwq 109: cpus=54 node=1 flags=0x0 nice=-20 active=0/256
  pwq 107: cpus=53 node=1 flags=0x0 nice=-20 active=0/256
  pwq 105: cpus=52 node=1 flags=0x0 nice=-20 active=0/256
  pwq 103: cpus=51 node=1 flags=0x0 nice=-20 active=0/256
  pwq 101: cpus=50 node=1 flags=0x0 nice=-20 active=0/256
  pwq 99: cpus=49 node=1 flags=0x0 nice=-20 active=0/256
  pwq 97: cpus=48 node=1 flags=0x0 nice=-20 active=0/256
  pwq 95:
 cpus=47 node=1 flags=0x0 nice=-20 active=0/256
  pwq 93: cpus=46 node=1 flags=0x0 nice=-20 active=0/256
  pwq 91: cpus=45 node=1 flags=0x0 nice=-20 active=0/256
  pwq 89: cpus=44 node=1 flags=0x0 nice=-20 active=0/256
  pwq 87: cpus=43 node=1 flags=0x0 nice=-20 active=0/256
  pwq 85: cpus=42 node=1 flags=0x0 nice=-20 active=0/256
  pwq 83: cpus=41 node=1 flags=0x0 nice=-20 active=0/256
  pwq 81: cpus=40 node=1 flags=0x0 nice=-20 active=0/256
  pwq 79: cpus=39 node=0 flags=0x0 nice=-20 active=0/256
  pwq 77: cpus=38 node=0 flags=0x0 nice=-20 active=0/256
  pwq 75: cpus=37 node=0 flags=0x0 nice=-20 active=0/256
  pwq 73: cpus=36 node=0 flags=0x0 nice=-20 active=0/256
  pwq 71: cpus=35 node=0 flags=0x0 nice=-20 active=0/256
  pwq 69: cpus=34 node=0 flags=0x0 nice=-20 active=0/256
  pwq 67: cpus=33 node=0 flags=0x0 nice=-20 active=0/256
  pwq 65: cpus=32 node=0 flags=0x0 nice=-20 active=0/256
  pwq 63: cpus=31 node=0 flags=0x0 nice=-20 active=0/256
  pwq 61:
 cpus=30 node=0 flags=0x0 nice=-20 active=0/256
  pwq 59: cpus=29 node=0 flags=0x0 nice=-20 active=0/256
  pwq 57:
 cpus=28 node=0 flags=0x0 nice=-20 active=0/256
  pwq 55: cpus=27 node=0 flags=0x0 nice=-20 active=0/256
  pwq 53: cpus=26 node=0 flags=0x0 nice=-20 active=0/256
  pwq 51: cpus=25 node=0 flags=0x0 nice=-20 active=0/256
  pwq 49: cpus=24 node=0 flags=0x0 nice=-20 active=0/256
  pwq 47: cpus=23 node=0 flags=0x0 nice=-20 active=0/256
  pwq 45: cpus=22 node=0 flags=0x0 nice=-20 active=0/256
  pwq 43: cpus=21 node=0 flags=0x0 nice=-20 active=0/256
  pwq 41: cpus=20 node=0 flags=0x0 nice=-20 active=0/256
  pwq 39: cpus=19 node=0 flags=0x0 nice=-20 active=0/256
  pwq 37: cpus=18 node=0 flags=0x0 nice=-20 active=0/256
  pwq 35: cpus=17 node=0 flags=0x0 nice=-20 active=0/256
  pwq 33: cpus=16 node=0 flags=0x0 nice=-20 active=0/256
  pwq 31: cpus=15 node=0 flags=0x0 nice=-20 active=0/256
  pwq 29: cpus=14 node=0 flags=0x0 nice=-20 active=0/256
  pwq 27: cpus=13 node=0 flags=0x0 nice=-20 active=0/256
  pwq 25: cpus=12 node=0 flags=0x0 nice=-20 active=0/256
  pwq 23: cpus=11 node=0 flags=0x0 nice=-20 active=0/256
  pwq 21: cpus=10 node=0 flags=0x0 nice=-20 active=0/256
  pwq 19: cpus=9 node=0 flags=0x0 nice=-20 active=0/256
  pwq 17: cpus=8 node=0 flags=0x0 nice=-20 active=0/256
  pwq 15: cpus=7 node=0 flags=0x0 nice=-20 active=0/256
  pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=0/256
  pwq 11: cpus=5 node=0 flags=0x0 nice=-20 active=0/256
  pwq 9: cpus=4 node=0 flags=0x0 nice=-20 active=0/256
  pwq 7: cpus=3 node=0 flags=0x0 nice=-20 active=0/256
  pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=0/256
  pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=0/256
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=0/256
workqueue rpciod: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312:
 cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286:
 cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280:
 cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246:
 cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178:
 cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144:
 cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74:
 cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70:
 cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4:
 cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue xprtiod: flags=0x18
  pwq 319: cpus=159 node=17 flags=0x0 nice=-20 active=0/256
  pwq 317: cpus=158 node=17 flags=0x0 nice=-20 active=0/256
  pwq 315:
 cpus=157 node=17 flags=0x0 nice=-20 active=0/256
  pwq 313: cpus=156 node=17 flags=0x0 nice=-20 active=0/256
  pwq 311: cpus=155 node=17 flags=0x0 nice=-20 active=0/256
  pwq 309: cpus=154 node=17 flags=0x0 nice=-20 active=0/256
  pwq 307: cpus=153 node=17 flags=0x0 nice=-20 active=0/256
  pwq 305: cpus=152 node=17 flags=0x0 nice=-20 active=0/256
  pwq 303: cpus=151 node=17 flags=0x0 nice=-20 active=0/256
  pwq 301: cpus=150 node=17 flags=0x0 nice=-20 active=0/256
  pwq 299: cpus=149 node=17 flags=0x0 nice=-20 active=0/256
  pwq 297: cpus=148 node=17 flags=0x0 nice=-20 active=0/256
  pwq 295: cpus=147 node=17 flags=0x0 nice=-20 active=0/256
  pwq 293: cpus=146 node=17 flags=0x0 nice=-20 active=0/256
  pwq 291: cpus=145 node=17 flags=0x0 nice=-20 active=0/256
  pwq 289: cpus=144 node=17 flags=0x0 nice=-20 active=0/256
  pwq 287: cpus=143 node=17 flags=0x0 nice=-20 active=0/256
  pwq 285: cpus=142 node=17 flags=0x0 nice=-20 active=0/256
  pwq 283: cpus=141 node=17 flags=0x0 nice=-20 active=0/256
  pwq 281: cpus=140 node=17 flags=0x0 nice=-20 active=0/256
  pwq 279: cpus=139 node=17 flags=0x0 nice=-20 active=0/256
  pwq 277: cpus=138 node=17 flags=0x0 nice=-20 active=0/256
  pwq 275: cpus=137 node=17 flags=0x0 nice=-20 active=0/256
  pwq 273: cpus=136 node=17 flags=0x0 nice=-20 active=0/256
  pwq 271: cpus=135 node=17 flags=0x0 nice=-20 active=0/256
  pwq 269: cpus=134 node=17 flags=0x0 nice=-20 active=0/256
  pwq 267: cpus=133 node=17 flags=0x0 nice=-20 active=0/256
  pwq 265: cpus=132 node=17 flags=0x0 nice=-20 active=0/256
  pwq 263: cpus=131 node=17 flags=0x0 nice=-20 active=0/256
  pwq 261:
 cpus=130 node=17 flags=0x0 nice=-20 active=0/256
  pwq 259: cpus=129 node=17 flags=0x0 nice=-20 active=0/256
  pwq 257: cpus=128 node=17 flags=0x0 nice=-20 active=0/256
  pwq 255: cpus=127 node=17 flags=0x0 nice=-20 active=0/256
  pwq 253: cpus=126 node=17 flags=0x0 nice=-20 active=0/256
  pwq 251: cpus=125 node=17 flags=0x0 nice=-20 active=0/256
  pwq 249: cpus=124 node=17 flags=0x0 nice=-20 active=0/256
  pwq 247: cpus=123 node=17 flags=0x0 nice=-20 active=0/256
  pwq 245: cpus=122 node=17 flags=0x0 nice=-20 active=0/256
  pwq 243: cpus=121 node=17 flags=0x0 nice=-20 active=0/256
  pwq 241: cpus=120 node=17 flags=0x0 nice=-20 active=0/256
  pwq 239: cpus=119 node=16 flags=0x0 nice=-20 active=0/256
  pwq 237: cpus=118 node=16 flags=0x0 nice=-20 active=0/256
  pwq 235: cpus=117 node=16 flags=0x0 nice=-20 active=0/256
  pwq 233: cpus=116 node=16 flags=0x0 nice=-20 active=0/256
  pwq 231: cpus=115 node=16 flags=0x0 nice=-20 active=0/256
  pwq 229: cpus=114 node=16 flags=0x0 nice=-20 active=0/256
  pwq 227: cpus=113 node=16 flags=0x0 nice=-20 active=0/256
  pwq 225: cpus=112 node=16 flags=0x0 nice=-20 active=0/256
  pwq 223: cpus=111 node=16 flags=0x0 nice=-20 active=0/256
  pwq 221: cpus=110 node=16 flags=0x0 nice=-20 active=0/256
  pwq 219: cpus=109 node=16 flags=0x0 nice=-20 active=0/256
  pwq 217: cpus=108 node=16 flags=0x0 nice=-20 active=0/256
  pwq 215: cpus=107 node=16 flags=0x0 nice=-20 active=0/256
  pwq 213: cpus=106 node=16 flags=0x0 nice=-20 active=0/256
  pwq 211: cpus=active=0/256
  pwq 79:
 cpus=39 node=0 flags=0x0 nice=-20 active=0/256
  pwq 77: cpus=38 node=0 flags=0x0 nice=-20 active=0/256
  pwq 75: cpus=37 node=0 flags=0x0 nice=-20 active=0/256
  pwq 73: cpus=36 node=0 flags=0x0 nice=-20 active=0/256
  pwq 71: cpus=35 node=0 flags=0x0 nice=-20 active=0/256
  pwq 69: cpus=34 node=0 flags=0x0 nice=-20 active=0/256
  pwq 67: cpus=33 node=0 flags=0x0 nice=-20 active=0/256
  pwq 65: cpus=32 node=0 flags=0x0 nice=-20 active=0/256
  pwq 63:
 cpus=31 node=0 flags=0x0 nice=-20 active=0/256
  pwq 61: cpus=30 node=0 flags=0x0 nice=-20 active=0/256
  pwq 59: cpus=29 node=0 flags=0x0 nice=-20 active=0/256
  pwq 57: cpus=28 node=0 flags=0x0 nice=-20 active=0/256
  pwq 55: cpus=27 node=0 flags=0x0 nice=-20 active=0/256
  pwq 53: cpus=26 node=0 flags=0x0 nice=-20 active=0/256
  pwq 51: cpus=25 node=0 flags=0x0 nice=-20 active=0/256
  pwq 49: cpus=24 node=0 flags=0x0 nice=-20 active=0/256
  pwq 47: cpus=23 node=0 flags=0x0 nice=-20 active=0/256
  pwq 45: cpus=22 node=0 flags=0x0 nice=-20 active=0/256
  pwq 43: cpus=21 node=0 flags=0x0 nice=-20 active=0/256
  pwq 41: cpus=20 node=0 flags=0x0 nice=-20 active=0/256
  pwq 39: cpus=19 node=0 flags=0x0 nice=-20 active=0/256
  pwq 37: cpus=18 node=0 flags=0x0 nice=-20 active=0/256
  pwq 35: cpus=17 node=0 flags=0x0 nice=-20 active=0/256
  pwq 33: cpus=16 node=0 flags=0x0 nice=-20 active=0/256
  pwq 31: cpus=15 node=0 flags=0x0 nice=-20 active=0/256
  pwq 29: cpus=14 node=0 flags=0x0 nice=-20 active=0/256
  pwq 27: cpus=13 node=0 flags=0x0 nice=-20 active=0/256
  pwq 25: cpus=12 node=0 flags=0x0 nice=-20 active=0/256
  pwq 23: cpus=11 node=0 flags=0x0 nice=-20 active=0/256
  pwq 21: cpus=10 node=0 flags=0x0 nice=-20 active=0/256
  pwq 19: cpus=9 node=0 flags=0x0 nice=-20 active=0/256
  pwq 17: cpus=8 node=0 flags=0x0 nice=-20 active=0/256
  pwq 15: cpus=7 node=0 flags=0x0 nice=-20 active=0/256
  pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=0/256
  pwq 11: cpus=5 node=0 flags=0x0 nice=-20 active=0/256
  pwq 9: cpus=4 node=0 flags=0x0 nice=-20 active=0/256
  pwq 7: cpus=3 node=0 flags=0x0 nice=-20 active=0/256
  pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=0/256
  pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=0/256
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=0/256
workqueue vmstat: flags=0xc
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314:
 cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280:
 cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214:
 cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154:
 cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112:
 cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110:
 cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90:
 cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=1/256
    pending: vmstat_update
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44:
 cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue nfsiod: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262:
 cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258:
 cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220:
 cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160:
 cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126:
 cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56:
 cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54:
 cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28:
 cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22:
 cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286:
 cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284:
 cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240:
 cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208:
 cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140:
 cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104:
 cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86:
 cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56:
 cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54:
 cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0:
 cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: ve=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118:
 cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104:
 cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48:
 cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44:
 cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18:
 cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12:
 cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266:
 cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252:
 cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206:
 cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166:
 cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164:
 cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162:
 cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158:
 cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96:
 cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80:
 cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62:
 cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312:
 cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278:
 cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246:
 cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178:
 cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156:
 cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144:
 cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140:
 cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102:
 cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100:
 cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32:
 cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4:
 cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314:
 cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258:
 cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224:
 cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222:
 cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220:
 cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192:
 cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158:
 cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156:
 cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150:
 cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146:
 cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122:
 cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18:
 cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: f/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170:
 cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158:
 cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140:
 cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120:
 cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66:
 cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282:
 cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216:
 cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182:
 cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178:
 cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114:
 cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304:
 cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272:
 cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228:
 cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196:
 cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162:
 cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92:
 cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274:
 cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262:
 cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260:
 cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248:
 cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242:
 cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174:
 cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140:
 cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118:
 cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70:
 cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=00/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186:
 cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122:
 cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84:
 cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12:
 cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10:
 cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308:
 cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300:
 cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232:
 cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220:
 cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186:
 cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130:
 cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62:
 cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26:
 cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24:
 cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312:
 cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278:
 cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216:
 cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186:
 cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144:
 cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142:
 cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110:
 cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4:
 cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274:
 cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224:
 cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196:
 cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190:
 cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122:
 cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120:
 cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 n  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270:
 cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266:
 cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236:
 cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234:
 cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220:
 cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170:
 cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136:
 cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66:
 cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10:
 cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282:
 cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216:
 cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182:
 cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114:
 cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112:
 cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78:
 cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44:
 cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24:
 cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262:
 cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232:
 cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228:
 cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194:
 cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180:
 cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162:
 cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92:
 cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70:
 cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56:
 cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22:
 cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14:
 cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274:
 cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240:
 cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238:
 cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226:
 cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180:
 cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 ac active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10:
 cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286:
 cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240:
 cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186:
 cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164:
 cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120:
 cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84:
 cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12:
 cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8:
 cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2:
 cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300:
 cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232:
 cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196:
 cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184:
 cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130:
 cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96:
 cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86:
 cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26:
 cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20:
 cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312:
 cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278:
 cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212:
 cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202:
 cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178:
 cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144:
 cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110:
 cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74:
 cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290:
 cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258:
 cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node5 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42:
 cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304:
 cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236:
 cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204:
 cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136:
 cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124:
 cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100:
 cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92:
 cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66:
 cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30:
 cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316:
 cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284:
 cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216:
 cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208:
 cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182:
 cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174:
 cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114:
 cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78:
 cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52:
 cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30:
 cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296:
 cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294:
 cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282:
 cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262:
 cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228:
 cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196:
 cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126:
 cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92:
 cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90:
 cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88:
 cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86:
 cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26:
 cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue scsi_tmf_0: flags=0xa
  pwq 320: cpus=0-159 flags=0x4 nice=0 active=0/1
  pwq 324: cpus=120-159 node=17 flags=0x4 nice=0 active=0/1
  pwq 323: cpus=80-119 node=16 flags=0x4 nice=0 active=0/1
  pwq 322: cpus=40-79 node=1 flags=0x4 nice=0 active=0/1
  pwq 321: cpus=0-39 node=0 flags=0x4 nice=0 active=0/1
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298:
 cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292:
 cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 acags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116:
 cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46:
 cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42:
 cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2:
 cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200:
 cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164:
 cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152:
 cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94:
 cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78:
 cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60:
 cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310:
 cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108:
 cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72:
 cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42:
 cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18:
 cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290:
 cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256:
 cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222:
 cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220:
 cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190:
 cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120:
 cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114:
 cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86:
 cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74:
 cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16:
 cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/56
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134:
 cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64:
 cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28:
 cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14:
 cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280:
 cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248:
 cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180:
 cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132:
 cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76:
 cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42:
 cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36:
 cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6:
 cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302:
 cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260:
 cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226:
 cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160:
 cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124:
 cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56:
 cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20:
 cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0:
 cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306:
 cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296:
 cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238:
 cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172:
 cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138:
 cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68:
 cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0234:
 cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184:
 cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116:
 cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80:
 cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74:
 cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60:
 cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10:
 cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296:
 cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172:
 cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128:
 cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58:
 cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24:
 cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310:
 cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284:
 cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242:
 cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162:
 cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80:
 cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72:
 cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0:
 cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254:
 cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188:
 cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154:
 cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130:
 cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 1ode=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234:
 cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200:
 cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132:
 cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72:
 cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28:
 cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318:
 cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280:
 cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246:
 cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180:
 cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154:
 cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152:
 cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150:
 cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146:
 cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76:
 cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40:
 cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292:
 cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258:
 cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208:
 cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196:
 cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158:
 cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136:
 cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124:
 cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54:
 cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18:
 cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282:
 cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260: cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238:
 cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204:
 cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/2ags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue kpsmoused: flags=0x20002
  pwq 320:
 cpus=0-159 flags=0x4 nice=0 active=0/1
workqueue kdmremove: flags=0x2
  pwq 320: cpus=0-159 flags=0x4 nice=0 active=0/1
  pwq 324: cpus=120-159 node=17 flags=0x4 nice=0 active=0/1
  pwq 323: cpus=80-119 node=16 flags=0x4 nice=0 active=0/1
  pwq 322: cpus=40-79 node=1 flags=0x4 nice=0 active=0/1
  pwq 321: cpus=0-39 node=0 flags=0x4 nice=0 active=0/1
workqueue sock_diag_events: flags=0x0
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314: cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276: cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264:
 cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260:
 cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230:
 cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210: cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198: cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176: cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164:
 cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160:
 cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156: cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152:
 cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138: cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106:
 cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72: cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66: cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60:
 cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32: cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28: cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10: cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue bioset: flags=0x8
  pwq 318: cpus=159 node=17 flags=0x0 nice=0 active=0/256
  pwq 316: cpus=158 node=17 flags=0x0 nice=0 active=0/256
  pwq 314:
 cpus=157 node=17 flags=0x0 nice=0 active=0/256
  pwq 312: cpus=156 node=17 flags=0x0 nice=0 active=0/256
  pwq 310: cpus=155 node=17 flags=0x0 nice=0 active=0/256
  pwq 308: cpus=154 node=17 flags=0x0 nice=0 active=0/256
  pwq 306: cpus=153 node=17 flags=0x0 nice=0 active=0/256
  pwq 304: cpus=152 node=17 flags=0x0 nice=0 active=0/256
  pwq 302: cpus=151 node=17 flags=0x0 nice=0 active=0/256
  pwq 300: cpus=150 node=17 flags=0x0 nice=0 active=0/256
  pwq 298: cpus=149 node=17 flags=0x0 nice=0 active=0/256
  pwq 296: cpus=148 node=17 flags=0x0 nice=0 active=0/256
  pwq 294: cpus=147 node=17 flags=0x0 nice=0 active=0/256
  pwq 292: cpus=146 node=17 flags=0x0 nice=0 active=0/256
  pwq 290: cpus=145 node=17 flags=0x0 nice=0 active=0/256
  pwq 288: cpus=144 node=17 flags=0x0 nice=0 active=0/256
  pwq 286: cpus=143 node=17 flags=0x0 nice=0 active=0/256
  pwq 284: cpus=142 node=17 flags=0x0 nice=0 active=0/256
  pwq 282: cpus=141 node=17 flags=0x0 nice=0 active=0/256
  pwq 280: cpus=140 node=17 flags=0x0 nice=0 active=0/256
  pwq 278: cpus=139 node=17 flags=0x0 nice=0 active=0/256
  pwq 276:
 cpus=138 node=17 flags=0x0 nice=0 active=0/256
  pwq 274: cpus=137 node=17 flags=0x0 nice=0 active=0/256
  pwq 272: cpus=136 node=17 flags=0x0 nice=0 active=0/256
  pwq 270: cpus=135 node=17 flags=0x0 nice=0 active=0/256
  pwq 268: cpus=134 node=17 flags=0x0 nice=0 active=0/256
  pwq 266: cpus=133 node=17 flags=0x0 nice=0 active=0/256
  pwq 264: cpus=132 node=17 flags=0x0 nice=0 active=0/256
  pwq 262: cpus=131 node=17 flags=0x0 nice=0 active=0/256
  pwq 260:
 cpus=130 node=17 flags=0x0 nice=0 active=0/256
  pwq 258: cpus=129 node=17 flags=0x0 nice=0 active=0/256
  pwq 256: cpus=128 node=17 flags=0x0 nice=0 active=0/256
  pwq 254: cpus=127 node=17 flags=0x0 nice=0 active=0/256
  pwq 252: cpus=126 node=17 flags=0x0 nice=0 active=0/256
  pwq 250: cpus=125 node=17 flags=0x0 nice=0 active=0/256
  pwq 248: cpus=124 node=17 flags=0x0 nice=0 active=0/256
  pwq 246: cpus=123 node=17 flags=0x0 nice=0 active=0/256
  pwq 244: cpus=122 node=17 flags=0x0 nice=0 active=0/256
  pwq 242: cpus=121 node=17 flags=0x0 nice=0 active=0/256
  pwq 240: cpus=120 node=17 flags=0x0 nice=0 active=0/256
  pwq 238: cpus=119 node=16 flags=0x0 nice=0 active=0/256
  pwq 236: cpus=118 node=16 flags=0x0 nice=0 active=0/256
  pwq 234: cpus=117 node=16 flags=0x0 nice=0 active=0/256
  pwq 232: cpus=116 node=16 flags=0x0 nice=0 active=0/256
  pwq 230: cpus=115 node=16 flags=0x0 nice=0 active=0/256
  pwq 228: cpus=114 node=16 flags=0x0 nice=0 active=0/256
  pwq 226: cpus=113 node=16 flags=0x0 nice=0 active=0/256
  pwq 224: cpus=112 node=16 flags=0x0 nice=0 active=0/256
  pwq 222: cpus=111 node=16 flags=0x0 nice=0 active=0/256
  pwq 220: cpus=110 node=16 flags=0x0 nice=0 active=0/256
  pwq 218: cpus=109 node=16 flags=0x0 nice=0 active=0/256
  pwq 216: cpus=108 node=16 flags=0x0 nice=0 active=0/256
  pwq 214: cpus=107 node=16 flags=0x0 nice=0 active=0/256
  pwq 212: cpus=106 node=16 flags=0x0 nice=0 active=0/256
  pwq 210:
 cpus=105 node=16 flags=0x0 nice=0 active=0/256
  pwq 208: cpus=104 node=16 flags=0x0 nice=0 active=0/256
  pwq 206: cpus=103 node=16 flags=0x0 nice=0 active=0/256
  pwq 204: cpus=102 node=16 flags=0x0 nice=0 active=0/256
  pwq 202: cpus=101 node=16 flags=0x0 nice=0 active=0/256
  pwq 200: cpus=100 node=16 flags=0x0 nice=0 active=0/256
  pwq 198:
 cpus=99 node=16 flags=0x0 nice=0 active=0/256
  pwq 196: cpus=98 node=16 flags=0x0 nice=0 active=0/256
  pwq 194: cpus=97 node=16 flags=0x0 nice=0 active=0/256
  pwq 192: cpus=96 node=16 flags=0x0 nice=0 active=0/256
  pwq 190: cpus=95 node=16 flags=0x0 nice=0 active=0/256
  pwq 188: cpus=94 node=16 flags=0x0 nice=0 active=0/256
  pwq 186: cpus=93 node=16 flags=0x0 nice=0 active=0/256
  pwq 184: cpus=92 node=16 flags=0x0 nice=0 active=0/256
  pwq 182: cpus=91 node=16 flags=0x0 nice=0 active=0/256
  pwq 180: cpus=90 node=16 flags=0x0 nice=0 active=0/256
  pwq 178: cpus=89 node=16 flags=0x0 nice=0 active=0/256
  pwq 176:
 cpus=88 node=16 flags=0x0 nice=0 active=0/256
  pwq 174: cpus=87 node=16 flags=0x0 nice=0 active=0/256
  pwq 172: cpus=86 node=16 flags=0x0 nice=0 active=0/256
  pwq 170: cpus=85 node=16 flags=0x0 nice=0 active=0/256
  pwq 168: cpus=84 node=16 flags=0x0 nice=0 active=0/256
  pwq 166: cpus=83 node=16 flags=0x0 nice=0 active=0/256
  pwq 164: cpus=82 node=16 flags=0x0 nice=0 active=0/256
  pwq 162: cpus=81 node=16 flags=0x0 nice=0 active=0/256
  pwq 160: cpus=80 node=16 flags=0x0 nice=0 active=0/256
  pwq 158: cpus=79 node=1 flags=0x0 nice=0 active=0/256
  pwq 156:
 cpus=78 node=1 flags=0x0 nice=0 active=0/256
  pwq 154: cpus=77 node=1 flags=0x0 nice=0 active=0/256
  pwq 152: cpus=76 node=1 flags=0x0 nice=0 active=0/256
  pwq 150: cpus=75 node=1 flags=0x0 nice=0 active=0/256
  pwq 148: cpus=74 node=1 flags=0x0 nice=0 active=0/256
  pwq 146: cpus=73 node=1 flags=0x0 nice=0 active=0/256
  pwq 144: cpus=72 node=1 flags=0x0 nice=0 active=0/256
  pwq 142: cpus=71 node=1 flags=0x0 nice=0 active=0/256
  pwq 140: cpus=70 node=1 flags=0x0 nice=0 active=0/256
  pwq 138:
 cpus=69 node=1 flags=0x0 nice=0 active=0/256
  pwq 136: cpus=68 node=1 flags=0x0 nice=0 active=0/256
  pwq 134: cpus=67 node=1 flags=0x0 nice=0 active=0/256
  pwq 132: cpus=66 node=1 flags=0x0 nice=0 active=0/256
  pwq 130: cpus=65 node=1 flags=0x0 nice=0 active=0/256
  pwq 128: cpus=64 node=1 flags=0x0 nice=0 active=0/256
  pwq 126: cpus=63 node=1 flags=0x0 nice=0 active=0/256
  pwq 124: cpus=62 node=1 flags=0x0 nice=0 active=0/256
  pwq 122: cpus=61 node=1 flags=0x0 nice=0 active=0/256
  pwq 120: cpus=60 node=1 flags=0x0 nice=0 active=0/256
  pwq 118: cpus=59 node=1 flags=0x0 nice=0 active=0/256
  pwq 116: cpus=58 node=1 flags=0x0 nice=0 active=0/256
  pwq 114: cpus=57 node=1 flags=0x0 nice=0 active=0/256
  pwq 112: cpus=56 node=1 flags=0x0 nice=0 active=0/256
  pwq 110: cpus=55 node=1 flags=0x0 nice=0 active=0/256
  pwq 108: cpus=54 node=1 flags=0x0 nice=0 active=0/256
  pwq 106: cpus=53 node=1 flags=0x0 nice=0 active=0/256
  pwq 104: cpus=52 node=1 flags=0x0 nice=0 active=0/256
  pwq 102: cpus=51 node=1 flags=0x0 nice=0 active=0/256
  pwq 100: cpus=50 node=1 flags=0x0 nice=0 active=0/256
  pwq 98: cpus=49 node=1 flags=0x0 nice=0 active=0/256
  pwq 96: cpus=48 node=1 flags=0x0 nice=0 active=0/256
  pwq 94: cpus=47 node=1 flags=0x0 nice=0 active=0/256
  pwq 92: cpus=46 node=1 flags=0x0 nice=0 active=0/256
  pwq 90: cpus=45 node=1 flags=0x0 nice=0 active=0/256
  pwq 88: cpus=44 node=1 flags=0x0 nice=0 active=0/256
  pwq 86: cpus=43 node=1 flags=0x0 nice=0 active=0/256
  pwq 84: cpus=42 node=1 flags=0x0 nice=0 active=0/256
  pwq 82: cpus=41 node=1 flags=0x0 nice=0 active=0/256
  pwq 80: cpus=40 node=1 flags=0x0 nice=0 active=0/256
  pwq 78: cpus=39 node=0 flags=0x0 nice=0 active=0/256
  pwq 76: cpus=38 node=0 flags=0x0 nice=0 active=0/256
  pwq 74: cpus=37 node=0 flags=0x0 nice=0 active=0/256
  pwq 72:
 cpus=36 node=0 flags=0x0 nice=0 active=0/256
  pwq 70: cpus=35 node=0 flags=0x0 nice=0 active=0/256
  pwq 68: cpus=34 node=0 flags=0x0 nice=0 active=0/256
  pwq 66:
 cpus=33 node=0 flags=0x0 nice=0 active=0/256
  pwq 64: cpus=32 node=0 flags=0x0 nice=0 active=0/256
  pwq 62: cpus=31 node=0 flags=0x0 nice=0 active=0/256
  pwq 60: cpus=30 node=0 flags=0x0 nice=0 active=0/256
  pwq 58: cpus=29 node=0 flags=0x0 nice=0 active=0/256
  pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=0/256
  pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=0/256
  pwq 52: cpus=26 node=0 flags=0x0 nice=0 active=0/256
  pwq 50: cpus=25 node=0 flags=0x0 nice=0 active=0/256
  pwq 48: cpus=24 node=0 flags=0x0 nice=0 active=0/256
  pwq 46: cpus=23 node=0 flags=0x0 nice=0 active=0/256
  pwq 44: cpus=22 node=0 flags=0x0 nice=0 active=0/256
  pwq 42: cpus=21 node=0 flags=0x0 nice=0 active=0/256
  pwq 40: cpus=20 node=0 flags=0x0 nice=0 active=0/256
  pwq 38: cpus=19 node=0 flags=0x0 nice=0 active=0/256
  pwq 36: cpus=18 node=0 flags=0x0 nice=0 active=0/256
  pwq 34: cpus=17 node=0 flags=0x0 nice=0 active=0/256
  pwq 32:
 cpus=16 node=0 flags=0x0 nice=0 active=0/256
  pwq 30: cpus=15 node=0 flags=0x0 nice=0 active=0/256
  pwq 28:
 cpus=14 node=0 flags=0x0 nice=0 active=0/256
  pwq 26: cpus=13 node=0 flags=0x0 nice=0 active=0/256
  pwq 24: cpus=12 node=0 flags=0x0 nice=0 active=0/256
  pwq 22: cpus=11 node=0 flags=0x0 nice=0 active=0/256
  pwq 20: cpus=10 node=0 flags=0x0 nice=0 active=0/256
  pwq 18: cpus=9 node=0 flags=0x0 nice=0 active=0/256
  pwq 16: cpus=8 node=0 flags=0x0 nice=0 active=0/256
  pwq 14: cpus=7 node=0 flags=0x0 nice=0 active=0/256
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=0/256
  pwq 10:
 cpus=5 node=0 flags=0x0 nice=0 active=0/256
  pwq 8: cpus=4 node=0 flags=0x0 nice=0 active=0/256
  pwq 6:
 cpus=3 node=0 flags=0x0 nice=0 active=0/256
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/256
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=0/256
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0/256
workqueue ext4-rsv-conversion: flags=0xa
  pwq 320: cpus=0-159 flags=0x4 nice=0 active=0/1
  pwq 324: cpus=120-159 node=17 flags=0x4 nice=0 active=0/1
  pwq 323: cpus=80-119 node=16 flags=0x4 nice=0 active=0/1
  pwq 322: cpus=40-79 node=1 flags=0x4 nice=0 active=0/1
  pwq 321: cpus=0-39 node=0 flags=0x4 nice=0 active=0/1
pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 1446 2510 3
pool 1: cpus=0 node=0 flags=0x0 nice=-20 hung=84s workers=2 idle: 2776 4
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 3036 2512 18
pool 3: cpus=1 node=0 flags=0x0 nice=-20 hung=156s workers=2 idle: 3027 19
pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 8200 2515 24
pool 5: cpus=2 node=0 flags=0x0 nice=-20 hung=210s workers=2 idle: 7004 25
pool 6: cpus=3 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2513 6949 30
pool 7:
 cpus=3 node=0 flags=0x0 nice=-20 hung=210s workers=2 idle: 5343 31
pool 8: cpus=4 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 7463 2522 36
pool 9: cpus=4 node=0 flags=0x0 nice=-20 hung=105s workers=2 idle: 7645 37
pool 10: cpus=5 node=0 flags=0x0 nice=0 hung=27s workers=3 idle: 7615 2516 42
pool 11: cpus=5 node=0 flags=0x0 nice=-20 hung=89s workers=2 idle: 8072 43
pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=17s workers=2 idle: 2518 48
pool 13: cpus=6 node=0 flags=0x0 nice=-20 hung=78s workers=2 idle: 7470 49
pool 14: cpus=7 node=0 flags=0x0 nice=0 hung=20s workers=3 idle: 7778 2864 54
pool 15: cpus=7 node=0 flags=0x0 nice=-20 hung=79s workers=2 idle: 8257 55
pool 16: cpus=8 node=0 flags=0x0 nice=0 hung=3s workers=3 idle: 2511 6916 60
pool 17: cpus=8 node=0 flags=0x0 nice=-20 hung=124s workers=2 idle: 5064 61
pool 18: cpus=9 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 7016 2514 66
pool 19: cpus=9 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 6906 67
pool 20:
 cpus=10 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2524 5399 72
pool 21: cpus=10 node=0 flags=0x0 nice=-20 hung=122s workers=2 idle: 4779 73
pool 22: cpus=11 node=0 flags=0x0 nice=0 hung=0s workers=2 idle: 1564 78
pool 23: cpus=11 node=0 flags=0x0 nice=-20 hung=168s workers=2 idle: 2825 79
pool 24: cpus=12 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2509 7242 84
pool 25: cpus=12 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 7241 85
pool 26: cpus=13 node=0 flags=0x0 nice=0 hung=0s workers=2 idle: 1566 90
pool 27: cpus=13 node=0 flags=0x0 nice=-20 hung=209s workers=2 idle: 5427 91
pool 28: cpus=14 node=0 flags=0x0 nice=0 hung=3s workers=2 idle: 2531 96
pool 29: cpus=14 node=0 flags=0x0 nice=-20 hung=211s workers=2 idle: 2877 97
pool 30: cpus=15 node=0 flags=0x0 nice=0 hung=27s workers=3 idle: 2520 3035 102
pool 31: cpus=15 node=0 flags=0x0 nice=-20 hung=162s workers=2 idle: 4756 103
pool 32: cpus=16 node=0 flags=0x0 nice=0 hung=0s workers=4 idle: 2517 2879 3025 108
pool 33: cpus=16 node=0 flags=0x0 nice=-20 hung=10s workers=2 idle: 2857 109
pool 34: cpus=17 node=0 flags=0x0 nice=0 hung=17s workers=3 idle: 5578 114 2519
pool 35: cpus=17 node=0 flags=0x0 nice=-20 hung=166s workers=2 idle: 6994 115
pool 36: cpus=18 node=0 flags=0x0 nice=0 hung=3s workers=3 idle: 3040 2521 120
pool 37: cpus=18 node=0 flags=0x0 nice=-20 hung=3s workers=2 idle: 2872 121
pool 38: cpus=19 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2523 4759 126
pool 39: cpus=19 node=0 flags=0x0 nice=-20 hung=5s workers=2 idle: 3029 127
pool 40: cpus=20 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 6114 2526 132
pool 41: cpus=20 node=0 flags=0x0 nice=-20 hung=0s workers=2 idle: 6782 133
pool 42: cpus=21 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2525 6648 138
pool 43: cpus=21 node=0 flags=0x0 nice=-20 hung=0s workers=2 idle: 3107 139
pool 44:
 cpus=22 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 6914 2528 144
pool 45: cpus=22 node=0 flags=0x0 nice=-20 hung=59s workers=2 idle: 5043 145
pool 46: cpus=23 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 6905 150 2529
pool 47: cpus=23 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 6545 151
pool 48: cpus=24 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2527 6629 156
pool 49: cpus=24 node=0 flags=0x0 nice=-20 hung=54s workers=2 idle: 5083 157
pool 50: cpus=25 node=0 flags=0x0 nice=0 hung=3s workers=3 idle: 2530 6952 162
pool 51: cpus=25 node=0 flags=0x0 nice=-20 hung=124s workers=2 idle: 5158 163
pool 52: cpus=26 node=0 flags=0x0 nice=0 hung=11s workers=5 idle: 2532 4778 4777 3038 168
pool 53: cpus=26 node=0 flags=0x0 nice=-20 hung=64s workers=2 idle: 5172 169
pool 54: cpus=27 node=0 flags=0x0 nice=0 hung=2s workers=4 idle: 2533 8006 8008 174
pool 55: cpus=27 node=0 flags=0x0 nice=-20 hung=124s workers=2 idle: 4890 175
pool 56: cpus=28 node=0 flags=0x0 nice=0 hung=2s workers=3 idle: 5393 180 2535
pool 57:
 cpus=28 node=0 flags=0x0 nice=-20 hung=162s workers=2 idle: 3028 181
pool 58: cpus=29 node=0 flags=0x0 nice=0 hung=10s workers=3 idle: 6814 186 2536
pool 59: cpus=29 node=0 flags=0x0 nice=-20 hung=64s workers=2 idle: 5961 187
pool 60: cpus=30 node=0 flags=0x0 nice=0 hung=2s workers=3 idle: 2538 4755 192
pool 61: cpus=30 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 3042 193
pool 62: cpus=31 node=0 flags=0x0 nice=0 hung=13s workers=4 idle: 2539 7753 7072 198
pool 63: cpus=31 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 7360 199
pool 64: cpus=32 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2534 7889 204
pool 65: cpus=32 node=0 flags=0x0 nice=-20 hung=24s workers=2 idle: 6318 205
pool 66: cpus=33 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2537 7614 210
pool 67: cpus=33 node=0 flags=0x0 nice=-20 hung=61s workers=2 idle: 2858 211
pool 68: cpus=34 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 2540 6200 216
pool 69: cpus=34 node=0 flags=0x0 nice=-20 hung=24s workers=2 idle: 2859 217
pool 70: cpus=35 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 6909 2541 222
pool 71: cpus=35 node=0 flags=0x0 nice=-20 hung=124s workers=2 idle: 2861 223
pool 72:
 cpus=36 node=0 flags=0x0 nice=0 hung=5s workers=2 idle: 2542 228
pool 73: cpus=36 node=0 flags=0x0 nice=-20 hung=124s workers=2 idle: 7254 229
pool 74: cpus=37 node=0 flags=0x0 nice=0 hung=49s workers=3 idle: 3031 2543 234
pool 75: cpus=37 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 2860 235
pool 76: cpus=38 node=0 flags=0x0 nice=0 hung=13s workers=3 idle: 2544 6977 240
pool 77: cpus=38 node=0 flags=0x0 nice=-20 hung=160s workers=2 idle: 2875 241
pool 78: cpus=39 node=0 flags=0x0 nice=0 hung=13s workers=3 idle: 2545 7890 246
pool 79: cpus=39 node=0 flags=0x0 nice=-20 hung=156s workers=2 idle: 6112 247
pool 80: cpus=40 node=1 flags=0x0 nice=0 hung=21s workers=3 idle: 7289 252 2656
pool 81: cpus=40 node=1 flags=0x0 nice=-20 hung=162s workers=2 idle: 7303 253
pool 82: cpus=41 node=1 flags=0x0 nice=0 hung=9s workers=2 idle: 2805 259
pool 83: cpus=41 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 260
pool 84: cpus=42 node=1 flags=0x0 nice=0 hung=41s workers=2 idle: 2807 265
pool 85: cpus=42 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 266
pool 86: cpus=43 node=1 flags=0x0 nice=0 hung=0s workers=2 idle: 2808 271
pool 87: cpus=43 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 272
pool 88: cpus=44 node=1 flags=0x0 nice=0 hung=31s workers=2 idle: 7038 277
pool 89: cpus=44 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 278
pool 90: cpus=45 node=1 flags=0x0 nice=0 hung=21s workers=2 idle: 7050 283
pool 91: cpus=45 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 284
pool 92: cpus=46 node=1 flags=0x0 nice=0 hung=5s workers=2 idle: 7058 289
pool 93: cpus=46 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 290
pool 94: cpus=47 node=1 flags=0x0 nice=0 hung=23s workers=2 idle: 7563 295
pool 95:
 cpus=47 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 296
pool 96: cpus=48 node=1 flags=0x0 nice=0 hung=0s workers=2 idle: 2799 301
pool 97: cpus=48 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 302
pool 98: cpus=49 node=1 flags=0x0 nice=0 hung=2s workers=2 idle: 2772 307
pool 99: cpus=49 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 308
pool 100: cpus=50 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2752 313
pool 101: cpus=50 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 314
pool 102: cpus=51 node=1 flags=0x0 nice=0 hung=37s workers=2 idle: 2815 319
pool 103: cpus=51 node=1 flags=0x0 nice=-20 hung=162s workers=2 idle: 7305 320
pool 104: cpus=52 node=1 flags=0x0 nice=0 hung=29s workers=2 idle: 2814 325
pool 105: cpus=52 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 326
pool 106: cpus=53 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2820 331
pool 107: cpus=53 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 332
pool 108:
 cpus=54 node=1 flags=0x0 nice=0 hung=9s workers=2 idle: 2817 337
pool 109: cpus=54 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 338
pool 110: cpus=55 node=1 flags=0x0 nice=0 hung=5s workers=2 idle: 2806 343
pool 111: cpus=55 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 344
pool 112: cpus=56 node=1 flags=0x0 nice=0 hung=5s workers=2 idle: 2773 349
pool 113: cpus=56 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 350
pool 114: cpus=57 node=1 flags=0x0 nice=0 hung=9s workers=3 idle: 2775 7464 355
pool 115: cpus=57 node=1 flags=0x0 nice=-20 hung=160s workers=2 idle: 7307 356
pool 116: cpus=58 node=1 flags=0x0 nice=0 hung=17s workers=2 idle: 2771 361
pool 117: cpus=58 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 362
pool 118: cpus=59 node=1 flags=0x0 nice=0 hung=21s workers=2 idle: 2751 367
pool 119: cpus=59 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 368
pool 120: cpus=60 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2819 373
pool 121: cpus=60 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 374
pool 122: cpus=61 node=1 flags=0x0 nice=0 hung=65s workers=2 idle: 2818 379
pool 123: cpus=61 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 380
pool 124: cpus=62 node=1 flags=0x0 nice=0 hung=64s workers=2 idle: 2816 385
pool 125: cpus=62 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 386
pool 126: cpus=63 node=1 flags=0x0 nice=0 hung=17s workers=2 idle: 2821 391
pool 127: cpus=63 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 392
pool 128: cpus=64 node=1 flags=0x0 nice=0 hung=29s workers=2 idle: 2754 397
pool 129: cpus=64 node=1 flags=0x0 nice=-20 hung=162s workers=2 idle: 7309 398
pool 130: cpus=65 node=1 flags=0x0 nice=0 hung=17s workers=2 idle: 2810 403
pool 131: cpus=65 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 404
pool 132: cpus=66 node=1 flags=0x0 nice=0 hung=13s workers=2 idle: 2812 409
pool 133:
 cpus=66 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 410
pool 134: cpus=67 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2813 415
pool 135: cpus=67 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 416
pool 136: cpus=68 node=1 flags=0x0 nice=0 hung=21s workers=2 idle: 2774 421
pool 137: cpus=68 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 422
pool 138: cpus=69 node=1 flags=0x0 nice=0 hung=57s workers=2 idle: 7365 427
pool 139: cpus=69 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 428
pool 140: cpus=70 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 6710 433
pool 141: cpus=70 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 434
pool 142: cpus=71 node=1 flags=0x0 nice=0 hung=53s workers=2 idle: 6921 439
pool 143: cpus=71 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 440
pool 144: cpus=72 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2800 445
pool 145: cpus=72 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 446
pool 146: cpus=73 node=1 flags=0x0 nice=0 hung=9s workers=2 idle: 2750 451
pool 147:
 cpus=73 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 452
pool 148: cpus=74 node=1 flags=0x0 nice=0 hung=1s workers=2 idle: 2809 457
pool 149: cpus=74 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 458
pool 150: cpus=75 node=1 flags=0x0 nice=0 hung=65s workers=2 idle: 6922 463
pool 151: cpus=75 node=1 flags=0x0 nice=-20 hung=241s workers=1 idle: 464
pool 152: cpus=76 node=1 flags=0x0 nice=0 hung=45s workers=3 idle: 6903 7459 469
pool 153: cpus=76 node=1 flags=0x0 nice=-20 hung=160s workers=2 idle: 7457 470
pool 154: cpus=77 : 8012 626
pool 205: cpus=102 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 627
pool 206: cpus=103 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 2827 632
pool 207: cpus=103 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 633
pool 208: cpus=104 node=16 flags=0x0 nice=0 hung=5s workers=2 idle: 2758 638
pool 209: cpus=104 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 639
pool 210: cpus=105 node=16 flags=0x0 nice=0 hung=13s workers=2 idle: 7041 644
pool 211:
 cpus=105 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 645
pool 212: cpus=106 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 7061 650
pool 213: cpus=106 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 651
pool 214: cpus=107 node=16 flags=0x0 nice=0 hung=129s workers=2 idle: 2828 656
pool 215: cpus=107 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 657
pool 216: cpus=108 node=16 flags=0x0 nice=0 hung=73s workers=2 idle: 7957 662
pool 217: cpus=108 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 663
pool 218: cpus=109 node=16 flags=0x0 nice=0 hung=93s workers=2 idle: 7468 668
pool 219: cpus=109 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 669
pool 220: cpus=110 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 7054 674
pool 221: cpus=110 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 675
pool 222: cpus=111 node=16 flags=0x0 nice=0 hung=13s workers=2 idle: 7042 680
pool 223: cpus=111 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 681
pool 224: cpus=112 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 2759 686
pool 225: cpus=112 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 687
pool 226: cpus=113 node=16 flags=0x0 nice=0 hung=9s workers=2 idle: 7055 692
pool 227: cpus=113 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 693
pool 228: cpus=114 node=16 flags=0x0 nice=0 hung=129s workers=2 idle: 2829 698
pool 229:
 cpus=114 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 699
pool 230: cpus=115 node=16 flags=0x0 nice=0 hung=117s workers=2 idle: 7618 704
pool 231: cpus=115 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 705
pool 232: cpus=116 node=16 flags=0x0 nice=0 hung=125s workers=2 idle: 7958 710
pool 233: cpus=116 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 711
pool 234: cpus=117 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 7069 716
pool 235: cpus=117 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 717
pool 236: cpus=118 node=16 flags=0x0 nice=0 hung=5s workers=2 idle: 7043 722
pool 237: cpus=118 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 723
pool 238: cpus=119 node=16 flags=0x0 nice=0 hung=1s workers=2 idle: 2830 728
pool 239: cpus=119 node=16 flags=0x0 nice=-20 hung=241s workers=1 idle: 729
pool 240: cpus=120 node=17 flags=0x0 nice=0 hung=17s workers=2 idle: 2757 734
pool 241: cpus=120 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 735
pool 242: cpus=121 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7044 741
pool 243: cpus=121 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 742
pool 244: cpus=122 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2831 747
pool 245: cpus=122 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 748
pool 246: cpus=123 node=17 flags=0x0 nice=0 hung=133s workers=2 idle: 2832 753
pool 247: cpus=123 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 754
pool 248: cpus=124 node=17 flags=0x0 nice=0 hung=137s workers=2 idle: 7893 759
pool 249:
 cpus=124 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 760
pool 250: cpus=125 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7045 765
pool 251: cpus=125 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 766
pool 252: cpus=126 node=17 flags=0x0 nice=0 hung=13s workers=2 idle: 7063 771
pool 253: cpus=126 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 772
pool 254: cpus=127 node=17 flags=0x0 nice=0 hung=49s workers=2 idle: 2833 777
pool 255: cpus=127 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 778
pool 256: cpus=128 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 2760 783
pool 257: cpus=128 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 784
pool 258: cpus=129 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2834 789
pool 259: cpus=129 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 790
pool 260: cpus=130 node=17 flags=0x0 nice=0 hung=45s workers=2 idle: 7046 795
pool 261: cpus=130 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 796
pool 262: cpus=131 node=17 flags=0x0 nice=0 hung=125s workers=2 idle: 7959 801
pool 263: cpus=131 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 802
pool 264: cpus=132 node=17 flags=0x0 nice=0 hung=141s workers=2 idle: 7783 807
pool 265: cpus=132 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 808
pool 266: cpus=133 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2835 813
pool 267: cpus=133 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 814
pool 268: cpus=134 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7047 819
pool 269: cpus=134 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 820
pool 270: cpus=135 node=17 flags=0x0 nice=0 hung=13s workers=2 idle: 2836 825
pool 271: cpus=135 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 826
pool 272: cpus=136 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2761 831
pool 273:
 cpus=136 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 832
pool 274: cpus=137 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 2837 837
pool 275: cpus=137 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 838
pool 276: cpus=138 node=17 flags=0x0 nice=0 hung=65s workers=2 idle: 2838 843
pool 277: cpus=138 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 844
pool 278: cpus=139 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7894 849
pool 279: cpus=139 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 850
pool 280: cpus=140 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7048 855
pool 281: cpus=140 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 856
pool 282: cpus=141 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7066 861
pool 283: cpus=141 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 862
pool 284: cpus=142 node=17 flags=0x0 nice=0 hung=13s workers=2 idle: 2839 867
pool 285: cpus=142 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 868
pool 286: cpus=143 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7062 873
pool 287:
 cpus=143 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 874
pool 288: cpus=144 node=17 flags=0x0 nice=0 hung=13s workers=2 idle: 2762 879
pool 289: cpus=144 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 880
pool 290: cpus=145 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2840 885
pool 291: cpus=145 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 886
pool 292: cpus=146 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7070 891
pool 293: cpus=146 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 892
pool 294: cpus=147 node=17 flags=0x0 nice=0 hung=61s workers=2 idle: 7784 897
pool 295: cpus=147 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 898
pool 296: cpus=148 node=17 flags=0x0 nice=0 hung=53s workers=2 idle: 7651 903
pool 297: cpus=148 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 904
pool 298: cpus=149 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 2841 909
pool 299: cpus=149 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 910
pool 300: cpus=150 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 7056 915
pool 301: cpus=150 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 916
pool 302: cpus=151 node=17 flags=0x0 nice=0 hung=57s workers=2 idle: 7652 921
pool 303: cpus=151 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 922
pool 304: cpus=152 node=17 flags=0x0 nice=0 hung=5s workers=2 idle: 2763 927
pool 305: cpus=152 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 928
pool 306: cpus=153 node=17 flags=0x0 nice=0 hung=9s workers=2 idle: 2842 933
pool 307: cpus=153 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 934
pool 308: cpus=154 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7064 939
pool 309: cpus=154 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 940
pool 310: cpus=155 node=17 flags=0x0 nice=0 hung=61s workers=2 idle: 7961 945
pool 311: cpus=155 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 946
pool 312:
 cpus=156 node=17 flags=0x0 nice=0 hung=121s workers=2 idle: 2843 951
pool 313: cpus=156 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 952
pool 314:
 cpus=157 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7049 957
pool 315: cpus=157 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 958
pool 316: cpus=158 node=17 flags=0x0 nice=0 hung=1s workers=2 idle: 7057 963
pool 317: cpus=158 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 964
pool 318: cpus=159 node=17 flags=0x0 nice=0 hung=9s workers=2 idle: 2844 969
pool 319: cpus=159 node=17 flags=0x0 nice=-20 hung=241s workers=1 idle: 970
pool 320: cpus=0-159 flags=0x4 nice=0 hung=241s workers=1 idle: 6
pool 321:
 cpus=0-39 node=0 flags=0x4 nice=0 hung=4s workers=8 idle: 1234 5 973 1224 2623 2785 2625 2719
pool 322: cpus=40-79 node=1 flags=0x4 nice=0 hung=160s workers=4 idle: 2668 2657 254 2672
pool 323:
 cpus=80-119 node=16 flags=0x4 nice=0 hung=13s workers=2 idle: 495 8013
pool 324:
 cpus=120-159 node=17 flags=0x4 nice=0 hung=241s workers=1 idle: 736

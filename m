From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Taylor Holliday <wtholliday@ucdavis.edu>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: state of SMP on daystar quad-604 board
Date: Sat, 13 Jan 2001 09:39:22 +0100
Message-Id: <19341208021106.28653@smtp.wanadoo.fr>
In-Reply-To: <BHEOKMKGNHLELMKKJJIGCEBNCAAA.wtholliday@ucdavis.edu>
References: <BHEOKMKGNHLELMKKJJIGCEBNCAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Also, could somone point me in the right direction regarding the how to
>debug
>this stuff (beyond what the typical book-about-kernel will tell me)?
>Scouring the web revealed almost no usefull docs on the quad boards.

There are 2 different things:

 - The old Apple/Daystar 2 CPUs cards. Those should work
 - The old but slightly newer Daystar 2 and 4 CPUs card (using a different
   mecanism from the previous ones). For those I added support, but the
   current _2_4 code is slightly bogus.

First, apply this patch:

-#define PSURGE_QUAD_OUT(r, v)  (out_8((quad_base+((r)<<2)+1), (v)))
-#define PSURGE_QUAD_IN(r)      (in_8((quad_base+((r)<<2)+1)) & 0x0f)
+#define PSURGE_QUAD_OUT(r, v)  (out_8((u8 *)(quad_base+((r)<<2)+1), (v)))
+#define PSURGE_QUAD_IN(r)      (in_8((u8 *)(quad_base+((r)<<2)+1)) &
0x0f)
 #define PSURGE_QUAD_BIS(r, v)  (PSURGE_QUAD_OUT((r), PSURGE_QUAD_IN(r) |
(v)))
 #define PSURGE_QUAD_BIC(r, v)  (PSURGE_QUAD_OUT((r), PSURGE_QUAD_IN(r) &
~(v)))

 /* virtual addresses for the above */
 static volatile u8 *hhead_base;
-static volatile u8 *quad_base;
+static volatile u32 *quad_base;
 static volatile u32 *psurge_pri_intr;
 static volatile u8 *psurge_sec_intr;
 static volatile u32 *psurge_start;


Also, if you have >2 CPUs, you may have to comment out the software TB
sync code, I've been told it didn't work with more than 2 CPUs.

We are working on a fix.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

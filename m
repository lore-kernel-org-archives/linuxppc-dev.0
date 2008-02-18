Return-Path: <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
From: Andi Kleen <andi@firstfloor.org>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
Date: Mon, 18 Feb 2008 15:39:06 +0100
In-Reply-To: <20080216094226.1e8eede1@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Sat\, 16 Feb 2008 09\:42\:26 -0800")
Message-ID: <p731w7axrat.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arjan van de Ven <arjan@infradead.org> writes:
> you have more faith in the authors knowledge of how his code actually behaves than I think is warranted  :)

iirc there was a mm patch some time ago to keep track of the actual unlikely
values at runtime and it showed indeed some wrong ones. But the 
far majority of them are probably correct.

> Or faith in that he knows what "unlikely" means.
> I should write docs about this; but unlikely() means:
> 1) It happens less than 0.01% of the cases.
> 2) The compiler couldn't have figured this out by itself
>    (NULL pointer checks are compiler done already, same for some other conditions)
> 3) It's a hot codepath where shaving 0.5 cycles (less even on x86) matters
>    (and the author is ok with taking a 500 cycles hit if he's wrong)

One more thing unlikely() does is to move the unlikely code out of line.
So it should conserve some icache in critical functions, which might
well be worth some more cycles (don't have numbers though). 

But overall I agree with you that unlikely is in most cases a bad 
idea (and I submitted the original patch introducing it originally @). That is because
it is often used in situations where gcc's default branch prediction
heuristics do would make exactly the same decision

           if (unlikely(x == NULL)) 

is simply totally useless because gcc already assumes all x == NULL
tests are unlikely. I appended some of the builtin heuristics from
a recent gcc source so people can see them.

Note in particular the last predictors; assuming branch ending 
with goto, including call, causing early function return or 
returning negative constant are not taken. Just these alone
are likely 95+% of the unlikelies in the kernel.

-Andi

/* Use number of loop iterations determined by # of iterations
   analysis to set probability.  We don't want to use Dempster-Shaffer
   theory here, as the predictions is exact.  */
DEF_PREDICTOR (PRED_LOOP_ITERATIONS, "loop iterations", PROB_ALWAYS,
               PRED_FLAG_FIRST_MATCH)

/* Hints dropped by user via __builtin_expect feature.  */
DEF_PREDICTOR (PRED_BUILTIN_EXPECT, "__builtin_expect", PROB_VERY_LIKELY,
               PRED_FLAG_FIRST_MATCH)

/* Use number of loop iterations guessed by the contents of the loop.  */
DEF_PREDICTOR (PRED_LOOP_ITERATIONS_GUESSED, "guessed loop iterations",
               PROB_ALWAYS, PRED_FLAG_FIRST_MATCH)

/* Branch containing goto is probably not taken.  */
DEF_PREDICTOR (PRED_CONTINUE, "continue", HITRATE (56), 0)

/* Branch to basic block containing call marked by noreturn attribute.  */
DEF_PREDICTOR (PRED_NORETURN, "noreturn call", HITRATE (99),
               PRED_FLAG_FIRST_MATCH)

/* Branch to basic block containing call marked by cold function attribute.  */
DEF_PREDICTOR (PRED_COLD_FUNCTION, "cold function call", HITRATE (99),
               PRED_FLAG_FIRST_MATCH)

/* Loopback edge is taken.  */
DEF_PREDICTOR (PRED_LOOP_BRANCH, "loop branch", HITRATE (86),
               PRED_FLAG_FIRST_MATCH)

/* Edge causing loop to terminate is probably not taken.  */
DEF_PREDICTOR (PRED_LOOP_EXIT, "loop exit", HITRATE (91),
               PRED_FLAG_FIRST_MATCH)

/* Pointers are usually not NULL.  */
DEF_PREDICTOR (PRED_POINTER, "pointer", HITRATE (85), 0)
DEF_PREDICTOR (PRED_TREE_POINTER, "pointer (on trees)", HITRATE (85), 0)

/* NE is probable, EQ not etc...  */
DEF_PREDICTOR (PRED_OPCODE_POSITIVE, "opcode values positive", HITRATE (79), 0)
DEF_PREDICTOR (PRED_OPCODE_NONEQUAL, "opcode values nonequal", HITRATE (71), 0)
DEF_PREDICTOR (PRED_FPOPCODE, "fp_opcode", HITRATE (90), 0)
DEF_PREDICTOR (PRED_TREE_OPCODE_POSITIVE, "opcode values positive (on trees)", HITRATE (70), 0)
DEF_PREDICTOR (PRED_TREE_OPCODE_NONEQUAL, "opcode values nonequal (on trees)", HITRATE (69), 0)
DEF_PREDICTOR (PRED_TREE_FPOPCODE, "fp_opcode (on trees)", HITRATE (90), 0)

/* Branch guarding call is probably taken.  */
DEF_PREDICTOR (PRED_CALL, "call", HITRATE (69), 0)

/* Branch causing function to terminate is probably not taken.  */
DEF_PREDICTOR (PRED_TREE_EARLY_RETURN, "early return (on trees)", HITRATE (54), 0)

/* Branch containing goto is probably not taken.  */
DEF_PREDICTOR (PRED_GOTO, "goto", HITRATE (70), 0)

/* Branch guarding call is probably taken.  */
DEF_PREDICTOR (PRED_CALL, "call", HITRATE (69), 0)

/* Branch causing function to terminate is probably not taken.  */
DEF_PREDICTOR (PRED_TREE_EARLY_RETURN, "early return (on trees)", HITRATE (54), 0)

/* Branch containing goto is probably not taken.  */
DEF_PREDICTOR (PRED_GOTO, "goto", HITRATE (70), 0)

/* Branch ending with return constant is probably not taken.  */
DEF_PREDICTOR (PRED_CONST_RETURN, "const return", HITRATE (67), 0)

/* Branch ending with return negative constant is probably not taken.  */
DEF_PREDICTOR (PRED_NEGATIVE_RETURN, "negative return", HITRATE (96), 0)

/* Branch ending with return; is probably not taken */
DEF_PREDICTOR (PRED_NULL_RETURN, "null return", HITRATE (96), 0)

/* Branches to a mudflap bounds check are extremely unlikely.  */
DEF_PREDICTOR (PRED_MUDFLAP, "mudflap check", PROB_VERY_LIKELY, 0)

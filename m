Date: Tue, 9 Apr 2002 14:09:28 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <19589.020409@vanet.com.br>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
In-reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F8E@mail.mediatrix.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F8E@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis,

See comments below.

[]'s, Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
"We all lie in the gutter, but some of us look up at the stars."
-- Oscar Wilde

Tuesday, April 09, 2002, 11:53:45 AM, you wrote:


JDB> I have a custom board that uses an 8260 (rev. A.1 1K22A).
Same CPU and rev, other custom board.

JDB> We've had for a long time a problem of spurious interrupt.
JDB> On kernel 2.4.10, at boot up, the following message was written to the
JDB> console:

JDB>   Unhandled interrupt 0, disabled
We have this with kernel 2.4.16.

JDB> This message did not appear on kernel 2.4.18 (I don't know why),
Didn't try 2.4.18, yet.

JDB> but in /proc/interrupts, the number at the right of BAD was increasing
JDB> slowly.

<snip>

JDB> Putting traces in the interrupt handler, it appeared that the interrupt
JDB> happened in '__sti()' (arch/ppc/kernel/misc.S), just after calling 'mtmsr'
JDB> to turn on the 'EE' bit.

JDB> I added a 'sync', between 'ori r3,r3,MSR_EE' and 'mtmsr r3',
JDB> and it has fixed the problem.
I'll try that, thanks.

JDB> My questions are:
JDB>  - Did anybody encountered the same problem on that core?
yes.

JDB>  - Did anybody seen something about that in the user's manual and/or the
JDB> errata?
no.

JDB>  - Is my fix correct, and should it be brought to other calls to 'mtmsr' ?
I don't have the knowledge to answer that :-(


JDB> --------------------------------------------
JDB>  Jean-Denis Boyer, B.Eng., System Architect
JDB>  Mediatrix Telecom Inc.
JDB>  4229 Garlock Street
JDB>  Sherbrooke (Québec)
JDB>  J1L 2C8  CANADA
JDB>  (819)829-8749 x241
JDB> --------------------------------------------

JDB> ** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

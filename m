Date: Thu, 26 Jun 2003 16:47:28 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: Terry Greeniaus <tgree@phys.ualberta.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: how to setup PLL1 on 750FX
In-Reply-To: <Pine.LNX.4.10.10306261126040.7619-100000@pneuma.phys.ualberta.ca>
Message-ID: <Pine.LNX.4.44.0306261631001.9491-100000@stoa.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I've got PLL1 setup correctly now.  It seems that there is a switch to
PLL1 in power_save_6xx.  Also, a copy of HID1 is saved in init_idle_6xx
and restored in power_save_6xx_restore.  Ben mentioned something about
this earlier with the clue:

  If PLL1 isn't set, you should probably not set powersave_lowspeed
  in arch/ppc/platforms/pmac_feature.c.

I don't understand how it is that my machine didn't lockup when PLL1 was
in the off state.

Anyway, I decided to set PLL1 in identify_cpu in misc.S.  Actually, I put
the code to detect the 750fx and set PLL1 in a seperate method.  Here's
what I have:

/*
 * identify_cpu,
 * called with r3 = data offset and r4 = CPU number
 * doesn't change r3
 */
_GLOBAL(identify_cpu)
        mfpvr   r7

        /* if pvr reports 750, check for 750fx */
        srwi    r6,r7,16
        cmpli   0,r6,8
        bne     2f
        mflr    r8
        bl      identify_cpu_750fx
        mtlr    r8

2:
        addis   r8,r3,cpu_specs@ha
        addi    r8,r8,cpu_specs@l

1:
        lwz     r5,CPU_SPEC_PVR_MASK(r8)
        and     r5,r5,r7
        lwz     r6,CPU_SPEC_PVR_VALUE(r8)
        cmplw   0,r6,r5
        beq     1f
        addi    r8,r8,CPU_SPEC_ENTRY_SIZE
        b       1b
1:
        addis   r6,r3,cur_cpu_spec@ha
        addi    r6,r6,cur_cpu_spec@l
        slwi    r4,r4,2
        sub     r8,r8,r3
        stwx    r8,r4,r6
        addis   r6,r3,real_pvr@ha
        stw     r7,real_pvr@l(r6)
        blr

/* Check for 750fx cpu strapped on as a 750.  Also, if 750fx and PLL1 is
 * not in use, set PLL1 to 4x and delay as needed to lock pll.
 * Called with pvr in r7 (assumed to be 0x0008nnnn).
 * Returns new pvr in r7.
 * r5,r6 are changed.
 */
identify_cpu_750fx:
        mfspr   r5,SPRN_HID1
        andis.  r6,r5,0x0001
        xori    r6,r5,0x0002
        beq     1f
        xori    r6,r5,0x0200
1:
        mtspr   SPRN_HID1,r6
        mfspr   r6,SPRN_HID1
        cmplw   0,r5,r6
        beqlr

        /* pvr is actually 0x7000nnnn, not 0x0008nnnn */
        xoris   r7,r7,0x7008
        mtspr   SPRN_HID1,r5

        andis.  r6,r5,0x0001
        bnelr

        li      r6,0x00FE
        andc    r5,r5,r6
        ori     r5,r5,0x0044
        mtspr   SPRN_HID1,r5

        /* delay for at least 0.5sec (on 1GHz or slower cpu) */
        lis     r6,0x1DCE
        mtctr   r6
2:      bdnz    2b
        blr

I know HID1 is being set correctly as I modified cpuinfo to output a few
SPR's:

  $ cat /proc/cpuinfo
  cpu             : 750FX
  temperature     : 19-21 C (uncalibrated)
  clock           : 898MHz
  revision        : 2.2 (pvr 7000 0202)
  HID0            : 0xC010C0AC
  HID1            : 0x92000044
  L2CR            : 0xBB000000
  bogomips        : 1795.68
  machine         : PowerBook3,1
  motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
  detected as     : 70 (PowerBook Pismo)
  pmac flags      : 0000000f
  L2 cache        : 512K unified
  memory          : 256MB
  pmac-generation : NewWorld

Comments/critique?  I haven't tried cpufreq yet.  That's next.
Chris.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: RFC: 405LP sleep
From: Hollis Blanchard <hollis@austin.ibm.com>
To: devel list <linuxppc-dev@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-JTOeNfjB4AilITl9y4S2"
Date: 19 Dec 2002 14:41:28 -0600
Message-Id: <1040330490.29647.340.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-JTOeNfjB4AilITl9y4S2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I think the patch is too large. You can find it at
http://penguinppc.org/~hollis/405LP-sleep.diff

I've attached the Documentation file here.

-Hollis

-----Forwarded Message-----

From: Hollis Blanchard <hollis@austin.ibm.com>
To: devel list <linuxppc-dev@lists.linuxppc.org>
Subject: RFC: 405LP sleep
Date: 19 Dec 2002 14:08:43 -0600

This patch implements sleep on the IBM 405LP (described in the
Documentation file at the top of the patch).

It's not quite ready to check in, but I'd like it to be very soon. I'm
still looking for the solution to my get_pteptr question btw...

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


--=-JTOeNfjB4AilITl9y4S2
Content-Disposition: attachment; filename=405LP-sleep.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=405LP-sleep.txt; charset=ISO-8859-1

Hollis Blanchard, IBM Linux Technology Center
19 Dec 2002
draft

Linux Sleep on the PowerPC 405LP
--------------------------------

The IBM 405LP embedded CPU has three different sleep modes, assisted by a u=
nit
called "APM0". APM has four wakeup interrupt lines which it cascades onto t=
he
UIC as irq 24. When the 405LP enters a sleep mode, the only thing that can
wake it is those four wakeup lines. One wakeup line is connected to the RTC
interrupt line, allowing wakeup when an RTC alarm goes off. The other three
are board-dependent; on Beech one is connected to a physical button.

Sleep Modes
-----------

1. In "clock-suspend" mode the output of the PLL is stopped. No units are
powered down, and so no state is lost. On wakeup, the PLL continues and
processing resumes exactly where it left off.

2. In "power-down" mode, APM signals the power supply to drop power to the =
CPU
and integrated peripherals. All important state, including GPRs, SPRs, and
DCRs must be saved by software before entering this sleep mode, and restore=
d
after wakeup. SDRAM is not powered off, so state can be saved there as long=
 as
SDRAM is put in self-refresh mode prior to the sleep.

When a wakeup occurs, the chip (CPU and integrated peripherals) is reset,
returning control to the firmware. The firmware must determine that this is=
 a
wakeup (rather than a normal power-on) by polling the APM0_CFG and APM0_SR
registers.

3. In "standby" mode, APM first freezes the PLL. It then transfers all chip
state (excluding core registers and arrays such as the TLB) over the
i2c bus to a nonvolatile storage device (such as an EEPROM). Once that proc=
ess
is complete, APM signals the power supply to drop power to the CPU
and integrated peripherals.

When a wakeup occurs, the chip (CPU and integrated peripherals) is reset bu=
t
held frozen. APM transfers the saved chip state back over the i2c bus. It t=
hen
releases the PLL and processing continues from the reset vector, returning
control to the firmware. The firmware must determine that this is a wakeup
(rather than a normal power-on) by polling the APM0_CFG and APM0_SR registe=
rs.

Interaction with Linux
----------------------

Note: that because the chip is reset on wakeup in both power-down and stand=
by
modes, the firmware *must* be made APM-aware. Otherwise, a wakeup will simp=
ly
reset the chip, losing all state. clock-suspend mode does not require firmw=
are
interaction.

On wake, the firmware must know how to transfer control back to Linux (whic=
h
is still resident in RAM). The following structure is used:

struct wakeup_info {
	void (*wakeup_func_phys)(u32 apm0_cfg, u32 apm0_sr); /* physical addr */
	u32 magic;
	...
}

Firmware is aware only of the first two fields. Linux creates and populates
this structure in memory, and writes the pointer to a well-known location
(currently 0xfc physical) for the firmware to read.  (Unfortunately there a=
re
no "scratch" registers provided by the APM unit, requiring used of a
predetermined absolute physical address.) The magic number is intended to b=
e a
simple validator ensuring that the contents of SDRAM have not been corrupte=
d.

Currently Linux also saves one other value in the wakeup_info structure: th=
e
(physical) stack pointer.

Linux Sleep Procedure
---------------------

This is a high-level summary; the code is well-documented.

For power-down and standby modes:

	One page is allocated in which to save some CPU registers and the DCRs
	currently supported by power-down mode (UART and LCD). EBC registers are
	always saved even though standby mode will save/restore them, because
	firmware may overwrite those registers before returning control to Linux
	on wake.

	The non-volatile GPRs, all 64 TLB entries, and quite a few SPRs like LR,
	MSR, and EVPR are saved to the stack in an assembly routine. The registers
	saved here are those that must be restored before returning into C code on
	wakeup; i.e. they cannot be saved and restored in C.

The remaining code is touched into the I-cache so that SDRAM can be put int=
o
self-refresh. The sleep command is written to the APM unit, and then the
processor spins in a bdnz loop until either:
1. the APM unit freezes the processor
2. the CTR register decrements to zero, indicating sleep did not take place

Linux Wakeup Procedure
---------------------

The firmware jumps to the address specified by wakeup_info->wakeup_func_phy=
s .
The processor is still in untranslated mode (MSR:IR/DR =3D 0). The stack po=
inter
is immediately restored from wakeup_info->wakeup_sp_phys so that SPRs can b=
e
loaded and restored from the stack. Finally, the non-volatile GPRs are
restored, and control returns via an rfi to the C function executed before
sleep, returning to translated mode (MSR:IR/DR =3D 1). The C function conti=
nues
to restore non-essential registers which were not handled in assembly.

The RTC remains active during sleep, but the timebase does not, and obvious=
ly
jiffies has not been incremented. To restore the timebase, the pre-sleep RT=
C
time is subtracted from the current RTC time to get the difference in secon=
ds.
- jiffies are incremented by (seconds elapsed) * HZ.
- the timebase is incremented by (seconds elapsed) * HZ * tb_ticks_per_jiff=
y

User Interface
--------------

Currently the only interface to the sleep code is via sysctl (and its /proc
interface). The following /proc items are present under /proc/sys/pm :
	suspend: (write-only)
		triggers sleep
	mode: (string)
		contains one of "clock-suspend", "power-down", or "standby",
		indicating the sleep mode to be used.
	rtc_alarm: (integer)
		the number of seconds in the future to wake up. If 0, the RTC alarm is
		not set (and some other mechanism must be present to wake up the CPU).
	cdiv: (integer, for debugging only)
		allows the user to override the "cdiv" field of APM0_CFG, which
		controls the speed at which CPU state is transferred over the i2c bus.

It should be easy to add an interrupt handler for irq 24, so that pressing =
the
APM button on Beech triggers both sleep and wakeup.

--=-JTOeNfjB4AilITl9y4S2--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

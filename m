Subject: Re: Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Ethan Benson <erbenson@alaska.net>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031014070707.GA8972@iram.es>
References: <20031011004541.5eda8953.billfink@mindspring.com>
	 <20031011052716.GB24569@plato.local.lan> <1065884293.682.27.camel@gaston>
	 <20031014070707.GA8972@iram.es>
Content-Type: text/plain
Message-Id: <1066130216.1509.37.camel@gaston>
Mime-Version: 1.0
Date: Tue, 14 Oct 2003 13:16:56 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How does the Keylargo timer work? Any pointer?

Darwin code... But it's basically a 64 bits counter at
KL base +

#define   kKeyLargoCounterLoOffset      0x15038
#define   kKeyLargoCounterHiOffset      0x1503C

MacOS X Appelle une fonction asm "TimeSystemBusKeyLargo" qui mesure
le nombre de "ticks" KeyLargo pour 1,048,575 PowerPC decrementer/tb
units.

(copied below)

And then uses that "tick" value this way:

        ticks = TimeSystemBusKeyLargo (keyLargoBaseAddress);
        if (intLock) {
                IOSimpleLockUnlockEnableInterrupt(intLock, is); // As you were
                IOSimpleLockFree (intLock);
        }

        systemBusHz = 4194300;
        systemBusHz *= 18432000;
        systemBusHz /= ticks;


;
; TimeSystemBusKeyLargo(inKeyLargoBaseAddress)
;
; TimeSystemBusKeyLargo - Times how long it takes the PowerPC decrementer to count down
; 1,048,575 ticks.
;
; returns, in r3, the number of KeyLargo timer ticks per 1,048,575 PowerPC decrementer ticks.
;
; trashes r3 - r10
;
; NOTE - interrupts should be disabled when calling this code
;



ENTRY(TimeSystemBusKeyLargo, TAG_NO_FRAME_USED)

                        lis             r4, 0x000F
                        ori             r4, r4, 0xFFFF          ; Load decrementer tick count (1,048,575)
                        lis             r6, kKeyLargoCounterLoOffset >> 16
                        ori             r6, r6, kKeyLargoCounterLoOffset & 0xFFFF ; Counter lo offset
                        lis             r7, kKeyLargoCounterHiOffset >> 16
                        ori             r7, r7, kKeyLargoCounterHiOffset & 0xFFFF ; Counter hi offset
                        lwbrx   r8, r6, r3                      ; Read low 32-bits of counter
                        lwbrx   r9, r7, r3                      ; Read hi 32-bits of counter

                        ; Set up decrementer and wait for it to tick down

                        mtdec   r4                                      ; Set decrementer to 1,048,575
                        isync

NewDecrementerLoop:
                        mfdec   r5                                      ; Read current decrementer value
                        cmpwi   r5, 0                           ; Check if decrementer is zero
                        bgt+    NewDecrementerLoop              ; If not yet to zero, keep looping
                        sync

                        ; Read current value of KeyLargo to get delta time

                        lwbrx   r4, r6, r3                      ; Load low 32-bits of timer (latches all 64 bits)
                        lwbrx   r5, r7, r3                      ; Load high 32-bits of timer (clear latch)

                        ; Calculate difference
                        subf    r3, r8, r4                      ; Subtract low bits (ignore wrap)
                        blr                                                     ; Return
(END)



> Also for these machines it seems that OF also returns wrong values.
> Maybe there is an OF update somewhere.
>
> Does anybody know what MacOS X (most MacOS X machines probably use
> ntp) do?
>
> Sorry, more questions than answers. It superficially looks
> like a HW screw-up in one specific series of machines.
>
> 	Gabriel
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

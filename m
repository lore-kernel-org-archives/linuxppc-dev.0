Date: Sun, 27 Apr 2003 00:08:00 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.            " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051390877.1824.44.camel@gaston>
Message-Id: <8B086419-7833-11D7-838B-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, April 26, 2003, at 11:01 PM, Benjamin Herrenschmidt wrote:
>> The pc was in fbcon_radeon_bmove, so even if it's a fbcon problem, the
>> crash is happening into the radeonfb module...
>> video=ofonly works fine because it does not use fbcon_radeon_bmove I
>> guess...
>
> Well... The only way I see fbcon_radeon_bmove crash this way
> would be because of a corrupt struct display.
>
>>> So there is probably some memory corruption going on... I'm comparing
>>> other bits of ben8 and ben9 now and see nothing relevants. The
>>> changes
>>> where in the cache flush affecting cpufreq and sleep, and radeonfb...
>> Since the crash occurs in the scoll, if there is a problem with the
>> font (corrupted font or something) the scroll computation might be
>> wrong, and thus fbcon_radeon_bmove might copy some memory from/to a
>> bad
>> area.
>
> I don't think so. But try commenting out setting of the font in the
> init scripts and let me know if that helps.
I already did that the first time with ben10, before writing to this
list, and usually it deferred the problem. It then froze randomly while
using the computer (usually a few minutes after using it). I'll try
again soon.

>> Unfortunately those bugs are the most difficult to find and fix.
>> What I could do is disable some part of the -ben9 patch in favor of
>> the
>> -ben8 version, until I find in which part it happens.
>
> Can you try the xmon tricks I told you so I get a disassembly
> (only copy the first 2 or 3 lines) and the register dump
I copied 2 lines before pc and several after so that you can find the
exact part in the code.
disassembly:
c0184554 380b0e40 addi	r0,r11,3640
c0184558 7c00042c lwbrx	r0,r0,r0
c018455c 0c000000 twi	0,r0,0   <---- pc
c0184560 4c00012c isync
c0184564 2c000000 cmpwi r0,0
c0184568 39290001 addi	r9,r9,1
c018456c 7ce00026 mfcr	r7
c0184570 7f895000 cmpw	cr7,r9,r10
c0184574 90c10014 stw	r7,20(r1)
c0184578 40800014 bge	0xc018458c
c018457c 409dffd8 ble	0xc0184554
...

registers:
r00=ffffffff r01=d7d85d00 r02=d7d84000 r03=001e847f
r04=00000010 r05=00000000 r06=00000000 r07=84222888
r08=001e847f r09=000005ac r10=001e847f r11=d9000000
r12=c0930000 r13=100c50bc r14=c0345f04 r15=d7d85e58
r16=00000001 r17=00000000 r18=c0345f04 r19=000000ff
r20=00000001 r21=ffffffff r22=00000000 r23=c19bc100
r24=00000001 r25=00000000 r26=00000030 r27=00000000
r28=44222888 r29=00000003 r30=00000023 r31=000002f0
pc =c018455c msr=00049030 lr =c0178f3e crc=84222888
ctr=c0184394 xcr=00000000 trap=200

This was copied by hand, so I hope there is no errors in the
transcription.
Do you know if it's possible to obtain this trace on another computer
(like with a serial console) on computers without serial port ?

> I'm not sure anything in -ben9 compared to -ben8 explains the
> problem if using -ben8's radeonfb in -ben9 still dies. I think
> something get corrupt in struct display, it would be useful to
> figure out what.
I can provide you more information if you want. -ben9 crash is fully
reproducible.

Thanks,
Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

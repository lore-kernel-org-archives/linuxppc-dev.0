Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.              " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <8B086419-7833-11D7-838B-0003939D5F18@tincell.com>
References: <8B086419-7833-11D7-838B-0003939D5F18@tincell.com>
Content-Type: text/plain
Message-Id: <1051395184.1829.52.camel@gaston>
Mime-Version: 1.0
Date: 27 Apr 2003 00:13:04 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> disassembly:
> c0184554 380b0e40 addi	r0,r11,3640
> c0184558 7c00042c lwbrx	r0,r0,r0
> c018455c 0c000000 twi	0,r0,0   <---- pc
> c0184560 4c00012c isync
> c0184564 2c000000 cmpwi r0,0
> c0184568 39290001 addi	r9,r9,1
> c018456c 7ce00026 mfcr	r7
> c0184570 7f895000 cmpw	cr7,r9,r10
> c0184574 90c10014 stw	r7,20(r1)
> c0184578 40800014 bge	0xc018458c
> c018457c 409dffd8 ble	0xc0184554
> ...
>
> registers:
> r00=ffffffff r01=d7d85d00 r02=d7d84000 r03=001e847f
> r04=00000010 r05=00000000 r06=00000000 r07=84222888
> r08=001e847f r09=000005ac r10=001e847f r11=d9000000
> r12=c0930000 r13=100c50bc r14=c0345f04 r15=d7d85e58
> r16=00000001 r17=00000000 r18=c0345f04 r19=000000ff
> r20=00000001 r21=ffffffff r22=00000000 r23=c19bc100
> r24=00000001 r25=00000000 r26=00000030 r27=00000000
> r28=44222888 r29=00000003 r30=00000023 r31=000002f0
> pc =c018455c msr=00049030 lr =c0178f3e crc=84222888
> ctr=c0184394 xcr=00000000 trap=200
>
> This was copied by hand, so I hope there is no errors in the
> transcription.
> Do you know if it's possible to obtain this trace on another computer
> (like with a serial console) on computers without serial port ?

Hrm... Interesting. It dies reading from the chip (MMIO). Can you
check with xmon "h" command if there's a translation for 0xd9000000 ?

(Or hack radeonfb init to printk the result of ioremap of the registers
to see if it's really 0xd9000000 or if the structure was corrupted some
way)

What is the exact error in xmon ? (vector number)


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

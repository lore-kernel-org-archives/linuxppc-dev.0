From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Fwd: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 13:12:49 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_yGgxxpkLoRellNMPapqfWkHOPkMC"
MIME-Version: 1.0
Message-Id: <00012013133502.00819@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_yGgxxpkLoRellNMPapqfWkHOPkMC
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi,

Can anyone explain this to me?

> Finally I got it!

>   asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex), "r"(base_addr));

>   asm("lwbrx %0,%1,%2": "=r"(val):"r"(regindex), "r"(base_addr));

>   asm("stwbrx %0,%1,%2": : "r"(regdata), "b"(regindex), "r"(base_addr));

>   asm("lwbrx %0,%1,%2": "=r"(val):"b"(regindex), "r"(base_addr));


> Don't know if this is correct (no clue about ppc assembly), but it works...

Well I did the following with the attached sample program:

gcc -O0 -S testit.c

then I looked at testit.s  (the assembler).

old_regw:
        stwu 1,-32(1)
        stw 31,28(1)
        mr 31,1
        stw 3,8(31)
        mr 0,4
        lis 11,mach64MemReg@ha
        lwz 9,mach64MemReg@l(11)
        lwz 11,8(31)
        stwbrx 0,11,9
.L2:
        lwz 11,0(1)
        lwz 31,-4(11)
        mr 1,11
        blr
.Lfe2:
        .size    old_regw,.Lfe2-old_regw
        .align 2
        .type    old_regr,@function
old_regr:
        stwu 1,-32(1)
        stw 31,28(1)
        mr 31,1
        stw 3,8(31)
        lis 9,mach64MemReg@ha
        lwz 0,mach64MemReg@l(9)
        lwz 11,8(31)
        lwbrx 9,11,0
        mr 3,9
        b .L3
.L3:
        lwz 11,0(1)
        lwz 31,-4(11)
        mr 1,11
        blr
.Lfe3:
        .size    old_regr,.Lfe3-old_regr
        .align 2
:regw:
        stwu 1,-32(1)
        stw 31,28(1)
        mr 31,1
        stw 3,8(31)
        mr 0,4
        lis 11,mach64MemReg@ha
        lwz 9,mach64MemReg@l(11)
        lwz 11,8(31)
        stwbrx 0,11,9
.L4:
        lwz 11,0(1)
        lwz 31,-4(11)
        mr 1,11
        blr
.Lfe4:
        .size    regw,.Lfe4-regw
        .align 2
        .type    regr,@function
regr:
        stwu 1,-32(1)
        stw 31,28(1)
        mr 31,1
        stw 3,8(31)
        lis 9,mach64MemReg@ha
        lwz 0,mach64MemReg@l(9)
        lwz 11,8(31)
        lwbrx 9,11,0
        mr 3,9
        b .L5
.L5:
        lwz 11,0(1)
        lwz 31,-4(11)
        mr 1,11
        blr

And I simply can not see any difference in the actual code produced by each
bunch of asm statements which leads me to believe that there is something else
going on here.

I would love to know exactly what.

Will you please try compiling the code I attached to get the assembler out and
compare old_regr and regr and old_rew and regw and see if you find any
differences.


Are you sure you haven't changed *anything* else?

Thanks,

Kevin


--Boundary-=_yGgxxpkLoRellNMPapqfWkHOPkMC
Content-Type: text/plain;
  name="testit.c"
Content-Disposition: attachment; filename="testit.c"
Content-Transfer-Encoding: base64

I2lmIGRlZmluZWQgKF9fcG93ZXJwY19fKQoKdW5zaWduZWQgaW50IG1hY2g2NE1lbVJlZyA9IDB4
REVBREJFQUY7CgpzdGF0aWMgaW5saW5lIHZvaWQgb2xkX3JlZ3codm9sYXRpbGUgdW5zaWduZWQg
bG9uZyByZWdpbmRleCwgdW5zaWduZWQgbG9uZyByZWdkYXRhKQp7CiAgcmVnaXN0ZXIgdW5zaWdu
ZWQgbG9uZyBiYXNlX2FkZHIgPSAodW5zaWduZWQgbG9uZyltYWNoNjRNZW1SZWc7CgogIGFzbSgi
c3R3YnJ4ICUwLCUxLCUyIjogOiAiciIocmVnZGF0YSksICJyIihyZWdpbmRleCksICJyIihiYXNl
X2FkZHIpKTsKfQoKc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG9sZF9yZWdyKHZvbGF0aWxl
IHVuc2lnbmVkIGxvbmcgcmVnaW5kZXgpCnsKICByZWdpc3RlciB1bnNpZ25lZCBsb25nIGJhc2Vf
YWRkciA9ICh1bnNpZ25lZCBsb25nKW1hY2g2NE1lbVJlZywgdmFsOwoKICBhc20oImx3YnJ4ICUw
LCUxLCUyIjogIj1yIih2YWwpOiJyIihyZWdpbmRleCksICJyIihiYXNlX2FkZHIpKTsKICByZXR1
cm4odmFsKTsKfQoKc3RhdGljIGlubGluZSB2b2lkIHJlZ3codm9sYXRpbGUgdW5zaWduZWQgbG9u
ZyByZWdpbmRleCwgdW5zaWduZWQgbG9uZyByZWdkYXRhKQp7CiAgcmVnaXN0ZXIgdW5zaWduZWQg
bG9uZyBiYXNlX2FkZHIgPSAodW5zaWduZWQgbG9uZyltYWNoNjRNZW1SZWc7CgogIGFzbSgic3R3
YnJ4ICUwLCUxLCUyIjogOiAiciIocmVnZGF0YSksICJiIihyZWdpbmRleCksICJyIihiYXNlX2Fk
ZHIpKTsKfQoKc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHJlZ3Iodm9sYXRpbGUgdW5zaWdu
ZWQgbG9uZyByZWdpbmRleCkKewogIHJlZ2lzdGVyIHVuc2lnbmVkIGxvbmcgYmFzZV9hZGRyID0g
KHVuc2lnbmVkIGxvbmcpbWFjaDY0TWVtUmVnLCB2YWw7CgogIGFzbSgibHdicnggJTAsJTEsJTIi
OiAiPXIiKHZhbCk6ImIiKHJlZ2luZGV4KSwgInIiKGJhc2VfYWRkcikpOwogIHJldHVybih2YWwp
Owp9CiNlbmRpZgoKaW50IG1haW4oKSB7CiBpbnQgb2Zmc2V0PTEwOwogaW50IGRhdGE9MTI7CiBp
bnQgaW5wdXQsIGlucHV0MjsKIAogaW5wdXQgPSByZWdyKG9mZnNldCk7CiBpbnB1dCA9IG9sZF9y
ZWdyKG9mZnNldCk7CgogcmVndyhvZmZzZXQsZGF0YSk7CiBvbGRfcmVndyhvZmZzZXQsZGF0YSk7
Cgp9Cg==

--Boundary-=_yGgxxpkLoRellNMPapqfWkHOPkMC--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <017201c09fe4$52a1cff0$5ef1d092@chn.agilent.com>
From: "kerler" <kerler@mailandnews.com>
To: <linuxppc-dev@lists.linuxppc.org>
References: <033b01c09a52$e88f11e0$bf0102c8@sc.mcel.mot.com>
Subject: dynamic modification exception handler
Date: Mon, 26 Feb 2001 19:06:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am developing a module (called M in the following).

When I insmod M into a running kernel, M replace the binary code at "void
SingleStepException(struct pt_regs *regs)" with a series of codes (called
PATCH_CODE in the following). So when a single-step exception occurs, the
exception will be handled by the PATCH_CODE.

When a user-level single-step exception occur, PATCH_CODE will restore the
original binary code of SingleStepException(), restore the registers' values
when PATCH_CODE is called, then rfi (use rfi is for not using LR
register.MSR is also be restored.) to SingleStepException() to continue.
(NOTE: all the registers' values when SingleStepException() is called in
this way are the same as the registers' values when SingleStepException() is
not be replaced with PATCH_CODE.)

Now, the problem is:
After PATCH_CODE restore original SingleStepException() code and rfi to it,
I found that the code executed is still the codes of PATCH_CODE, not the
restored original SingleStepException's codes.

I have tried the following two methods to invalidate the instruction cache
after the binary codes was modified, but both have no use. But, after
PATCH_CODE has restored the original codes of SingleStepException in the
first time user-lever single-step exception, the restored original codes of
SingleStepException will be executed when the second time user-level
single-step exception occurs.

SingleStepException() is called by transfer_to_handler() in
arch/ppc/kernel/head.S and will return to int_return() in head.S. MMU is
enabled by transfer_to_handler before SingleStepException() is called.

Why the instruction cache is not invalidated after the following two methods
are used? And why the restored codes can be executed when the 2nd time
user-level single-step exception occurs?

------------method 1---------
void mdb_flush_cache (const unsigned int start, const unsigned int len)
{
    unsigned int i;
    for ( i = start ; i <= len + start ; i += 0x20 )
    {
        __asm__ __volatile__ ("dcbf 0,%0;icbi 0,%0"::"r"((void*)i));
    }
    __asm__ __volatile("eieio;isync;");
}
-----------method 1----------

-----------method 2----------
static inline void store_inst(void *p)
{
    asm volatile ("dcbst 0,%0; sync; icbi 0,%0; isync" : : "r" (p));
}
void mdb_flush_cache (const unsigned int start, const unsigned int len)
{
    unsigned int i;
    for ( i = start ; i <= len + start ; i ++ )
    {
        store_inst((void*)start);
    }
}
------------end of method 2------

thanks,
kerler

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

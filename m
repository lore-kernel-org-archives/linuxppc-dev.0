Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id B11A4DE248
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 00:42:13 +1000 (EST)
Received: from toip6.srvr.bell.ca ([209.226.175.125])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080819144211.TXGL1572.tomts5-srv.bellnexxia.net@toip6.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 10:42:11 -0400
Date: Tue, 19 Aug 2008 10:42:11 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080819144211.GB21929@Krystal>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<alpine.DEB.1.10.0808181439480.796@gandalf.stny.rr.com>
	<48AAB7FF.4070502@extricom.com>
	<20080819130533.GA18611@Krystal> <48AAD702.10700@extricom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48AAD702.10700@extricom.com>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Eran Liberty (liberty@extricom.com) wrote:
> Mathieu Desnoyers wrote:
>> Can you also give us
>>
>> objdump -S --start-address=0xC00BB724 vmlinux | head 20
>>
>> ?
>>
>> Then we could compare the result with the OOPS instruction dump :
>>
>> 7c0802a6 bf61000c 3f60c038 7c3f0b78 90010024 7c7c1b78 7c9d2378 83db32a0
>> 73c00001 7f83e378 7fa4eb78 4082002f <00000000> 2f830000 409e0030 801b32a0
>>
>> Mathieu
>>
>>   
>
> to give you more context I have run:
> > powerpc-linux-gnu-objdump -S --start-address=0xC00BB700 vmlinux | head -n 
> 60
>
> the discrepancy starts at address:
> c00bb720: 40 82 00 30 <=> 40 82 00 2f
> c00bb724: 4b ff fe 61 <=> 00 00 00 00
>

Ah !

I think I see what could be wrong :

First we have :

static unsigned int ftrace_nop = 0x60000000;

We probably replace the original function call by this nop.

Then we do :

notrace unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
{
        static unsigned int op;

        /*
         * It would be nice to just use create_function_call, but that will
         * update the code itself. Here we need to just return the
         * instruction that is going to be modified, without modifying the
         * code.
         */
        addr = GET_ADDR(addr);

        /* Set to "bl addr" */
        op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);

        /*
         * No locking needed, this must be called via kstop_machine
         * which in essence is like running on a uniprocessor machine.
         */
        return (unsigned char *)&op;
}

And I guess we must be doing a 0x48000001 | 0x0; or something ?

Also, we have to consider that POWERPC 64 functions are :

/* PowerPC64's functions are data that points to the functions */

And this does not seem to hold for ppc32. Therefore, it is strange to me
that the same code is used for the update.. are we updating the correct
site ?

Mathieu

> vmlinux:     file format elf32-powerpc
>
> Disassembly of section .text:
>
> c00bb700 <d_lookup+0x1c>:
> * d_lookup() is protected against the concurrent renames in some unrelated
> * directory using the seqlockt_t rename_lock.
> */
>
> struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
> {
> c00bb700:       7c 3f 0b 78     mr      r31,r1
> c00bb704:       90 01 00 24     stw     r0,36(r1)
> c00bb708:       7c 7c 1b 78     mr      r28,r3
> c00bb70c:       7c 9d 23 78     mr      r29,r4
> c00bb710:       83 db 32 a0     lwz     r30,12960(r27)
> {
>        unsigned ret;
>
> repeat:
>        ret = sl->sequence;
>        smp_rmb();
> c00bb714:       73 c0 00 01     andi.   r0,r30,1
>        struct dentry * dentry = NULL;
>        unsigned long seq;
>
>        do {
>                seq = read_seqbegin(&rename_lock);
>                dentry = __d_lookup(parent, name);
> c00bb718:       7f 83 e3 78     mr      r3,r28
> c00bb71c:       7f a4 eb 78     mr      r4,r29
>        if (unlikely(ret & 1)) {
> c00bb720:       40 82 00 30     bne-    c00bb750 <d_lookup+0x6c>
> c00bb724:       4b ff fe 61     bl      c00bb584 <__d_lookup>
>                if (dentry)
> c00bb728:       2f 83 00 00     cmpwi   cr7,r3,0
> c00bb72c:       40 9e 00 30     bne-    cr7,c00bb75c <d_lookup+0x78>
> *
> * If sequence value changed then writer changed data while in section.
> */
> static __always_inline int read_seqretry(const seqlock_t *sl, unsigned 
> start)
> {
>        smp_rmb();
> c00bb730:       80 1b 32 a0     lwz     r0,12960(r27)
>                        break;
>        } while (read_seqretry(&rename_lock, seq));
> c00bb734:       7f 80 f0 00     cmpw    cr7,r0,r30
> c00bb738:       41 9e 00 24     beq-    cr7,c00bb75c <d_lookup+0x78>
> /* Start of read calculation -- fetch last complete writer token */
> static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
> {
>        unsigned ret;
>
> repeat:
> c00bb73c:       7c 1e 03 78     mr      r30,r0
>        ret = sl->sequence;
>        smp_rmb();
> c00bb740:       73 c0 00 01     andi.   r0,r30,1
>        struct dentry * dentry = NULL;
>

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

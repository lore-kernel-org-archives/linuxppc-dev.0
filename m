Return-Path: <steffen.rumler.ext@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
 [93.183.12.32])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "demumfd001.nsn-inter.net",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C60BAB6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 17:43:26 +1000 (EST)
Message-ID: <4FCC6705.1070604@nsn.com>
Date: Mon, 04 Jun 2012 09:43:01 +0200
From: Steffen Rumler <steffen.rumler.ext@nsn.com>
MIME-Version: 1.0
To: ext Wrobel Heinz-R39252 <r39252@freescale.com>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es> <1338542315.16119.50.camel@pasglop>
 <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michael Ellerman <michael@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>> I believe that the basic premise is that you should provide a directly
>>> reachable copy of the save/rstore functions, even if this means that
>> you need several copies of the functions.
>>
>> I just fixed a very similar problem with grub2 in fact. It was using r0
>> and trashing the saved LR that way.
>>
>> The real fix is indeed to statically link those gcc "helpers", we
>> shouldn't generate things like cross-module calls inside function prologs
>> and epilogues, when stackframes aren't even guaranteed to be reliable.
>>
>> However, in the grub2 case, it was easier to just use r12 :-)
> For not just the module loading case, I believe r12 is the only real solution now. I checked one debugger capable of doing ELF download. It also uses r12 for trampoline code. I am guessing for the reason that prompted this discussion.
>
> Without r12 we'd have to change standard libraries to automagically link in gcc helpers for any conceivable non-.text section, which I am not sure is feasible. How would you write section independent helper functions which link to any section needing them?!
> Asking users to create their own section specific copy of helper functions is definitely not portable if the module or other code is not architecture dependent.
> It is a normal gcc feature that you can assign specific code to non-.text sections and it is not documented that it may crash depending on the OS arch the ELF is built for, so asking for a Power Architecture specific change on tool libs to make Power Architecture Linux happy seems a bit much to ask.
>
> Using r12 in any Linux related trampoline code seems a reachable goal, and it would eliminate the conflict to the ABI.
>
> Regards,
>
> Heinz
Hi,

I've tried the fix using register r12 for the trampoline code, instead of register r11.
I'd to adapt entry_matches() too:

--- arch/powerpc/kernel/module_32.c    (revision 1898)
+++ arch/powerpc/kernel/module_32.c    (working copy)
@@ -187,8 +187,8 @@

  static inline int entry_matches(struct ppc_plt_entry *entry, Elf32_Addr val)
  {
-    if (entry->jump[0] == 0x3d600000 + ((val + 0x8000) >> 16)
- && entry->jump[1] == 0x396b0000 + (val & 0xffff))
+    if (entry->jump[0] == 0x3d800000 + ((val + 0x8000) >> 16)
+ && entry->jump[1] == 0x398c0000 + (val & 0xffff))
          return 1;
      return 0;
  }
@@ -215,10 +215,9 @@
          entry++;
      }

-    /* Stolen from Paul Mackerras as well... */
-    entry->jump[0] = 0x3d600000+((val+0x8000)>>16);    /* lis r11,sym@ha */
-    entry->jump[1] = 0x396b0000 + (val&0xffff);    /* addi r11,r11,sym@l*/
-    entry->jump[2] = 0x7d6903a6;            /* mtctr r11 */
+    entry->jump[0] = 0x3d800000+((val+0x8000)>>16); /* lis r12,sym@ha */
+    entry->jump[1] = 0x398c0000 + (val&0xffff);     /* addi r12,r12,sym@l*/
+    entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
      entry->jump[3] = 0x4e800420;            /* bctr */

      DEBUGP("Initialized plt for 0x%x at %p\n", val, entry);


It looks working, also in the case the trampoline code is used.
Please see also the debug session below.

Let me summarize the situation:

    + According to Freescale, EABI assigns a dedicated function to register r11.
    + The ELF sections .text and .init.text may trigger the usage of the trampoline code.
    + The trampoline code must not user register r11, too.
    + We must not depend on addresses returned by vmalloc during kernel module loading.

I think the bug must be fixed !!!

Regards
Steffen

--


(gdb) bt
#0  0xd54990f0 in ?? ()
#1  0xd5499088 in ?? ()
#2  0xc0001d9c in do_one_initcall (fn=0xd76e26ac) at init/main.c:716
#3  0xc0059630 in sys_init_module (umod=0x4802f008, len=<value optimized out>, uargs=0x10012008 "") at kernel/module.c:2470
#4  0xc000dff8 in syscall_dotrace_cont () at arch/powerpc/kernel/entry_32.S:331
Backtrace stopped: frame did not save the PC

<-- we are returning from the driver init entry point

(gdb) info reg r11
r11            0xcbb57f00    3417669376
(gdb) x/2x 0xcbb57f00
0xcbb57f00:    0xcbb57f20    0xc0001d9c

<-- register r11 is fine here

0xd54990f0:     lis     r12,-10386
0xd54990f4:     addi    r12,r12,-20268
0xd54990f8:     mtctr   r12

<-- this is the trampoline code using now r12, instead of r11

(gdb) info reg r12
r12            0xd76db0d4    3614290132
(gdb) info reg ctr
ctr            0xd76db0d4    3614290132
0xd54990fc:     bctr

<-- we are jumping to the epilogue

0xd76db0d4:     lwz     r29,-12(r11)
0xd76db0d8:     lwz     r30,-8(r11)
0xd76db0dc:     lwz     r0,4(r11)
0xd76db0e0:     lwz     r31,-4(r11)
0xd76db0e4:     mtlr    r0
0xd76db0e8:     mr      r1,r11

<- the epilogue

(gdb) info reg lr
lr             0xc0001d9c    0xc0001d9c <do_one_initcall+100>
0xc0001d9c <do_one_initcall+100>:       lis     r9,-16330
0xc0001da0 <do_one_initcall+104>:       lwz     r0,12296(r9)
0xc0001da4 <do_one_initcall+108>:       lis     r9,-16330
0xd76db0ec:     blr

<-- the jump back to do_one_initcall()
<-- no crash

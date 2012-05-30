Return-Path: <michael@ellerman.id.au>
Message-ID: <1338420242.27402.2.camel@concordia>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
From: Michael Ellerman <michael@ellerman.id.au>
To: Steffen Rumler <steffen.rumler.ext@nsn.com>
Date: Thu, 31 May 2012 09:24:02 +1000
In-Reply-To: <4FC62FB9.8010701@nsn.com>
References: <4FC62FB9.8010701@nsn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-05-30 at 16:33 +0200, Steffen Rumler wrote:
> Hi,
> 
> The system crashes inside the return of the init entry point of the kernel module.
> 
> I've found the following root cause:
> 
>      (6) Unfortunately, the trampoline code (do_plt_call()) is using register r11 to setup the jump.
>            It looks like the prologue and epilogue are using also the register r11, in order to point to the previous stack frame.
>            This is a conflict !!! The trampoline code is damaging the content of r11.

Hi Steffen,

Great bug report!

I can't quite work out what the standards say, the versions I'm looking
at are probably old anyway.

Have you tried the obvious fix?

cheers


diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 0b6d796..989d79a 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -205,9 +205,9 @@ static uint32_t do_plt_call(void *location,
        }
 
        /* Stolen from Paul Mackerras as well... */
-       entry->jump[0] = 0x3d600000+((val+0x8000)>>16); /* lis r11,sym@ha */
-       entry->jump[1] = 0x396b0000 + (val&0xffff);     /* addi r11,r11,sym@l*/
-       entry->jump[2] = 0x7d6903a6;                    /* mtctr r11 */
+       entry->jump[0] = 0x3d800000+((val+0x8000)>>16); /* lis r12,sym@ha */
+       entry->jump[1] = 0x398c0000 + (val&0xffff);     /* addi r12,r12,sym@l*/
+       entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
        entry->jump[3] = 0x4e800420;                    /* bctr */
 
        DEBUGP("Initialized plt for 0x%x at %p\n", val, entry);

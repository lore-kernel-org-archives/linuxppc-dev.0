Message-Id: <4.3.2.20000627142525.00b61100@falcon.si.com>
Date: Tue, 27 Jun 2000 14:50:38 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: PLPRCR & Checkstop reset
In-Reply-To: <3958E94D.E55D4294@netx4.com>
References: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com>
 <3958E040.15B86909@netx4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It would be better to not jump to the reset vector on a warm
start.  Often there is hardware configuration issues with rerunning all
the reset code - the primary one is that the IMMR quite likely is in a
different location than the power up default value.

I've seen two conventions.  The one I've seen more often is to jump to
the 4th byte after the reset vector (0xFFF00004).  In this case, the
first reset location is a branch to the coldstart location.

I checked LiMon 1.1 and it uses the (reserved) zeroth vector
(0xFFF00000) for its warmstart location.

gvb


At 01:50 PM 6/27/00 -0400, Dan Malek wrote:
>Dan Malek wrote:
>
> > Here is the first installment.
>
>Let's try this again.......I will actually attach something
>this time.  I am travelling and don't have access to a system
>or enought documentation to attempt checkstop/reset.
>
>
>
>         -- Dan
>--- linux.old/arch/ppc/kernel/m8xx_setup.c      Wed Feb 16 11:43:25 2000
>+++ linux/arch/ppc/kernel/m8xx_setup.c  Tue Jun 27 09:47:27 2000
>@@ -228,9 +240,17 @@
>  void
>  m8xx_restart(char *cmd)
>  {
>-       extern void m8xx_gorom(void);
>+       extern void m8xx_gorom(uint bp, uint startaddr);
>+       uint    startaddr;
>+
>+       startaddr = 0xfff00100;
>+
>+       if (cmd != NULL) {
>+               if (!strncmp(cmd, "startaddr=", 10))
>+                       startaddr = simple_strtoul(&cmd[10], NULL, 0);
>+       }
>
>-       m8xx_gorom();
>+       m8xx_gorom((uint)__pa(res), startaddr);
>  }
>
>  void


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <diggskevin38@gmail.com>
MIME-Version: 1.0
Date: Mon, 8 Nov 2010 10:43:19 -0600
Message-ID: <AANLkTiksY8x7XOifU3FAAPpCa_h4oEBmqu_a0vjRE5h5@mail.gmail.com>
Subject: PowerMac8600 help ...
From: kevin diggs <diggskevin38@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Sorry for the noise but I am having trouble getting the latest kernel
built for a PowerMac8600 with a 750GX processor card. If this is not
an appropriate topic for the list please tell me (and hopefully point
me in the correct direction).

I have narrowed the problem down to the compiler. YDL 4.0 is installed
on the machine. The stock compiler is 3.3.3. That version can NOT
build past 2.6.28. I built 3.4.6, (the latest 3 series I could find).
It can NOT build later kernel versions either. It can build Firefox
2.0.0.15pre, including powerpc thin lock support. Running it now.

I then tried 4.3.5. This will build the kernel. But the resulting
kernel will NOT run. A firefox built with 4.3.5 also will not run. Or
if it runs it crashes often (http://abcnews.com).

What really puzzles me is I used the same basic compiler boot
strapping (3.3.3 to build 3.4.6, 3.4.6 to build 4.3.5) on a GiGE. That
machine is now running 2.6.36.

The CFLAGS used were:  "-O2 -mcpu=7450 -mmultiple -mstring" for the
GiGE (dual 7455s). Substitute 750 for the 8600.

Any suggestions would be appreciated.

Thanks!

kevin

P.S.:  Why does this program work:

int main(int argc, char *argv[])
{
unsigned int pvr;

//      asm("mfspr %0,22\n"
        asm("mfspr %0,287\n"
                :"=r" (pvr)
        );

        printf("pvr is 0x%x\n",pvr);
}

>From what I have read, access to the pvr is restricted? strace does
not show an illegal instruction trap for SPRN_PVR.

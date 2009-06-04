Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20090604180736.GA24902@kroah.com>
References: <20090604133132.19010.16577.sendpatchset@subratamodak.linux.ibm.com>
	<20090604180736.GA24902@kroah.com>
Date: Thu, 4 Jun 2009 22:40:47 +0200
Message-ID: <10f740e80906041340x4f51b5f0ra542b60d758a4b54@mail.gmail.com>
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=UTF-8
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 4, 2009 at 20:07, Greg KH <greg@kroah.com> wrote:
> On Thu, Jun 04, 2009 at 07:01:32PM +0530, Subrata Modak wrote:
>> CC [M] =C2=A0drivers/staging/comedi/drivers.o
>> drivers/staging/comedi/drivers.c: In function =E2=80=98comedi_buf_alloc=
=E2=80=99:
>> drivers/staging/comedi/drivers.c:496: error: =E2=80=98PAGE_KERNEL_NOCACH=
E=E2=80=99 undeclared (first use in this function)
>> drivers/staging/comedi/drivers.c:496: error: (Each undeclared identifier=
 is reported only once
>> drivers/staging/comedi/drivers.c:496: error: for each function it appear=
s in.)
>> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
>> make[2]: *** [drivers/staging/comedi] Error 2
>> make[1]: *** [drivers/staging] Error 2
>> make: *** [drivers] Error 2
>>
>> Is it still normal to expect this failure ?
>
> No.
>
>> I reported them long back during April:
>> http://www.gossamer-threads.com/lists/linux/kernel/1065227,
>
> Yes, and I took some patches that were supposed to fix this. =C2=A0I can'=
t
> duplicate this here, care to send a patch that would fix it?

PAGE_KERNEL_NOCACHE is defined on a few architectures only, namely
frv, m32r, mn10300, sh, and x86[*]. On all others, it will fail.

[*] Interestingly, sparc refers to it in one of its include files,
without providing a
    definition, Probably that code is unused.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

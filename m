Return-Path: <kallepokki@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 7EE4167B62
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 16:15:50 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so493245nfe
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 23:15:48 -0700 (PDT)
Message-ID: <a425f86c0607252315l43c2d64w8b1d10331dd1b9d@mail.gmail.com>
Date: Wed, 26 Jul 2006 09:15:48 +0300
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Clint Thomas" <cthomas@soneticom.com>
Subject: Re: Booting Linux Kernel without bootloader
In-Reply-To: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_216858_12173082.1153894548115"
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_216858_12173082.1153894548115
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/26/06, Clint Thomas <cthomas@soneticom.com> wrote:


> Basically, the system I want linux running on does not require the
> initialization of hardware that U-boot provides, or at least it does not
> need it to boot the linux kernel. I want to load an uncompressed linux
> kernel into memory and start the execution of the kernel, without using any
> kind of bootloader. Is this possible? Or does linux need some kind of
> firmware or other software to tell it to start executing? Thanks for any
> info you might have.
>

Once the hardware is initialised,  it is pretty straightforward to boot the
linux kernel. All you have to have is the kernel at address zero, struct
bd_info filled in some place in memory, kernel command line stored in
memory, and registers r3 ... r7 containing pointers to these.

For reference, look
1) include/asm-ppc/ppcboot.h for example struct bd_info
2) arch/ppc/syslib/m8260_setup.c for the registers

If you have some custom hardware, you need to create (basically empty)
platform code, since the existing ones would try to touch some board control
registers you don't have.

But remember, you need to initialise the memory controller and all sorts of
things yourself somehow - with a JTAG debugger or a custom boot loader.

------=_Part_216858_12173082.1153894548115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/26/06, <b class="gmail_sendername">Clint Thomas</b> &lt;<a href="mailto:cthomas@soneticom.com">cthomas@soneticom.com</a>&gt; wrote:<div><span class="gmail_quote"></span><div><br>
&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div><div><font face="Arial" size="2"><span>Basically, the system I want linux running on does not require the 
initialization of hardware that U-boot provides, or at least it does not need it 
to boot the linux kernel. I want to load an uncompressed linux kernel into 
memory and start the execution of the kernel, without using any kind of 
bootloader. Is this possible? Or does linux need some kind of firmware or other 
software to tell it to start executing? Thanks for any info you might 
have.</span></font></div></div></div></blockquote><div><br>
Once the hardware is initialised,&nbsp; it is pretty straightforward to
boot the linux kernel. All you have to have is the kernel at address
zero, struct bd_info filled in some place in memory, kernel command
line stored in memory, and registers r3 ... r7 containing pointers to
these.<br>
<br>
For reference, look<br>
1) include/asm-ppc/ppcboot.h for example struct bd_info<br>
2) arch/ppc/syslib/m8260_setup.c for the registers<br>
<br>
If you have some custom hardware, you need to create (basically empty)
platform code, since the existing ones would try to touch some board
control registers you don't have.<br>
<br>
But remember, you need to initialise the memory controller and all
sorts of things yourself somehow - with a JTAG debugger or a custom
boot loader.<br>
<br>
<br>
</div></div>

------=_Part_216858_12173082.1153894548115--

Return-Path: <bhupi.saharan@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 055EFDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jun 2007 10:16:44 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so1144758ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jun 2007 17:16:42 -0700 (PDT)
Message-ID: <720399a30706161716p33411412w539dafa91923c74d@mail.gmail.com>
Date: Sat, 16 Jun 2007 17:16:42 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: Regarding MPC8540 IRQ Issue
In-Reply-To: <4673AD08.1080800@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_41007_20782234.1182039402666"
References: <4673AD08.1080800@gmail.com>
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

------=_Part_41007_20782234.1182039402666
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sudhir,

>From the PCI dump it looks like IRQ PIN register is 0. During enumeration
when BIOS sees that IRQ PIN register is 0, it would not allocate any
interrupt for this card and that's why you are seeing IRQ Line register also
as 0 value.

We need to do some work around for this.

 IN the driver you need to register for all the pci vectors( INTA,B,C and
D). You would be called for any interrupt happening on the bus. you have to
check if the interrupt is for you and then claim it otherwise return that
interrupt is not for you.


Regards
Bhupi


On 6/16/07, sudheer <urwithsudheer@gmail.com> wrote:
>
> Hello All
>
> I am working on MPC8540 board placing it in the PCI slot of the x86
> system.
> After system bootup , i could see the powerpc board detected and pci
> config space configured.
> But i could not find any IRQ assigned for it.
>
> SetUp:
> Host: x86 System- Linux-2.6.9
> HOST PCI Slot is 64-bit, 66MHz
> Agent: MPC8540 Board.
>
> Here is dump of "lspci -vx " for this device.
>
> 04:03.0 Power PC: Motorola MPC8540 (rev 20) (prog-if 01)
>         Flags: bus master, 66Mhz, fast devsel, latency 64
>         Memory at dee00000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: [60] #00 [0000]
> 00: 57 10 08 00 46 01 b0 00 20 01 20 0b 00 40 00 00
> 10: 00 00 e0 de 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
>
> From the above dump - IRQ Pin & Line of config space shows zeroes.
>
> I tried writing a small module and probing for IRQ generating a message
> interrupt. Though i could see in the 8540 message status register that
> interrupt is generated, i could not get any IRQ when i do the probe. For
> this trial,  i have configured the PIC message enable register, message
> vector/priority and destination registers, processor current task
> priority register (CPTR).
>
> Can anyone give me some suggestions to try out.
>
> Thanks
> Sudheer
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_41007_20782234.1182039402666
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sudhir,<br><br>From the PCI dump it looks like IRQ PIN register is 0. During enumeration when BIOS sees that IRQ PIN register is 0, it would not allocate any interrupt for this card and that&#39;s why you are seeing IRQ Line register also as 0 value.
<br><br>We need to do some work around for this.<br><br>&nbsp;IN the driver you need to register for all the pci vectors( INTA,B,C and D). You would be called for any interrupt happening on the bus. you have to check if the interrupt is for you and then claim it otherwise return that interrupt is not for you.
<br><br><br>Regards<br>Bhupi<br><br><br><div><span class="gmail_quote">On 6/16/07, <b class="gmail_sendername">sudheer</b> &lt;<a href="mailto:urwithsudheer@gmail.com">urwithsudheer@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello All<br><br>I am working on MPC8540 board placing it in the PCI slot of the x86 system.<br>After system bootup , i could see the powerpc board detected and pci<br>config space configured.<br>But i could not find any IRQ assigned for it.
<br><br>SetUp:<br>Host: x86 System- Linux-2.6.9<br>HOST PCI Slot is 64-bit, 66MHz<br>Agent: MPC8540 Board.<br><br>Here is dump of &quot;lspci -vx &quot; for this device.<br><br>04:03.0 Power PC: Motorola MPC8540 (rev 20) (prog-if 01)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Flags: bus master, 66Mhz, fast devsel, latency 64<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Memory at dee00000 (32-bit, non-prefetchable) [size=1M]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Capabilities: [60] #00 [0000]<br>00: 57 10 08 00 46 01 b0 00 20 01 20 0b 00 40 00 00
<br>10: 00 00 e0 de 00 00 00 00 00 00 00 00 00 00 00 00<br>20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00<br><br> From the above dump - IRQ Pin &amp; Line of config space shows zeroes.
<br><br>I tried writing a small module and probing for IRQ generating a message<br>interrupt. Though i could see in the 8540 message status register that<br>interrupt is generated, i could not get any IRQ when i do the probe. For
<br>this trial,&nbsp;&nbsp;i have configured the PIC message enable register, message<br>vector/priority and destination registers, processor current task<br>priority register (CPTR).<br><br>Can anyone give me some suggestions to try out.
<br><br>Thanks<br>Sudheer<br><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_41007_20782234.1182039402666--

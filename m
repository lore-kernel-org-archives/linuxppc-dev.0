Date: Mon, 2 Jun 2003 13:36:22 -0700
Subject: Re: bootstrap of virtex-ii pro eval board ML300
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-embedded@lists.linuxppc.org
To: =?ISO-2022-JP?B?GyRCQ3o4fDFKGyhC?= <nari_dhy@nari-china.com>
From: Scott Anderson <sanders@mvista.com>
In-Reply-To: <001d01c327db$2824fe60$4c44900a@hydingnb>
Message-Id: <DF2EA3A8-9539-11D7-85A6-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Saturday, May 31, 2003, at 06:14  PM, 丁厚永 wrote:
\We have subscribe the ML300 demo board from xilinx,but it needs several
> months to arrive. I remember someone has done some work in virtex II
> pro demo boards.Will someone tell me some details about the bootstrap's
> procedure of such systems.

A quick high level description from my understanding:
There is a piece of Xilinx hardware called System ACE which reads
a rotary switch to determine which of eight possible files it
should load from the first partition (which must be a FAT partition)
of the IBM MicroDrive.  System ACE initializes the FPGA, processor
and memory by using the contents of this file to manipulate the
JTAG chain.  Xilinx provides tools so that you can combine an
ELF image (e.g. a Linux kernel) with an FPGA bitstream so that
when the processor comes out of reset, your image is already
loaded into memory ready to go.  For your development, I would
suggest using a JTAG debugger (specifically, the Abatron BDI2000)
to load your kernel into memory so that you don't have to keep
mucking with the MicroDrive.  Having the BDI2000 also gives you
a good tool for debugging the kernel and drivers.

    Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

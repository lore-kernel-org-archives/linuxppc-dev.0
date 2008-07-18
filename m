Return-Path: <tehn.yit.chin@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by ozlabs.org (Postfix) with ESMTP id B3450DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 16:29:36 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so189535tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 23:29:34 -0700 (PDT)
Message-ID: <bf04f99c0807172329m7ec94580n194e02b708bf7597@mail.gmail.com>
Date: Fri, 18 Jul 2008 16:29:34 +1000
From: "Tehn Yit Chin" <tehn.yit.chin@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: jumping to code in RAM in a MPC55xx
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_62042_12571893.1216362574217"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_62042_12571893.1216362574217
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This question is not directly related to linux, but a question on how to
execute code from.

My test code is as follows..

void ram(unsigned int cat) __attribute__ ((section(".ram_code")));
void ram1(void) __attribute__ ((section(".ram_code")));
void flash(void) __attribute__ ((section(".text")));
void flash1(unsigned int y) __attribute__ ((section(".text")));

void ram(unsigned int cat)
{
    unsigned int abc;

    abc += 12;
    abc += cat;
}

void ram1(void)
{
    ram(123);
}


void flash1(unsigned int y)
{
    unsigned int x;

    x = x + y;

}

void flash(void)
{
    unsigned int def;

    def += 12;

    asm (" bel ram1\n\t");
}

I have the section .ram_code mapped into the internal SRAM of the MPC55xx,
which starts at 0x40000000. Code in .text are mapped into MPC55xx's internal
FLASH, starting at 0x00000000.

When I attempt to link the code together,  I get the error

U:\src\applications\comms/fatdog.c(35,1): relocation truncated to fit:
R_PPC_REL24 against symbol `ram1' defined in .ram_code section in
U:\src\applications\comms\fatdog.o

I googled the error and I think it means that the ram1() is too far away and
the branch address has been truncated to fit into the binary.

Other than assembler bel instruction, I have also tried bl, b and bea and
all of them gave the same link error.

I was wondering if anyone can give some insight on how I can get the MPC55xx
to branch between FLASH and SRAM?

Many thanks,
Tehn Yit Chin

------=_Part_62042_12571893.1216362574217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>This question is not directly related to linux, but a question on how to execute code from.<br><br>My test code is as follows..<br><br>void ram(unsigned int cat) __attribute__ ((section(&quot;.ram_code&quot;)));<br>
void ram1(void) __attribute__ ((section(&quot;.ram_code&quot;)));<br>void flash(void) __attribute__ ((section(&quot;.text&quot;)));<br>void flash1(unsigned int y) __attribute__ ((section(&quot;.text&quot;)));<br><br>void ram(unsigned int cat)<br>
{<br>&nbsp;&nbsp;&nbsp; unsigned int abc;<br><br>&nbsp;&nbsp;&nbsp; abc += 12;<br>&nbsp;&nbsp;&nbsp; abc += cat;<br>}<br><br>void ram1(void)<br>{<br>&nbsp;&nbsp;&nbsp; ram(123);<br>}<br><br><br>void flash1(unsigned int y)<br>{<br>&nbsp;&nbsp;&nbsp; unsigned int x;<br><br>&nbsp;&nbsp;&nbsp; x = x + y;<br><br>}<br>
<br>void flash(void)<br>{<br>&nbsp;&nbsp;&nbsp; unsigned int def;<br><br>&nbsp;&nbsp;&nbsp; def += 12;<br><br>&nbsp;&nbsp;&nbsp; asm (&quot; bel ram1\n\t&quot;);<br>}<br><br>I have the section .ram_code mapped into the internal SRAM of the MPC55xx, which starts at 0x40000000. Code in .text are mapped into MPC55xx&#39;s internal FLASH, starting at 0x00000000.<br>
<br>When I attempt to link the code together,&nbsp; I get the error <br><br>U:\src\applications\comms/fatdog.c(35,1): relocation truncated to fit: R_PPC_REL24 against symbol `ram1&#39; defined in .ram_code section in U:\src\applications\comms\fatdog.o<br>
<br>I googled the error and I think it means that the ram1() is too far away and the branch address has been truncated to fit into the binary.<br><br>Other than assembler bel instruction, I have also tried bl, b and bea and all of them gave the same link error.<br>
<br>I was wondering if anyone can give some insight on how I can get the MPC55xx to branch between FLASH and SRAM?<br><br>Many thanks,<br>Tehn Yit Chin<br><br></div>

------=_Part_62042_12571893.1216362574217--

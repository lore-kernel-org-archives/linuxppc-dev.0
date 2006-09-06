Return-Path: <yang.reeve@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 746D867BAE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 10:50:08 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so3396528pyc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Sep 2006 17:50:07 -0700 (PDT)
Message-ID: <198592450609051750r70f94750n363e2389f82e3698@mail.gmail.com>
Date: Wed, 6 Sep 2006 00:50:07 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 reset register
In-Reply-To: <53107f6e0609051706i67eac762y114ad03bf2065548@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_122005_27194957.1157503807711"
References: <198592450609021546x57c71e48r9aed561b61f6e8aa@mail.gmail.com>
	<53107f6e0609021647l1f1cd84du496e3cd7219b603@mail.gmail.com>
	<198592450609051149h47423ebev9c94eb8aefc2a3fb@mail.gmail.com>
	<53107f6e0609051706i67eac762y114ad03bf2065548@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_122005_27194957.1157503807711
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

LoL, my bad not understanding the humor.

This becomes an interesting topic. I looked at different CPUs, it seems
everyone uses different method to reset itself, and there is no uniformed or
easy for 603e. I searched on google but didn't see anyone have similiar
concern. Actually lots of boxes/systems using MPC8245, why nobody cares
about it? :)

To use watchdog timeout, or gpio port to assert reset line on CPU are not
flexible enough. If using watchdog, I have to enable watchdog and reduce the
timeout length (if it's too long). If using some GPIO device, I'll have to
rely on i2c bus or whatever io interface to write data. Acutally our system
has RESET by a GPIO(PCA9556) port.

Interesting enough, I resolved the problem by writing a data to an invalid
address with hoping for a machine check exception (in fact this is what
u-boot does). Would it be good to make it as a stardard "restart" function
in mpc10x_common.c? If it's acceptable I could send out my patch.

- Reeve

On 9/6/06, Jon Scully <jonscully@gmail.com> wrote:
>
> On 9/5/06, Reeve Yang <yang.reeve@gmail.com> wrote:
> >  I'm kind of curious what's the proper way to reset the
> > 8245 CPU? For anyone who doesn't know MPC8245, which is 603e core.
>
> You could starve the watchdog (assuming SWE=1 in SYPCR).  If you own
> the hardware design, you could add an addressable WO latch (FPGA) that
> asserts reset for the right number of clock cycles (what I would
> normally provide or ask for in a design -- but *only* during
> development).  Otherwise... If this is for development purposes,
> consider using JTAG (Boundary Scan) to control /SRESET.
>
> (My reference to RST was supposed to be humorous -- as in, remember
> the good old days when you could do that in S/W?! ('RST 7' in Z80 &
> 8085)  Sorry for my bad humor.)
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_122005_27194957.1157503807711
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

LoL, my bad not understanding the humor.<br>
<br>
This becomes an interesting topic. I looked at different CPUs, it seems
everyone uses different method to reset itself, and there is no
uniformed or easy for 603e. I searched on google but didn't see anyone
have similiar concern. Actually lots of boxes/systems using MPC8245,
why nobody cares about it? :)<br>
<br>
To use watchdog timeout, or gpio port to assert reset line on CPU are
not flexible enough. If using watchdog, I have to enable watchdog and
reduce the timeout length (if it's too long). If using some GPIO
device, I'll have to rely on i2c bus or whatever io interface to write
data. Acutally our system has RESET by a GPIO(PCA9556) port.<br>
<br>
Interesting enough, I resolved the problem by writing a data to an
invalid address with hoping for a machine check exception (in fact this
is what u-boot does). Would it be good to make it as a stardard
&quot;restart&quot; function in mpc10x_common.c? If it's acceptable I could send
out my patch.<br>
<br>
- Reeve<br><br><div><span class="gmail_quote">On 9/6/06, <b class="gmail_sendername">Jon Scully</b> &lt;<a href="mailto:jonscully@gmail.com">jonscully@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 9/5/06, Reeve Yang &lt;<a href="mailto:yang.reeve@gmail.com">yang.reeve@gmail.com</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;I'm kind of curious what's the proper way to reset the<br>&gt; 8245 CPU? For anyone who doesn't know MPC8245, which is 603e core.
<br><br>You could starve the watchdog (assuming SWE=1 in SYPCR).&nbsp;&nbsp;If you own<br>the hardware design, you could add an addressable WO latch (FPGA) that<br>asserts reset for the right number of clock cycles (what I would<br>
normally provide or ask for in a design -- but *only* during<br>development).&nbsp;&nbsp;Otherwise... If this is for development purposes,<br>consider using JTAG (Boundary Scan) to control /SRESET.<br><br>(My reference to RST was supposed to be humorous -- as in, remember
<br>the good old days when you could do that in S/W?! ('RST 7' in Z80 &amp;<br>8085)&nbsp;&nbsp;Sorry for my bad humor.)<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_122005_27194957.1157503807711--

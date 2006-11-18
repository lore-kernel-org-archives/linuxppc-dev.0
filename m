Return-Path: <luong.ngo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id A69C667BDF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 11:54:20 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1091412wxd
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 16:54:13 -0800 (PST)
Message-ID: <1b2aacd80611171654i10613a0lfb1d9e2d4350a85b@mail.gmail.com>
Date: Fri, 17 Nov 2006 16:54:13 -0800
From: "Luong Ngo" <luong.ngo@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: RTC , ds1307 I2C driver and NTP does not work.
In-Reply-To: <A4DE4C29-34A0-4C57-BA16-659F89DD0D6D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4848_29709854.1163811253772"
References: <1163781539.21518.27.camel@gentoo-jocke.transmode.se>
	<A4DE4C29-34A0-4C57-BA16-659F89DD0D6D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4848_29709854.1163811253772
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Joakim,
We are having the exact same problem. And if I understand correctly, the
schedule call in i2c-mpc driver is because we are waiting for the interrupt
signaling a byte transfer complete. If the interrupt does not yet come, the
driver call schedule to wait, both for polling mode and interrupt mode.  I
am not sure if it is some problem occurs making the interrupt not coming
quick enough. We still try to resolve. Please let us know if you find a
solution and we definitely will post our finding if we can resolve.

-Ngo

On 11/17/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
>
> On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:
>
> > I get this when I activathte NTP and ntp "sync" the time the I2C HW
> > clock.
>
> You may be better off posting this to lkml and copy the i2c list (and
> rtc if one exists).  Since its more a driver issue than anything
> really ppc specific.  Clearly we are doing schedules() in mpc_xfer()
> and maybe we shouldn't be.
>
> - kumar
>
> > BUG: scheduling while atomic: swapper/0x00010000/0
> > Call Trace:^M
> > [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
> > [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
> > [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
> > [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
> > [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
> > [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
> > [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
> > [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
> > [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
> > [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
> > [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
> > --- Exception: 901 at cpu_idle+0xc8/0xf0
> >     LR = cpu_idle+0xec/0xf0
> > [C0245FC0] [C000388C] rest_init+0x28/0x38
> > [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
> > [C0245FF0] [00003438] 0x3438
> >
> > I have activated RTC CLASS and have this in my board file:
> > #ifdef CONFIG_RTC_CLASS
> > late_initcall(rtc_class_hookup);
> > #endif
> >
> > kernel 2.6.19-rc5
> >
> >  Jocke
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_4848_29709854.1163811253772
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Joakim,<br>We are having the exact same problem. And if I understand correctly, the schedule call in i2c-mpc driver is because we are waiting for the interrupt signaling a byte transfer complete. If the interrupt does not yet come, the driver call schedule to wait, both for polling mode and interrupt mode.&nbsp; I am not sure if it is some problem occurs making the interrupt not coming quick enough. We still try to resolve. Please let us know if you find a solution and we definitely will post our finding if we can resolve.
<br><br>-Ngo<br><br><div><span class="gmail_quote">On 11/17/06, <b class="gmail_sendername">Kumar Gala</b> &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:<br><br>&gt; I get this when I activathte NTP and ntp &quot;sync&quot; the time the I2C HW<br>&gt; clock.<br><br>You may be better off posting this to lkml and copy the i2c list (and
<br>rtc if one exists).&nbsp;&nbsp;Since its more a driver issue than anything<br>really ppc specific.&nbsp;&nbsp;Clearly we are doing schedules() in mpc_xfer()<br>and maybe we shouldn't be.<br><br>- kumar<br><br>&gt; BUG: scheduling while atomic: swapper/0x00010000/0
<br>&gt; Call Trace:^M<br>&gt; [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)<br>&gt; [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618<br>&gt; [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0<br>&gt; [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
<br>&gt; [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8<br>&gt; [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c<br>&gt; [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234<br>&gt; [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M<br>
&gt; [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58<br>&gt; [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc<br>&gt; [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14<br>&gt; --- Exception: 901 at cpu_idle+0xc8/0xf0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; LR = cpu_idle+0xec/0xf0<br>&gt; [C0245FC0] [C000388C] rest_init+0x28/0x38<br>&gt; [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228<br>&gt; [C0245FF0] [00003438] 0x3438<br>&gt;<br>&gt; I have activated RTC CLASS and have this in my board file:
<br>&gt; #ifdef CONFIG_RTC_CLASS<br>&gt; late_initcall(rtc_class_hookup);<br>&gt; #endif<br>&gt;<br>&gt; kernel 2.6.19-rc5<br>&gt;<br>&gt;&nbsp;&nbsp;Jocke<br>&gt;<br>&gt; _______________________________________________<br>&gt; Linuxppc-dev mailing list
<br>&gt; <a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br><br>_______________________________________________
<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote>
</div><br>

------=_Part_4848_29709854.1163811253772--

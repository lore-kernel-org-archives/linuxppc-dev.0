To: "XOL" <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re[4]: How to change Bus speed for MPC8xx CPU 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 May 2003 16:02:07 +0400."
             <E19HMrf-0008UY-00.xol-mail-ru@f9.mail.ru>
Date: Sun, 18 May 2003 18:16:31 +0200
Message-Id: <20030518161636.8EA6FC6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <E19HMrf-0008UY-00.xol-mail-ru@f9.mail.ru> you wrote:
>
> You r right I've posted same message to
> embedded list. I though this is better place for this topic.
> Ok, I can get configuration of
> CPU 100M
> Bus 50M
> Or
> CPU 80M
> Bus 40M
> In the worst case second is ok for me, but
> I have a luck of performance in my system and do not
> want to loose 20% of CPU speed.

There is no other choice.

> So I want to find a way how to get
> CPU 100M
> Bus 40M

You cannot. The MPC8xx CPUs gives you two options: you can select the
EBDF bits in SCCR either for a divider factor of 1 (bus clock ==  CPU
clock) or 2 (bus clock = CPU clock / 2).

No other modes are supported on this platform.

> Also I'm driving a PPC Bus via number of boards in the system
> and 40M can be problematic. So probably I'll need to
> downgrade it to 30/35M.

In this case you have to run the CPU at 60 or 70 MHz, resp.

> This is reason I can't just use multiplier but have to
> find a way control bus speed by myself.

You cannot. Bus clock and CPU clock depend on  each  other,  and  the
only  option is a divider factor of 1 or 2. See the documentation for
the clocks and the SCCR register in the UM.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real till it is experienced -- even a proverb is
no proverb to you till your life has illustrated it.     - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

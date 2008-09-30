Return-Path: <alan@akb.net>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 52A4BDE2D0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Oct 2008 02:46:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so59005wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Sep 2008 09:46:05 -0700 (PDT)
Message-ID: <bfa0697f0809300946m3509f8b6r9720f38dde3e2ce1@mail.gmail.com>
Date: Tue, 30 Sep 2008 10:46:05 -0600
From: embedded <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is successful
In-Reply-To: <48E0E981.60703@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0809261600p7e1af4a6va360d0782cec8257@mail.gmail.com>
	<48E0E981.60703@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Actually, it may have been a simple fix.  Looking at the clocks. We
noticed something a little awry;  Just rechecking the RM and the code
we found that within ep8248.c, the clock setup code had the RX and TX
clocks flipped.

FCC1 RX CLK should be Clock 10
FCC1 TX CLK should be Clock 11

in: arch/powerpc/platforms/82xx/ep8248.c
static void __init init_ioports(void)

-	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);

+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_TX);

-Alan


On Mon, Sep 29, 2008 at 8:43 AM, Scott Wood <scottwood@freescale.com> wrote:
> embedded wrote:
>>
>> We've found a way to get ping to fail all of the time by increasing
>> the size of the ping messages.  When we use the max in Windows of
>> 65500, every ping to the first FCC1 Ethernet is dropped.  However,
>> when we ping with a size of 65500 to the second FCC2 Ethernet
>> everything is fine and all echos are successful.
>>
>> In windows:
>> ping -l 64000 172.24.100.11  -t
>>
>> It definitely seems to be a problem with the mpc, but I'm not sure
>> where to look.  Board? KErnel? boot loader?  The two Ethernet devices
>> should be configured identically, and looking through the kernel code,
>> it seems that there aren't any preferred treatment differences.  Could
>> the problem be in the bit-banging mdio control, or should I look
>> within fs_enet?  We've got this reproducing on all of our boards and
>> it could also reside in the board setup...
>>
>> Does anyone with experience on the ep8248 and/or mpc8272 family,
>> fs_enet-* code have any ideas where I should look next?
>
> It looks very similar to what I was seeing on ep8248 -- the first ethernet
> port would fail when attempting to receive back-to-back packets.  I didn't
> look into it too closely since I thought it was probably a board issue (I
> had only one, and the firmware never generated any traffic that resulted in
> back-to-back receives).
>
> I'd be very interested if you ever figure out what's wrong.
>
> -Scott
>

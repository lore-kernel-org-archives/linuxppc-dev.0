Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EEDF8679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 05:49:40 +1000 (EST)
To: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: what is the MPC8260 spi maximum rate ? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Jul 2006 10:12:19 +0200."
	<44AA22E3.3050701@thales-bm.com>
Date: Tue, 04 Jul 2006 21:49:37 +0200
Sender: wd@denx.de
Message-Id: <20060704194937.021BA353A1D@atlas.denx.de>
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

Hello,

in message <44AA22E3.3050701@thales-bm.com> you wrote:
> 
> It is written in MPC8260 documentation (SPI chapter) : " The maximum 
> sustained data rate that the SPI supports is SYSTEMCLK/50. However the 
> spi can transfer a single character at much higher rates (SYSTEMCLK/4 in 
> master mode)".
> 
> My really stupid question is ...... what is "SYSTEMCLK" ???????
> is it the BRG_CLK ? the CPM_CLK or the CPU_CLK ????

The performance-limiting factor is the CPM, so it's most probably the
CPM clock.

> This question is quite stupid but very important for me in order to know 
> if that controller permit to exchange data with one of our extention 
> board at 1.2 MHz.

Keep in mind that SPI is implemented in software on the CPM, and that
it's running  at  very  low  priority.  All  calculations  assume  an
otherise  unloaded  CPM - but if you add load to the CPM, things will
change.

We haven't run specific measurements on the 8260, but on  the  MPC860
we  ran  into  a  *lot*  of  ugly  SPI problems when the CPM load got
higher, missing interrupts etc. being just one of the issues. At this
time, Motorola added a note to their FAQ  base,  which  stetd  pretty
clear  that  SPI  was  "not designed for high-bandwidth data communi-
cations".

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Due to lack of disk space, this fortune database has been discontinued.

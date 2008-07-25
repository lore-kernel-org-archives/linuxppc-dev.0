Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth05.prod.mesa1.secureserver.net
	(smtpauth05.prod.mesa1.secureserver.net [64.202.165.99])
	by ozlabs.org (Postfix) with SMTP id B80C8DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jul 2008 09:51:04 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 82xx/83xx MCC Super Channels - GUN Error
Date: Fri, 25 Jul 2008 16:50:58 -0700
Message-ID: <B943401BAE76451EB07F7797ED082BEF@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guys,

Attempting to polish up an existing MCC HDLC driver, adding super channels
for an 8360E, though I imagine the specifics an answer, might work for any
82xx or 83xx architecture.

Background:
I have taken my existing working MCC HDLC driver <non-superchanneled>
interfaced to a T1 in clear channel mode, and found that I was using less
than optimized MCC configuration, i.e. using the TX SiRAM entries to
transmit 8 bytes chunks. Though his works, I get GUN errors probably every
10 minutes. So after careful reading, I decided to optimize and create super
channels using the 83xx version <16 bit entries only for 83xx> for the
SiRAM.

Problem:
After the super channel conversion, I now get GUN interrupts continuously
the instant I enable the TDM's / SI. 

Detail:
I have written the extra code to program up the SiRAM entries, RX side to
use super channel 6 <for compatibility with later SATM code, SC must be
divisible by 4 after subtracting 2>, and the TX side uses channels 0-11 <12
channels of 2 bytes = 192 byes of a standard T1 B8ZS-ESF Frame>, my SCT
table of course routes slots 0-11 into SC 6. I am guessing this is correct,
and more likely I probably have a setup problem with configuring all the MCC
parameters, or init sequence.

After reading much Freescale documentation and their FAQ's online, I see
there are a couple of undocumented things that may or may not need to be
done, like stopping a super channel before issues the QE_INIT_TX_RX
commands.

So my question is this:
In order to not have GUN always occurring, how does one initialize a super
channel and its related sub-channels? This what I am doing now.
1) Program SI entries
2) Program MCC global PRAM?
3) Program SuperChannel ChanPRAM
4) Program SuperChannel XtraPRAM
5) Program SuperChannel Table <SCT>
6) Set rstate and tstate once for SuperChannel i.e. channel 6
7) Call QE_INIT_TX_RX once for channel block 0 <i.e. channels 0-31>.
8) Enable TDM's
9) GUN recovery code goes nuts until I reset.

Anybody have experience with this and super channels? I have seen hints that
perhaps I need to maybe set rstate and tstate for every channel in the super
channel, what about the 'first byte' in the SiRAM TX entry? Does that need
to be set for clear channels? I have seen one email for 82xx MCC that say
the super channel needs to be QE_STOP_TX before calling the MCC INIT code,
but not sure if that is really needed, or only for 82xx CPU's. What about
using the QE_INIT_TX_RX_16? I have tried this, and it causes silence in the
driver, i.e. can't even get interrupts if I use this command.

Ideas anyone?

Russell McGuire
Senior Systems Engineer
rmcguire@videopresence.com
503.888.0968

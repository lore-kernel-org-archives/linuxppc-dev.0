Return-Path: <lokowich@acdstar.com>
Received: from g2host.com (mailfront1.g2host.com [208.42.176.212])
	by ozlabs.org (Postfix) with ESMTP id 7E5BFDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 03:01:58 +1100 (EST)
Message-ID: <47542865.30308@acdstar.com>
Date: Mon, 03 Dec 2007 10:01:41 -0600
From: lokowich <lokowich@acdstar.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: SDRAM failures on MPC5200B
References: <46A0D76E.4030101@acdstar.com> <4739ADDC.8010402@acdstar.com>
	<200711131540.18315.roman.fietze@telemotive.de>
In-Reply-To: <200711131540.18315.roman.fietze@telemotive.de>
Content-Type: text/html; charset=ISO-8859-1
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Roman Fietze wrote:
<blockquote cite="mid:200711131540.18315.roman.fietze@telemotive.de"
 type="cite">
  <pre wrap="">Hallo Mark,

On Tuesday 13 November 2007 14:59:56 lokowich wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">A follow-up: The first version of our termination network was based
on the Lite5200 reference design, but was confirmed by Freescale to
be inadequate. We revised the hardware per their errata, terminating
both ends of the data bus. This fixed the problem. Thanks for the
helpful feedback.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If I can remember it correctly, the is no errata on the Freescale
documentation web pages specifying to terminate the SDRAM data lines
on both ends. The only document I can remember that specifies
something similar is AN3045, "A comparison of the MPC5200B (Mask Set
M62C) with prior MPC5200 Versions" on page 2, in the chapter
"1. Overview".

Could you please give me some hint about what errata or other document
we probably missed?
  </pre>
</blockquote>
This is message from Freescale to our HW engineer and was in reference
to Figure 1 in AN3045 <br>
<blockquote type="cite">
  <pre wrap="">A design could avoid termination resistors if the trace delay is less than
1/6 of the rise fall/time, if the output impedance matches the trace
impedance or if the switching waveform is not so important (like PCI
synchronous signals). The first two conditions are not met for MPC5200B DDR
signals with 5 cm traces.

The MPC5200B memory controller's nominal output impedance is 22 Ohms (16..35
worst case range).
The nominal rise/fall time is ~400ps. However, worst case r/f time is about
200ps.

Thus, MPC5200B memory design must include signal terminations. The most
critical signals are memory clocks and DQS. The ringing on these signals (at
the threshold level) is not allowed.
The recommended series resistor value is 20..30 Ohms (may depend on the
load). 
Bidirectional signals (DQM) should have series termination at both ends of
data bus. It is common recommendation for MPC5200B memory design as well as
for MPC5200 Rev.A.

Lite5200B board doesn't follow these recommendations. This was done before
the importance of the correct termination resistors was known. A large
number of the issues people are having in moving from the MPC5200 to the
MPC5200B are caused by not using the correct termination resistors. The
Lite5200B board should not be used as an example.

Memory system design must ensure AC timing specs for MPC5200 and SDRAM.
Memory signals must have valid levels within setup/hold time window. The
ringing caused by the PCB trace reflections must be damped before the input
setup window begins. The ringing reduces time margins provided for signals.
Proper termination of the signal removes the ringing. 

Using proper series termination solves most issues caused by poor signal
integrity. In order to find optimal termination, use IBIS models of MPC5200
and SDRAM to simulate signal waveforms</pre>
</blockquote>
<blockquote cite="mid:200711131540.18315.roman.fietze@telemotive.de"
 type="cite">
  <pre wrap="">
Maybe I have to tell our HW people that it will be necessary to fix
our design as well.


Thank you

Roman

  </pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
</body>
</html>

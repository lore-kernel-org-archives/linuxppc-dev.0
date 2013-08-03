Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A69472C0091
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2013 18:43:31 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: windfarm_fcu_controls: cpu-pump-0 <HW FAULT>
References: <87r4eb52s6.fsf@igel.home>
 <1375481448.15999.47.camel__48019.1930350431$1375481501$gmane$org@pasglop>
Date: Sat, 03 Aug 2013 10:43:26 +0200
In-Reply-To: <1375481448.15999.47.camel__48019.1930350431$1375481501$gmane$org@pasglop>
 (Benjamin Herrenschmidt's message of "Sat, 03 Aug 2013 08:10:48
 +1000")
Message-ID: <m2vc3nnp01.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Can you add some more printk's in there to check what's going on inside
> wf_fcu_get_pump_minmax() ?

All values from mpu->processor_part_num are 0xffff.

> Also is it getting faults for both pumps ?

Yes.

> Does it work with the older driver ? (both the minmax and the reading of
> the pump).

The minmax situation is the same, but otherwise appears to work (no fan
reading errors logged).  Here is an example debug output:

** CPU 1 RPM: 300 Ex, 300, Pump: 1250, In, overtemp: 0
  cpu 0, exhaust RPM: 300
  cpu 0, temp raw: 023c, m_diode: 9982, b_diode: fffff799
  temp: 52.139
  cpu 0, current: 8.789, voltage: 1.286, power: 11.308 W
  cpu 1, exhaust RPM: 300
  cpu 1, temp raw: 021c, m_diode: a047, b_diode: fffff777
  temp: 50.380
  cpu 1, current: 8.666, voltage: 1.281, power: 11.108 W
  power target: 55.000, error: 43.691
  integral: 00f42f8d
   integ_p: 10
   adj_in_target: 65.011, ttarget: 74
   deriv_p: -15
   prop_p: -103
   sum: -118

> What is the "failures" bitmask value ?

3 for both.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

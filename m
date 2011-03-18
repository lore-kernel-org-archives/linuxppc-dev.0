Return-Path: <eliedebrauwer@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FC3AB6FE4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2011 01:32:01 +1100 (EST)
Received: by wwj40 with SMTP id 40so4515861wwj.21
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2011 07:31:56 -0700 (PDT)
Message-ID: <4D836CD7.4060203@gmail.com>
Date: Fri, 18 Mar 2011 15:31:51 +0100
From: Elie De Brauwer <eliedebrauwer@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: i2c on P2020 based boards faulty prescale selection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello list,

A whole bunch of dts file such a p2020ds.dts, p2020rdb.dts and probably 
lots of other variants as well (haven't checked the manuals of the 
others). Claim their i2c controller to be 'fsl-i2c'

If you then look in i2c/busses/i2c.mpc.c this will end up calling 
mpc_i2c_setup_8xxx() in fsl_i2c_probe() with a prescale value of 0 which 
goes to mpc_i2c_get_fdr_8xxx() here prescale gets set to one and the 
divider value gets calculated.

The problem is that the P2020 datasheet mentions: "The serial bit clock 
frequency of SCL is equal to one half the platform (CCB) clock divided 
by the designated divider. Note that the frequency divider value can be 
changed at any point in a program." Implying that the factor two is not 
taken into account. For this to function correctly the prescale value 
should be set to a value two.

Which could be solved by adding another mpc_i2c_data for this type or by 
using the mpc_i2c_data_8543 which also has a prescaler value of two. Or 
to define an alternative structure for the p2020 alike system. However 
at this point I don't know how this varies between the different px0x0 
systems since I have only a p2020 at my disposal. So I would appreciate 
it if somebody with a broader view on this SoCs can up with a usable 
solution.

This issue will only propagate if the dts sets the clock-frequency field 
for the i2c controller in question is set.


gr
E.
-- 
Elie De Brauwer

Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 534B6DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 00:05:16 +1000 (EST)
Message-ID: <48A04717.4040102@harris.com>
Date: Mon, 11 Aug 2008 10:05:11 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Device tree question
References: <489B5350.6050009@harris.com> <1218267682.24157.366.camel@pasglop>
In-Reply-To: <1218267682.24157.366.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------010704040501070505050200"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010704040501070505050200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Thu, 2008-08-07 at 15:56 -0400, Steven A. Falco wrote:
>   
>> I have added a compact flash to the external bus of a Sequoia
>> (PPC440EPx) evaluation board.  It is wired to CS1, and U-boot is set to
>> configure CS1 to be at address 0xc1000000.  U-boot can access the
>> device, and reports the correct partition table, etc. so I believe the
>> hardware is ok.
>>
>> I've created a device-tree entry under the EBC0 section of the
>> sequoia.dts file:
>>
>>                 pata@1,0 {
>>                     compatible = "harris,hydra_temp-pata", "ata-generic";
>>                     bank-width = <2>;
>>                     reg = <1 0 20 1 80 20>;
>>                     reg-shift = <4>;
>>                     pio-mode = <4>;
>>                     interrupts = <27 4>;
>>                     interrupt-parent = <&UIC0>;
>>                 };
>>             };
>>
>> This seems to be correct, because if I turn on debug in prom_parse, I
>> see a translation that looks reasonable:
>>     
>
> Did you check that the resulting physical address was indeed where you
> device is supposed to be addressed ?
>
> Ben
>   

They were wrong - I misinterpreted the reg-shift to be like the "stride"
used by u-boot.  But u-boot uses it as a multiplier, and reg-shift is
truly a shift.  So, I changed the shift to "2", and now the addresses
are correct.  I'm still having problems, but I'll start a new thread,
because the new problem concerns interrupts.

    Thanks,
    Steve


--------------010704040501070505050200
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Benjamin Herrenschmidt wrote:
<blockquote cite="mid:1218267682.24157.366.camel@pasglop" type="cite">
  <pre wrap="">On Thu, 2008-08-07 at 15:56 -0400, Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have added a compact flash to the external bus of a Sequoia
(PPC440EPx) evaluation board.  It is wired to CS1, and U-boot is set to
configure CS1 to be at address 0xc1000000.  U-boot can access the
device, and reports the correct partition table, etc. so I believe the
hardware is ok.

I've created a device-tree entry under the EBC0 section of the
sequoia.dts file:

                pata@1,0 {
                    compatible = "harris,hydra_temp-pata", "ata-generic";
                    bank-width = &lt;2&gt;;
                    reg = &lt;1 0 20 1 80 20&gt;;
                    reg-shift = &lt;4&gt;;
                    pio-mode = &lt;4&gt;;
                    interrupts = &lt;27 4&gt;;
                    interrupt-parent = &lt;&amp;UIC0&gt;;
                };
            };

This seems to be correct, because if I turn on debug in prom_parse, I
see a translation that looks reasonable:
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Did you check that the resulting physical address was indeed where you
device is supposed to be addressed ?

Ben
  </pre>
</blockquote>
<br>
They were wrong - I misinterpreted the reg-shift to be like the
"stride" used by u-boot.  But u-boot uses it as a multiplier, and
reg-shift is truly a shift.  So, I changed the shift to "2", and now
the addresses are correct.  I'm still having problems, but I'll start a
new thread, because the new problem concerns interrupts.<br>
<br>
    Thanks,<br>
    Steve<br>
<br>
</body>
</html>

--------------010704040501070505050200--

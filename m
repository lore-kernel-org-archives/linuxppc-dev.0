Return-Path: <mremski@comcast.net>
Received: from qmta01.westchester.pa.mail.comcast.net
 (qmta02.westchester.pa.mail.comcast.net [76.96.62.24])
 by ozlabs.org (Postfix) with ESMTP id F37D8B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 20:53:38 +1100 (EST)
Date: Fri, 13 Jan 2012 04:53:32 -0500 (EST)
From: Michael Remski <mremski@comcast.net>
To: Martyn Welch <martyn.welch@ge.com>
Subject: Re: spi device from handle
In-Reply-To: <4F0FFA19.7070606@ge.com>
Message-ID: <alpine.BSF.2.00.1201130451250.24364@payne.remski.net>
References: <alpine.BSF.2.00.1201121056330.21456@payne.remski.net>
 <4F0FFA19.7070606@ge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Martyn.  I'll look at that.  The userspace interface is covered by 
the existing "spidev" driver.  The fpga child gets enumerated and added to 
the spi bus as it should, it's just trying to get the "struct spi_device" 
is confounding me.

On Fri, 13 Jan 2012, Martyn Welch wrote:

> On 12/01/12 16:02, Michael Remski wrote:
>> kernel 2.6.33
>>
>> relevant section of dts has:
>> spi@7000 {
>>     fpga0: fpga@0 {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>         compatible = "fsl, espi-fpga";
>>         reg = <0>;
>>         linux,modalias = "spidev";
>>         spi-max-frequency = <1572864>;
>>     };
>> }
>>
>>
>> I have another device driver that needs to talk to this fpga device, but for
>> the life of me I can't figure out the appropriate hooks to get there. The
>> device can be talked to from userland via /dev/spixyx.k, but how do I get to
>> the device from another driver?
>>
>> Any little hints would be appreciated.  Upgrading kernel is not an option
>> (sorry).
>>
>
> We have a FPGA that provides a number of different functions. Each function is
> provided in a distinct register set. We have multiple entries in the DTS, one
> for each piece of functionality. The drivers are then able to bind separately
> against the required registers. So in the case of
> "arch/powerpc/boot/dts/gef_ppc9a.dts", "fpga@4,0", "wdt@4,2000", "wdt@4,2010",
> "pic@4,4000" and "gpio@7,14000" are all provided by the same FPGA and each has
> it's own driver. However, I've just realised our FPGA is memory mapped and
> looking at your DTS snippet yours isn't.
>
> The only clean way I can think about doing it via spi would be to have a
> driver that provides an in-kernel interface to access the functionality in the
> FPGA (which binds to this entry in the DTS), then modify the driver providing
> the user space access to use that and also use that interface for other
> drivers needing access to the FPGA. Depending on the level of extrapolation
> provided by the existing user space driver, this may be possible without
> breaking anything in user space.
>
> Martyn
>
> -- 
> Martyn Welch (Lead Software Engineer)  | Registered in England and Wales
> GE Intelligent Platforms               | (3828642) at 100 Barbirolli Square
> T +44(0)1327322748                     | Manchester, M2 3AB
> E martyn.welch@ge.com                  | VAT:GB 927559189
>

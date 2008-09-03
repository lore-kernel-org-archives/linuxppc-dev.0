Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA04.westchester.pa.mail.comcast.net
	(qmta04.westchester.pa.mail.comcast.net [76.96.62.40])
	by ozlabs.org (Postfix) with ESMTP id 0B6D6DDF5D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 09:26:41 +1000 (EST)
Message-ID: <48BF1D2B.7000408@gmail.com>
Date: Wed, 03 Sep 2008 19:26:35 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v3 1/2] powerpc: Board support for GE Fanuc SBC610
References: <20080826131339.12883.61796.stgit@ubuntu8041.localdomain>	<20080826131344.12883.60435.stgit@ubuntu8041.localdomain>	<7E18A542-EA62-4F5B-992C-8AC3D9562F72@kernel.crashing.org>
	<20080901093529.3a4371f7.martyn.welch@gefanuc.com>
In-Reply-To: <20080901093529.3a4371f7.martyn.welch@gefanuc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martyn Welch wrote:
> On Fri, 29 Aug 2008 07:04:18 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
>> On Aug 26, 2008, at 8:13 AM, Martyn Welch wrote:
>>
>>> +
>>> +		PowerPC,8641@0 {
>>> +			device_type = "cpu";
>>> +			reg = <0x00000000>;
>>> +			d-cache-line-size = <32>;	// 32 bytes
>>> +			i-cache-line-size = <32>;	// 32 bytes
>>> +			d-cache-size = <32768>;		// L1, 32K
>>> +			i-cache-size = <32768>;		// L1, 32K
>>> +			timebase-frequency = <0>;	// From uboot
>>> +			bus-frequency = <0>;		// From uboot
>>> +			clock-frequency = <0>;		// From uboot
>> you can remove these since u-boot will set them.
>>
> 
> Ok.

Only if you update your u-boot version.

>>> +		};
>>> +		PowerPC,8641@1 {
>>> +			device_type = "cpu";
>>> +			reg = <0x00000001>;
>>> +			d-cache-line-size = <32>;	// 32 bytes
>>> +			i-cache-line-size = <32>;	// 32 bytes
>>> +			d-cache-size = <32768>;		// L1, 32K
>>> +			i-cache-size = <32768>;		// L1, 32K
>>> +			timebase-frequency = <0>;	// From uboot
>>> +			bus-frequency = <0>;		// From uboot
>>> +			clock-frequency = <0>;		// From uboot
>> you can remove these since u-boot will set them.

Ditto.

> Will do.
> 
>>> +		};
>>> +	};
>>> +
>>> +	memory {
>>> +		device_type = "memory";
>>> +		reg = <0x00000000 0x40000000>;	// set by u-boot
>> if the comment is zero just set it to <0 0>;
>>
> 
> So "reg = <0x0 0x40000000>;" ?
> 
>>> +	};
>>> +
>> what u-boot version are you using/shipping with these boards?
> 
> U-boot 1.2.0

1.2.0 predates the libfdt support.  You probably don't have any fdt 
support in your u-boot (if you do, it is old and crude and probably 
doesn't any of the fixups that Kumar refers to).

I would strongly recommend you upgrade to the tip o' the tree or at 
least the latest release (1.3.4).  FDT support will be *much* better - 
we now has generic utility routines that fix up lots of stuff for you 
rather than the crufty by-hand fixups (if any) from the 1.2.0 timeframe.

>> Wondering if other props (like cache info, is set by u-boot for you).

Probably none unless Martyn upgrades.

>> - k
> 
> Martyn

HTH,
gvb

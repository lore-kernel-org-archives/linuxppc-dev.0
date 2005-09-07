Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9E345681AF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 02:42:40 +1000 (EST)
Message-ID: <431F187E.4070006@ru.mvista.com>
Date: Wed, 07 Sep 2005 20:42:38 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Mark Brown <broonie@sirena.org.uk>
References: <20050831122556.GA474@projectcolo.org.uk>
	<20050907163428.GA8522@projectcolo.org.uk>
In-Reply-To: <20050907163428.GA8522@projectcolo.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform devices on MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:
> On Wed, Aug 31, 2005 at 01:26:00PM +0100, Mark Brown wrote:
> 
> 
>>I'm having some trouble using the platform device support for the
>>MPC8245 using memory map B, set up using mpc10x_bridge_init().  When
>>that function registers the host bridge it registers addresses
>>0x80000000-0xfebfffff for the bridge but by default (with EUMB mapped to
>>MPC10X_MAPB_EUMB_BASE) the platform devices on the chip are also within
>>this address range.  The problem I'm seeing is that when
>>platform_device_register() comes to call request_resource() on the
>>devices that call fails because the addresses have already been
>>allocated to the PCI host bridge.
> 
> 
> Does anyone have any suggestions as to what I'm doing wrong with this?
> Using kernel 2.6.13 I am currently working around the issue by making
> the platform bus use insert_resource() rather than request_resource() as
> in the patch below but this really seems like the wrong solution.
> 
Yes, that's right. The proper solution (I guess) will be reconfiguration 
  in  mpc10x_bridge_init() so that memory covered by the bridge do not 
intercept anything what pdevs request. Or (less probably) there's 
something odd in pdevs descriptions - if so you need to find out what 
exactly is intercepted with the bridge area.



-- 
Sincerely,
Vitaly

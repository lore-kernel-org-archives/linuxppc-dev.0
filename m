Return-Path: <afleming@freescale.com>
In-Reply-To: <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
	<CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BC83A5D6-4933-11D9-96C5-000393C30512@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 8 Dec 2004 10:10:53 -0600
To: Dan Malek <dan@embeddededge.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: Second Attempt: Driver model usage on embedded processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2004, at 08:53, Dan Malek wrote:
>> The issue I've got with #2 is that some of these devices (and 
>> therefor drivers) will end up existing on various parts from 
>> Freescale that might have an ARM core or PPC core.
>
> If the configuration options are truly static, we can do just like we 
> do today
> with processor cores that share similar peripherals.  Just #define 
> those things
> that are constants and compile them into the driver.  These could be 
> address
> offsets, functional support (like RMON), and so on.  There are examples
> of these drivers that work fine today and could work even better with 
> minor
> touch ups of the configuration options.  You have already #define'd 
> this
> stuff in the board/processor configuration files.  Why put them into a 
> static
> data structure and then find some complex method to access it?  These
> are embedded systems, after all, that want to minimize overhead.

The issue here is that the driver supports devices which can vary in 
features on the same processor.  An example is the gianfar driver for 
the 8540.  The driver supports the two TSEC devices, as well as the 
FEC.  In order to make the driver applicable to different processors 
with different device configurations, the driver needs to be agnostic 
about how many devices there are, and what features they have.  As 
such, defining constants does not solve the problem.

These things could be assigned statically at compile time, in the 
driver, but this means that every new processor will require adding 
#ifdefs to the driver, which will become progressively more difficult 
to maintain.

Anyway, I like the idea of using feature_call.  Are we sure, though, 
that it's not using a hammer for a screw?  I'm not very familiar with 
the function's intent.


Andy Fleming
Open Source Team
Freescale Semiconductor, Inc

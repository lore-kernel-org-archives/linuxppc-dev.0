Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63F69DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 22:58:56 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0IBwidq003476
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 04:58:49 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0IBwg41013723
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:58:43 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 0/3] UCC TDM driver for MPC83xx platforms
Date: Fri, 18 Jan 2008 17:28:41 +0530
Message-ID: <FBA61160C48B8D438F3323FEFB4EF2C279A908@zin33exm24.fsl.freescale.net>
In-Reply-To: <5927F7A4-D42A-40F6-AE9C-EDA34738A752@kernel.crashing.org>
References: <FBA61160C48B8D438F3323FEFB4EF2C259F2F6@zin33exm24.fsl.freescale.net>
	<FBA61160C48B8D438F3323FEFB4EF2C26E7653@zin33exm24.fsl.freescale.net>
	<20080114120051.3207043b.kim.phillips@freescale.com>
	<20080114131530.9d33f50a.akpm@linux-foundation.org>
	<5927F7A4-D42A-40F6-AE9C-EDA34738A752@kernel.crashing.org>
From: "Aggrwal Poonam" <Poonam.Aggrwal@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Andrew Morton" <akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, Phillips Kim <Kim.Phillips@freescale.com>,
	Barkowski Michael <Michael.Barkowski@freescale.com>,
	netdev@vger.kernel.org, Suresh PV <pala@freescale.com>,
	linux-kernel@vger.kernel.org, rubini@vision.unipv.it,
	linuxppc-dev@ozlabs.org, Kalra Ashish <ashish.kalra@freescale.com>,
	Cutler Richard <Rich.Cutler@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All

The TDM driver just now does not have a proper framework. Probably the
interface cannot be generalised as such. Hence we could not decide
whether it would be right to think of a TDM framework. Infact the
interface this TDM driver(for MPC8323ERDB) supplies may not be usable
for some other client as such. Please suggest on this.

But you are right as far as Freescale PowerPC platforms are concerned
which have TDM devices. Like, 8315 also has a TDM driver which also
exposes similar interface as 8323 because the client it is talking to is
the same.

Following is the small description of the TDM driver along with
interface details:

The dts file keeps a track of the TDM devices present on the board.
Depending on them the TDM driver initializes those many driver instances
while coming up.

The driver on the upper level can plug to more than one tdm clients
depending on the availablity  of TDM devices. At every new request of
the TDM client to bind with a TDM device, a free driver  instance is
allocated to the client.

The interface can be described as follows.

tdm_register_client(struct tdm_client *)
	This API returns a pointer to the structure tdm_client which is
of type
	struct tdm_client {
                u32 driver_handle;
                u32 (*tdm_read)(u32 driver_handle, short chn_id, short
*pcm_buffer, short len);
                u32 (*tdm_write)(u32 driver_handle, short chn_id, short
*pcm_buffer, short len);
                wait_queue_head_t *wakeup_event;
        }

   It consists of:
   - driver_handle: It is basically to identify the particular TDM
device/driver instance.
   - tdm_read: It is a function pointer returned by the TDM driver to be
used to read TDM data  form a particular TDM channel.
   - tdm_write: It is a function pointer returned by the TDM driver to
be used to write TDM data  to a particular TDM channel.
   - wakeup_event: It is address of a wait_queue event on which the
client keeps on sleeping,  and the TDM driver wakes it up periodically.
The driver is configured to wake up the client  after every 10ms.

Once the TDM client gets registered to a TDM driver instance and a TDM
device, it interfaces  with the driver using tdm_read, tdm_write and
wakeup_event.

Note: The TDM driver can be used by only kernel level modules. The
driver does not expose any  file interface for User Applications. Can be
compared to the spi driver which interfaces with  the SPI clients
through some APIs.


I need your feedback on the interface details. Some changes were
suggested by Andrew for 32 bit tdm handle which I will modify.(Thanks
Andrew)

Please give your ideas about a TDM framework in the kernel and the
interface.

Waiting for your feedback.

Thanks and Regards
Poonam=20
=20
=20

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Tuesday, January 15, 2008 9:01 AM
To: Andrew Morton
Cc: Phillips Kim; Aggrwal Poonam; sfr@canb.auug.org.au;
rubini@vision.unipv.it; linux-ppcdev@ozlabs.kernel.org;
netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Barkowski Michael;
Kalra Ashish; Cutler Richard
Subject: Re: [PATCH 0/3] UCC TDM driver for MPC83xx platforms


On Jan 14, 2008, at 3:15 PM, Andrew Morton wrote:

> On Mon, 14 Jan 2008 12:00:51 -0600
> Kim Phillips <kim.phillips@freescale.com> wrote:
>
>> On Thu, 10 Jan 2008 21:41:20 -0700
>> "Aggrwal Poonam" <Poonam.Aggrwal@freescale.com> wrote:
>>
>>> Hello  All
>>>
>>> I am waiting for more feedback on the patches.
>>>
>>> If there are no objections please consider them for 2.6.25.
>>>
>> if this isn't going to go through Alessandro Rubini/misc drivers, can

>> it go through the akpm/mm tree?
>>
>
> That would work.  But it might be more appropriate to go Kumar-
> >paulus->Linus.

I'm ok w/taking the arch/powerpc bits, but I"m a bit concerned about =20
the driver itself.  I'm wondering if we need a TDM framework in the =20
kernel.

I guess if Poonam could possibly describe how this driver is actually =20
used that would be helpful.  I see we have 8315 with a discrete TDM =20
block and I'm guessing 82xx/85xx based CPM parts of some form of TDM =20
as well.

- k

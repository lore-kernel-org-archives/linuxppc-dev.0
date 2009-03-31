Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id B2F5DDDDA9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 08:38:22 +1100 (EST)
Received: by gxk1 with SMTP id 1so9906591gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 14:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9A8B45DD4DE17F4783430D784DA0B68811C429F9B7@HEXMBVS12.hostedmsx.local>
References: <mailman.3884.1238431353.26545.linuxppc-dev@ozlabs.org>
	<9A8B45DD4DE17F4783430D784DA0B68811C429F9B7@HEXMBVS12.hostedmsx.local>
Date: Tue, 31 Mar 2009 15:38:20 -0600
Message-ID: <fa686aa40903311438m5bad6765sf2f99b691044953d@mail.gmail.com>
Subject: Re: Interrupts on GPIO
From: Grant Likely <grant.likely@secretlab.ca>
To: Yann Pelletier <ypelletier@haivision.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 2:59 PM, Yann Pelletier
<ypelletier@haivision.com> wrote:
>> Message: 7
>> Date: Mon, 30 Mar 2009 10:32:17 -0600
>> From: Grant Likely <grant.likely@secretlab.ca>
>> Subject: > To: Yann Pelletier <ypelletier@haivision.com>
>> Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
>> Message-ID:
>> =A0 =A0 =A0 <fa686aa40903300932p2c92110g2907bb7bf80d44d@mail.gmail.com>
>> Content-Type: text/plain; charset=3DISO-8859-1
>>
>> On Mon, Mar 30, 2009 at 9:57 AM, Yann Pelletier
>> <ypelletier@haivision.com> wrote:
>> >
>> > Hi,
>> > I'd like to add supports for interrupts handling from GPIO controller.
>> ?Some of these interrupts are from I2C devices and some others are from
>> SPI devices.
>> >
>> > What is the best approach to enable interrupts handling for those
>> devices through GPIO.
>>
>> Modify the GPIO driver to also be a cascaded IRQ driver (see
>> http://patchwork.ozlabs.org/patch/21914/ for an example).
>>
>
> I've looked at the patch but I wonder if this would be applicable to the =
MPC8313. =A0If my understanding is good, in the MPC52xx you have 8 gpio onl=
y interrupts and 8 gpio/gpt. =A0With the MPC8313, each GPIO can act as an i=
nterrupt but they are all muxed to only 1 interrupt in the IPIC. =A0So I'm =
concern about making the GPIO controller act as an interrupt controller.

Why?  The situation really isn't any different.  Using the GPIO
controller hardware as a Linux interrupt controller means that other
drivers can just use it without having to do anything special.  It's
just and IRQ.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

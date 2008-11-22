Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 58418DDDF0
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 02:41:39 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so251138qwb.15
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 07:41:37 -0800 (PST)
Message-ID: <9e4733910811220735o378f785arfa3b577b2420f213@mail.gmail.com>
Date: Sat, 22 Nov 2008 10:35:31 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Gianfranco Casanova" <gianfranco.casanova@alice.it>
Subject: Re: R: R: USB on lite5200 does not work.
In-Reply-To: <4927F7DF.6070605@alice.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
	<fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>
	<fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
	<fa686aa40811210659l3b9a4eefwf6eb59f66386d379@mail.gmail.com>
	<4927F7DF.6070605@alice.it>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you are using a 33.333Mz crystal it is not possible to generate
exactly 48Mhz for USB. Best you can do is 48.11Mz. With a 33Mhz
crystal you can make 48Mhz exactly. But that's probably not your
problem, that just results in errors on the USB bus. Some USB devices
don't care and others will get errors.

On Sat, Nov 22, 2008 at 7:15 AM, Gianfranco Casanova
<gianfranco.casanova@alice.it> wrote:
> Grant Likely ha scritto:
>>
>> On Fri, Nov 21, 2008 at 1:36 AM,  <gianfranco.casanova@alice.it> wrote:
>>>
>>> The main HW difference between our board and lite5200 is:
>>> console on PSC3 and
>>
>> [...]
>>>
>>> on our HW defined as:
>>>        /* Radionav configuration */
>>>        port_config =  0x0C712E66;
>>>
>>
>> You've got quite a bit of difference than just console on PSC3.  USB
>> is on the Ethernet pin group instead of on the USB pin group.  Does
>> the kernel change the value of port_config when it boots, or does it
>> leave the value setup by U-Boot intact?
>
> As far as I sow from debugger no.
>
> We are able to boot with a mini operating system (see previous post).
> Plugging USB the system get frozen.
>
> We have got the same version of kernel compiled on PPC ARCH and USB, in this
> case, works.
>
> Between PPC and PowerPC from debugger there is only one difference the label
> for USB interrupt, in PPC is 50 in PowerPC is 134.
>
> I've already checked CDM register and GPIO register and all are the same.
>
> From USB register only one difference on HDDC values (not important from my
> point of view).
>
> Our processor frequency is different from lite5200. We are thinking that
> scaling frequency processor to determine frequency of USB bus is different
> in PPC and PowerPC. Other street we are looking for is some WR  patchs from
> lite5200 on PowerPC that are not accepted from our HW.
>
>>> I still do not understand our bug with USB.
>>> Have you got some suggestions or some test to be performed in order to
>>> find
>>> out a solutions?
>>
>> Not over a quick exchange via email.
>
> Yes of course :)
>
>> Your kernel is too old and USB
>> debugging can be complex.  I'd need to be working with your hardware
>> to figure out what is going on.
>
> I see. We also wont debug USB.
> Thaks J
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com

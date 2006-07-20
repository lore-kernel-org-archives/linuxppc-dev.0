Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF6AB67BB1
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 23:42:41 +1000 (EST)
In-Reply-To: <a0bc9bf80607200636q785180e0rca1f974c6fe6d127@mail.gmail.com>
References: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
	<93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
	<a0bc9bf80607200636q785180e0rca1f974c6fe6d127@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DAE6213-B8D0-4226-9402-98B4F3FD907B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
Date: Thu, 20 Jul 2006 08:42:58 -0500
To: "Li Yang" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 8:36 AM, Li Yang wrote:

> On 7/20/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Jul 20, 2006, at 6:42 AM, Li Yang-r58472 wrote:
>>
>> > Another one in header file.
>> >
>> > ---
>> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
>> > index 679c1cd..8da2774 100644
>> > --- a/drivers/usb/host/ehci.h
>> > +++ b/drivers/usb/host/ehci.h
>> > @@ -642,7 +642,7 @@ #endif
>> >
>> >
>> > /
>> >  
>> *-------------------------------------------------------------------- 
>> -
>> > -
>> > ---*/
>> >
>> > -#ifdef CONFIG_PPC_83xx
>> > +#ifdef CONFIG_MPC834x
>> >  /* Some Freescale processors have an erratum in which the TT
>> >   * port number in the queue head was 0..N-1 instead of 1..N.
>> >   */
>>
>> Do we really want to make this change.  What harm is there in having
>> the ehci support for MPC834x build on all 83xx processors?  I can't
>> imagine we are going to config in support for ehci on anything that
>> is MPC834x at this point and if you do, your device tree isn't going
>> to have nodes in it so the drivers not going to bind against  
>> anything.
>>
>
> It's not very harmful.  But it will cause some misunderstanding.
> There were already some guys trying to use the 834x USB driver on 836x
> and 832x.  Anyway, it's a trivial patch.  Please apply if it doesn't
> cause much trouble.

Is that more because the QE drivers aren't in the kernel tree?

>> Finally, I got to believe Freescale's going to build some MPC83xx in
>> the future with the high speed USB IP.
>
> I can't tell exactly.  But it's not likely to integrate this IP into a
> chip with QE/CPM support.  As QE/CPM has already provided full speed
> USB support, and the USB speed is not very important for Netcomm
> processors.

True, but not all 83xx are Netcomm processors.

- k

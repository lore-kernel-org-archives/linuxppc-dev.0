Return-Path: <pku.leo@gmail.com>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 6E0DADE287
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 18:02:44 +1000 (EST)
Received: by gxk20 with SMTP id 20so3472453gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:02:41 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1242372791.26759.34.camel@demuxf9c>
References: <1242119872.16400.113.camel@demuxf9c>
	<2a27d3730905130357re0adf41l19f5603a70dac57b@mail.gmail.com>
	<1242372791.26759.34.camel@demuxf9c>
Date: Fri, 15 May 2009 15:56:49 +0800
Message-ID: <2a27d3730905150056m7298b66ckb9db92f9432953d6@mail.gmail.com>
Subject: Re: RapidIO - general questions
From: Li Yang <leoli@freescale.com>
To: Jan Neskudla <jan.neskudla.ext@nsn.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 3:33 PM, Jan Neskudla <jan.neskudla.ext@nsn.com> wr=
ote:
> On Wed, 2009-05-13 at 18:57 +0800, ext Li Yang wrote:
>> cc'ed LKML
>>
>> On Tue, May 12, 2009 at 5:17 PM, Jan Neskudla <jan.neskudla.ext@nsn.com>=
 wrote:
>> > Hallo
>> >
>> > we'd likes to use a RapidIO as a general communication bus on our new
>> > product, and so I have some questions about general design of Linux RI=
O
>> > subsystem. I did not find any better mailing list for RapidIO
>> > discussion.
>> >
>> > [1] - we'd like to implement following features
>> > =C2=A0 =C2=A0* Hot-plug (hot-insert/hot-remove) of devices
>> > =C2=A0 =C2=A0* Error handling (port-write packets - configuration, han=
dling of
>> > them)
>> > =C2=A0 =C2=A0* Static ID configuration based on port numbers
>> > =C2=A0 =C2=A0* Aux driver - basic driver, for sending messages over di=
fferent
>> > mboxes, handling ranges of doorbells
>> >
>> > =C2=A0 =C2=A0Is it here anyone who is working on any improvement, or a=
nyone who
>> > knows the development plans for RapidIO subsystem?
>> >
>>
>> AFAIK, there is no one currently working on these features for Linux.
>> It will be good if you can add these useful features.
> Yes it looks like that, currently we are analyzing current rapidIO
> system, and how we can add these features.
>
>>
>> > [2] - I have a following problem with a current implementation of
>> > loading drivers. The driver probe-function call is based on comparison
>> > of VendorID (VID) and DeviceID (DID) only. Thus if I have 3 devices wi=
th
>> > same DID and VID connected to the same network (bus), the driver is
>> > loaded 3times, instead only once for the actual device Master port.
>>
>> This should be the correct way as you actually have 3 instances of the d=
evice.
>>
>> >
>> > Rionet driver solved this by enabling to call initialization function
>> > just once, and it expect that this is the Master port.
>>
>> Rionet is kind of special. =C2=A0It's not working like a simple device
>> driver, but more like a customized protocol stack to support multiple
>> ethernet over rio links.
>>
>> >
>> > Is it this correct behavior =C2=A0? It looks to me that RapidIO is han=
dled
>> > like a local bus (like PCI)
>>
>> This is correct behavior. =C2=A0All of them are using Linux device/drive=
r
>> infrastructure, but rionet is a special device.
>
> But I do not have a 3 devices on one silicon. I am talking about 3
> devices (3 x EP8548 boards + IDT switch) connected over rapidIO through
> the switch. And in this case I'd like to have only one driver siting on
> the top of Linux RapidIO subsystem. I don't see the advantage of loading

You are having one driver, but it probes 3 times for each device using
the driver.

> a driver locally for remote device. Am I missing something =C2=A0?

If you want to interact with the remote device, you need the driver to
do the work locally.

>
> And one more think, I am getting so much Bus errors OOPSes. Whenever
> there is a problem with a comunication over Rio I get such a kernel OPS.
> I had to add some delays into some function to be able to finish the
> enum+discovery process. Did you have some experience with some bigger
> rio network running under linux ?

It looks like an known issue for switched rio network, but I don't
have the correct equipment to reproduce the problem here.  Could you
do some basic debugging and share your findings?  Thanks.

- Leo

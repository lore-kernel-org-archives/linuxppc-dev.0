Return-Path: <rlefevre@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 1680CDDF34
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 02:10:18 +1100 (EST)
Received: by qyk14 with SMTP id 14so5895771qyk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 07:10:16 -0800 (PST)
Message-ID: <4e0b9cb00812170710n3374d558xab3584dc61980756@mail.gmail.com>
Date: Wed, 17 Dec 2008 16:10:16 +0100
From: "Remi Lefevre" <rlefevre@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: FHCI driver adaptation for CPM2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a few questions with regard to adapting the FHCI USB host
controller driver (for QE) from Anton Vorontsov to CPM2, based
on past discussions from linuxppc-dev & linuxppc-embedded.

http://ozlabs.org/pipermail/linuxppc-dev/2008-April/054253.html
>On Tuesday 08 April 2008 14:16, Anton Vorontsov wrote:
>> On Mon, Apr 07, 2008 at 06:11:15PM +0200, Laurent Pinchart wrote:
>> > I had a first go at hacking the FHCI driver to make it run on a CPM2
>> > platform. Results so far are quite good. After getting rid of qe-speci=
fic
>> > APIs as explained above, and adding SOF token generation support, I've
>> > been able to access a mass storage device. The driver hasn't been
>> > stress-tested yet though.
>>
>> Wow, awesome! That's great news, really. Looking forward for the patch. =
:-)
>
>The current version of the code is CPM2-specific and won't work on QE-base=
d
>platforms. Should I still post it ?

Has this CPM2  patch adaptation been posted somewhere ?
I will have soon to evaluate an USB disk on MPC8270 and it would be great t=
o
spend time working on adapting the patch to last gpio changes and trying to
merge it with the original QE patch rather than doing this work again.

http://ozlabs.org/pipermail/linuxppc-embedded/2008-June/030541.html
>Laurent Pinchart-4 wrote:
>The bad news is that, from my experience with the CPM2, the controller is
>almost unusable. It eats around 40% CPU time on my MPC8248 system, and
>requires software help to generate SOF tokens, which results in bad SOF
>tokens being sent on the bus. Most USB disks don't seem to care, but all t=
he
>USB Bluetooth host controllers I've tested crashed.

Does this mean than SOF tokens handling can be ignored when working with
USB disks, or only that they don't care of a few errors ?

Also 40% seems quite a lot, even at 1000Hz interruptions, an idea how much
does the CRC computation contribute in this CPU hogging ?

Best regards,
R=E9mi Lef=E8vre

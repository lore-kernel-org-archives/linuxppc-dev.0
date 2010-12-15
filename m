Return-Path: <neiljay@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 6DBC2B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 21:17:03 +1100 (EST)
Received: by gxk20 with SMTP id 20so1260909gxk.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 02:17:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTinE1sPt4YQJGgW7-RHOsA8vF9HB-joSuryYFXpi@mail.gmail.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
	<20101210224402.GA8943@kroah.com>
	<AANLkTinE1sPt4YQJGgW7-RHOsA8vF9HB-joSuryYFXpi@mail.gmail.com>
Date: Wed, 15 Dec 2010 10:17:00 +0000
Message-ID: <AANLkTikOituTX-gTQrr7cr2bXdbvf=A2UqHX0yVf8UDP@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Neil Jones <neiljay@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=UTF-8
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've looked at the patches but your email states there are 10 patches,
I can't see #1 and #10, only 2- 8 ??

It doesn't look like you have resolved the lockdep issues we have been
seeing, please get in contact as it
would be good to discuss our issues with this driver ( and our distain
for Synopsis ;-) ).

Cheers

Neil

On Mon, Dec 13, 2010 at 3:48 PM, Neil Jones <neiljay@gmail.com> wrote:
> Hi,
>
> We are currently using the latest version of this Synopsis IP in some
> of our customers SoC's.
>
> The latest hardware adds a new DMA mode which is less Interrupt
> intensive as well as a few other features.
>
> I have spent (and im still spending) a long time fixing up this driver
> to be linux standards compliant with the intention of pushing it
> upstream once complete, its still not ready yet.
>
> One of the major issues we had is the driver isn't SMP safe, I've not
> had chance to review your patches yet but have your run the driver
> with lock checking turned on ?
>
> Would it be possible to get the changes for the latest version of the
> IP merged into this driver, I can supply my current version as a
> reference.
>
> In my driver :
>
> Currently host support is working well and i've tested it with
> multiple devices and done the test outlined on
> http://www.linux-usb.org/usbtest/, the driver passed checkpatches and
> runs with lockdeps on and on a SMP system, Im still working on the
> device mode (PCD) part of the driver generally it works, but im still
> getting the odd lock dep warning and a panic on un-loading of certain
> gadget kernel modules. The only issue with our driver is I have not
> converted all the bitfield usage to macros so it might make diffing a
> pain.
>
> Cheers
>
> Neil
>
> On Fri, Dec 10, 2010 at 10:44 PM, Greg KH <greg@kroah.com> wrote:
>> On Wed, Dec 08, 2010 at 04:28:59PM -0800, tmarri@apm.com wrote:
>>> From: Tirumala Marri <tmarri@apm.com>
>>>
>>> v6:
>>> =C2=A01. Replaced register definitions and bit fields with macros.
>>> =C2=A02. Replace printks with dev_dbg or dev_err functions.
>>> =C2=A03. Cleanup some assignments.
>>> =C2=A04. Remove chip specific selections in Kconfig file.
>>
>> There are still a lot of checkpatch errors and warnings in these
>> patches. =C2=A0Patch 1-8 has:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0total: 64 errors, 126 warnings, 13905 lines c=
hecked
>>
>> Care to fix all of these up in your next submission? =C2=A0I can't take =
these
>> as-is, sorry.
>>
>> And, if you haven't run checkpatch.pl before, odds are you haven't run
>> 'sparse'. =C2=A0Please run that as well and resolve the issues it finds.
>>
>> thanks,
>>
>> greg k-h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>>
>

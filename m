Return-Path: <remis.developer@googlemail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by ozlabs.org (Postfix) with ESMTP id 7F38CDDF4F
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 00:36:14 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so838489rne.16
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Feb 2009 05:36:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200901311125.34755.arnd@arndb.de>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
	<4983BFA2.9010703@am.sony.com> <200901311125.34755.arnd@arndb.de>
Date: Sun, 1 Feb 2009 14:28:09 +0100
Message-ID: <a25370a30902010528l2c11444ch843da0bfd91d05f@mail.gmail.com>
Subject: Re: Dynamic-ftrace not working in PlayStation3
From: Remis <remis.developer@googlemail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Complementing what Arnd said, we got the dynamic ftrace to work. Just
changed 4 things in the *menuconfig*.
Before these were built as modules (this is the default I guess):
CONFIG_USB=m
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_USB_AUDIO=m

Then got them built into the kernel:
CONFIG_USB=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_USB_AUDIO=y

And everything worked just fine.
In my config when I also tried to build the *CONFIG_SND_PS3* into the
kernel, the kernel did not boot (probably another bug !? :-).

Cheers,
Remis

On Sat, Jan 31, 2009 at 11:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 31 January 2009, Geoff Levand wrote:
>> >
>> > So I take it that the above showed that the code worked for some?
>>
>> In my trials it blows up on the first load_module() call, and for my
>> config that was usbcore:
>
> I looked into it some more with Remis yesterday, and we got ftrace
> working by building usbcore and alsa into the kernel. Incidentally,
> usbcore is the largest module in this installation (~3MB), which
> indicates that it is in some way either related to the size of the
> module.
>
>> This ptr of 5f666f725f726573 seems bogus.  I think this code is not
>> working correctly:
>
> This is an ascii string "_for_res", probably part of
> usb_lock_device_for_reset. We saw the same behaviour, but
> a different string.
>
>        Arnd <><

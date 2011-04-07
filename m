Return-Path: <vapier.adi@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B037AB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 04:58:15 +1000 (EST)
Received: by gyg8 with SMTP id 8so1304125gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Apr 2011 11:58:11 -0700 (PDT)
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <4D9E04F0.5010004@ronetix.at>
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
	<4D9E04F0.5010004@ronetix.at>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 7 Apr 2011 14:57:51 -0400
Message-ID: <BANLkTinTWwLB0gi0qKQfCYQ8x6PTuL9-uA@mail.gmail.com>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
To: RONETIX - Asen Dimov <dimov@ronetix.at>
Content-Type: text/plain; charset=UTF-8
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Daniel Walker <dwalker@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 7, 2011 at 14:39, RONETIX - Asen Dimov wrote:
> On 11/30/2010 09:25 PM, Daniel Walker wrote:
>> This driver adds a basic console that uses the arm JTAG
>> DCC to transfer data back and forth. It has support for
>> ARMv6 and ARMv7.
>>
>> This console is created under the HVC driver, and should be named
>> /dev/hvcX (or /dev/hvc0 for example).
>>
>> =C2=A0drivers/char/Kconfig =C2=A0 | =C2=A0 =C2=A09 +++
>> =C2=A0drivers/char/Makefile =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/char/hvc_dcc.c | =C2=A0133
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>
> ...
>
> this DCC driver implements "one channel", but what about implementing
> "multiple channels". For example reserve few(3) bits for channel number,
> and two bits for carried data, then fill the rest bytes with with some da=
ta
> and send the word(32 bits) over DCC. On the Linux side writing on /dev/hv=
cX
> puts the number X as channel number, and on the other side the CPU
> emulator gets the data and redistribute it to TCP/IP socket.
>
> I have started write some code implementing this. Are there any one
> interested
> in this multiple channels, and are there any one started to work on it?

this sort of multiplexing of the data stream sounds like the job for
userspace ?  or maybe a line discipline ?  inserting structured data
into the kernel driver doesnt sound right to me ...
-mike

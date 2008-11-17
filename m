Return-Path: <timur.tabi@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 9D030DDF40
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 07:04:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so1053904and.39
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 12:04:39 -0800 (PST)
Message-ID: <ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
Date: Mon, 17 Nov 2008 14:04:38 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: david@gibson.dropbear.id.au, "Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
In-Reply-To: <20081024035434.GF4267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024035434.GF4267@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:

> This can be used to quickly implement a userspace usable console while
> you're working on a proper driver for whatever console I/O device the
> hardware has.  Or, it can be used to avoid writing a full blown
> tty/console driver entirely for quick-and-dirty I/O hardware that will
> later be replaced by something else.

Ok, I think I understand this better now.

Your approach seems backwards to me.  HVC console client drivers
already have simple put/get functions.  You've written an hvc driver
that makes udbg calls.  Wouldn't it have been better to make a udbg
driver that makes hvc calls?  That way, you effectively give udbg
support to all hvc drivers in one shot.

In order to support udbg in my hvc driver, I have to add udbg calls.
In fact, now that I've thought about it, I don't understand what your
driver does.  You take hvc callbacks and route them through udbg, but
this only works on drivers that have udbg callbacks in the first
place.  In that case, why would these drivers need an hvc middle-man?

-- 
Timur Tabi
Linux kernel developer at Freescale

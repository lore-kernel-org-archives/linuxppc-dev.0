Return-Path: <mlcreech@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 5ED8ADDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 02:20:38 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c38so373455ana.39
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Apr 2009 08:20:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49D498E0.80603@mlbassoc.com>
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
	<49D280E0.9020701@mlbassoc.com>
	<5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>
	<49D28A7E.2090703@mlbassoc.com>
	<5ee96a840903311522t10af5c64n53ab6f834ad475ff@mail.gmail.com>
	<5ee96a840904011153qc052002i8c35229ca3e85c6c@mail.gmail.com>
	<49D498E0.80603@mlbassoc.com>
Date: Thu, 2 Apr 2009 11:20:22 -0400
Message-ID: <5ee96a840904020820s4d27c322q5d6a652f072a6c0b@mail.gmail.com>
Subject: Re: MPC83xx console : no output after handover
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 2, 2009 at 6:52 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>
> Can you share what you had and what you changed it to? =A0I'm
> running on very similar systems and may face this exact problem
> soon.
>
> Thanks
>

I don't actually have a platform-specific bus, but I misread the help
text for CONFIG_SERIAL_OF_PLATFORM and thought that it applied to any
system whose serial port was configured via the DTS file.  So I had:

CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
...
CONFIG_SERIAL_OF_PLATFORM=3Dy

The result was that my console's serial port was initialized correctly
by the 8250 driver, but then of_platform_serial_probe() immediately
stomped on it.  (Not sure what it was doing exactly, I just traced
through far enough to see that printk() worked before
serial8250_register_port() was called in of_serial.c, and not
afterward).

The "fix" for me was simply to disable CONFIG_SERIAL_OF_PLATFORM, as
it's unnecessary in my case.

--=20
Matthew L. Creech
